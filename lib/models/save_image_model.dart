import 'package:image_list_test/utils/constants.dart';

class SaveImageModel {
  int? imageId;
  String checkSaved = '';
  String url = '';
  int height = 0;
  int width = 0;
  SaveImageModel(
      {this.imageId,
      required this.checkSaved,
      required this.url,
      required this.height,
      required this.width});

  SaveImageModel.fromMap(Map<String, dynamic> map) {
    imageId = map[kId];
    checkSaved = map[kCheckSaved];
    url = map[kUrlImage];
    height = map[kHeight];
    width = map[kWidth];
  }

  Map<String, Object> toJson() {
    var map = <String, Object>{
      kCheckSaved: checkSaved,
      kUrlImage: url,
      kHeight: height,
      kWidth: width
    };
    if (imageId != null) {
      map[kId] = imageId!;
    }
    return map;
  }
}
