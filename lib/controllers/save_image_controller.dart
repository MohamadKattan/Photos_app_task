import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_list_test/components%20/tost_msg.dart';

import '../models/images_model.dart';
import '../models/save_image_model.dart';
import '../utils/constants.dart';
import 'local_db.dart';
import '../client_srv/api_status.dart';
import '../client_srv/https_srv.dart';
import '../error_handler/http_error.dart';

class ImageController extends ChangeNotifier {
  bool _isLouding = false;
  bool get isLouding => _isLouding;

  final List<SaveImageModel> _listOfSavedImage = [];
  List<SaveImageModel> get listOfSavedImage => _listOfSavedImage;

  final List<ImagesModel> _listResult = [];
  List<ImagesModel> get listResult => _listResult;

  _checkIsLouding(bool state) {
    _isLouding = state;
    notifyListeners();
  }

  Future getListOfImagesFromApi(
      {bool? isDown, required BuildContext context}) async {
    _checkIsLouding(true);
    String? url;
    if (isDown ?? false) {
      if (_listResult[0].continuationToken != null) {
        url = '$apiUrl?continuationToken=${_listResult[0].continuationToken}';
      }
    }
    _listResult.clear();
    final response = await HttpSrv().getData(url: url ?? apiUrl);
    if (response is Success) {
      Map<String, dynamic> map = response.response as Map<String, dynamic>;
      ImagesModel newImagesModel = ImagesModel.fromMap(map['result']);
      _listResult.add(newImagesModel);
    }
    if (response is Failur) {
      if (!context.mounted) return;
      await getListOfImagesFromApi(context: context);
      return ErrorHttpHandler(code: response.code).displayErrorHttp();
    }
    _checkIsLouding(false);
  }

  Future saveAnImageToLocal(
      SaveImageModel newSaveIamge, BuildContext context) async {
    _checkIsLouding(true);
    if (_listOfSavedImage.isEmpty) {
      await LocalDBController().setDataToDataBase(map: newSaveIamge.toJson());
      TostMsg().displayTostMsg(
          msg: 'Изображение успешно сохранено', color: Colors.green);
      if (!context.mounted) return;
      await readDataFromLocal(context);
    } else {
      bool res = _listOfSavedImage
          .where(
              (element) => element.checkSaved.contains(newSaveIamge.checkSaved))
          .isNotEmpty;

      if (res) {
        TostMsg().displayTostMsg(
            msg: 'Изображение уже существует', color: Colors.orange);
      } else {
        await LocalDBController().setDataToDataBase(map: newSaveIamge.toJson());
        TostMsg().displayTostMsg(
            msg: 'Изображение успешно сохранено', color: Colors.green);
        if (!context.mounted) return;
        await readDataFromLocal(context);
      }
    }
    _checkIsLouding(false);
  }

  Future readDataFromLocal(BuildContext context) async {
    _checkIsLouding(true);
    _listOfSavedImage.clear();
    List res = await LocalDBController().readData();
    for (var i in res) {
      SaveImageModel saveImageModel = SaveImageModel.fromMap(i);
      _listOfSavedImage.add(saveImageModel);
    }
    _checkIsLouding(false);
  }

  Future<bool> deleteOneImage(int index, int id) async {
    _checkIsLouding(true);
    _listOfSavedImage.removeAt(index);
    await LocalDBController().deleteOneItem(idItem: id);
    _checkIsLouding(false);
    TostMsg().displayTostMsg(msg: 'успешно удалено', color: Colors.grey);
    return true;
  }

  Future<bool> delforEver() async {
    _checkIsLouding(true);
    _listOfSavedImage.clear();
    await LocalDBController().deleteAll();
    _checkIsLouding(false);
    TostMsg().displayTostMsg(msg: 'успешно удалено', color: Colors.grey);
    return true;
  }
}
