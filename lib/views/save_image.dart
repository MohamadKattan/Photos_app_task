import 'package:flutter/material.dart';
import 'package:image_list_test/components%20/ctm_appbar.dart';
import 'package:image_list_test/models/save_image_model.dart';
import 'package:image_list_test/views/prview_image.dart';
import 'package:provider/provider.dart';

import '../controllers/save_image_controller.dart';

class SaveImageScreen extends StatelessWidget {
  const SaveImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final list = context.watch<ImageController>().listOfSavedImage;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.read<ImageController>().delforEver(),
          child: const Icon(Icons.delete_forever),
        ),
        appBar: CustomAppBar(
          txtTitle: 'Сохраненные изображения',
          context: context,
        ),
        body: list.isNotEmpty
            ? _cardImage(context, list)
            : const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.image_not_supported_rounded, size: 80),
                    Text('Нет сохраненного изображения')
                  ],
                ),
              ),
      ),
    );
  }

  Widget _cardImage(BuildContext context, List<SaveImageModel> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (_, i) {
        return GestureDetector(
          onTap: () => _navToPrviewScreen(list, i, context),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(4),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(8)),
                child: Image.network(
                  list[i].url,
                  height: 200.0,
                  width: list[i].width.toDouble(),
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
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(Icons.zoom_out_map_sharp,
                      size: 35, color: Colors.black),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _navToPrviewScreen(List<SaveImageModel> list, int i, BuildContext context) {
    SaveImageModel saveImageModel = SaveImageModel(
        imageId: list[i].imageId,
        checkSaved: list[i].checkSaved,
        url: list[i].url,
        height: list[i].height,
        width: list[i].width);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PrviewAnImage(
          oneImageData: saveImageModel,
          indexSavedImage: i,
        ),
      ),
    );
  }
}
