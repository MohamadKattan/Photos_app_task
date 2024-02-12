import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';

import '../components /ctm_appbar.dart';
import '../controllers/save_image_controller.dart';
import '../models/save_image_model.dart';

class PrviewAnImage extends StatelessWidget {
  final SaveImageModel oneImageData;
  final int? indexSavedImage;
  const PrviewAnImage(
      {super.key, required this.oneImageData, this.indexSavedImage});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(context: context, txtTitle: 'Превью'),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _saveImageOrDelete(context),
          child: Icon(oneImageData.imageId == null ? Icons.save : Icons.delete),
        ),
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.black,
              height: size.height,
              width: size.width,
              child: PhotoView.customChild(
                enableRotation: true,
                childSize: Size(oneImageData.width.toDouble(),
                    oneImageData.height.toDouble()),
                basePosition: Alignment.center,
                child: Image.network(oneImageData.url, fit: BoxFit.contain),
              ),
            ),
            context.watch<ImageController>().isLouding
                ? Container(
                    height: size.height,
                    width: size.width,
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(child: CircularProgressIndicator()),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  Future _saveImageOrDelete(BuildContext context) async {
    if (oneImageData.imageId != null && indexSavedImage != null) {
      bool res = await context
          .read<ImageController>()
          .deleteOneImage(indexSavedImage!, oneImageData.imageId!);
      if (!context.mounted) return;
      if (res) Navigator.pop(context);
    } else {
      SaveImageModel newSaveIamge = SaveImageModel(
          checkSaved: oneImageData.checkSaved,
          url: oneImageData.url,
          height: oneImageData.height,
          width: oneImageData.width);
      await context
          .read<ImageController>()
          .saveAnImageToLocal(newSaveIamge, context);
    }
  }
}
