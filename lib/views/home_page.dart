import 'package:flutter/material.dart';
import 'package:image_list_test/components%20/ctm_appbar.dart';
import 'package:image_list_test/components%20/ctm_drawer.dart';
import 'package:image_list_test/models/images_model.dart';
import 'package:image_list_test/models/save_image_model.dart';
import 'package:provider/provider.dart';

import '../controllers/save_image_controller.dart';
import '../utils/constants.dart';
import '../utils/responsive_utils.dart';
import 'prview_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = ScrollController();
  bool val = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _asyncMethods();
    });
  }

  @override
  Widget build(BuildContext context) {
    ImageController imageController = context.watch<ImageController>();
    ResponsiveUtils.checkResponsive(context);
    return SafeArea(
      child: Scaffold(
          drawer: const CustomDrawer(),
          appBar: CustomAppBar(context: context, txtTitle: 'Список изображений'),
          body: imageController.isLouding
              ? const Center(child: CircularProgressIndicator())
              : _body(imageController.listResult)),
    );
  }

  Widget _body(List<ImagesModel> list) {
    return list.isNotEmpty
        ? GridView.builder(
            primary: false,
            controller: _controller,
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.all(8),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columnsCount,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 2 / 2,
            ),
            itemBuilder: (BuildContext context, int i) {
              return _cardImage(list, i, context);
            },
            itemCount: list[0].items?.length)
        : const Center(child: CircularProgressIndicator());
  }

  _cardImage(List<ImagesModel> list, int i, BuildContext context) {
    final newList = list[0].items![i];
    return GestureDetector(
      onTap: () => _navToPrviewScreen(list, i),
      child: Card(
        child: Image.network(
          newList.variants![0].url!,
          fit: BoxFit.fill,
          loadingBuilder:
              (BuildContext context, Widget child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!.toInt()
                    : null,
              ),
            );
          },
        ),
      ),
    );
  }

  _navToPrviewScreen(List<ImagesModel> newImagesModel, int i) {
    SaveImageModel saveImageModel = SaveImageModel(
        checkSaved: newImagesModel[0].items![i].id!,
        url: newImagesModel[0].items![i].variants![indexVariants ?? 0].url!,
        height:
            newImagesModel[0].items![i].variants![indexVariants ?? 0].height!,
        width:
            newImagesModel[0].items![i].variants![indexVariants ?? 0].width!);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => PrviewAnImage(oneImageData: saveImageModel)));
  }

  Future<void> _asyncMethods() async {
    _controller.addListener(
      () async {
        if (_controller.position.atEdge) {
          bool isTop = _controller.position.pixels == 0;
          if (isTop) {
            val = false;
          } else {
            val = true;
            if (val) {
              await context
                  .read<ImageController>()
                  .getListOfImagesFromApi(context: context, isDown: val);
              if (_controller.hasClients) {
                _controller.jumpTo(0);
              }
            }
          }
        }
      },
    );
  }
}
