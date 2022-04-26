import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditProductContoller extends GetxController {
  dynamic selectedName = 'AAA'.obs;

  TextEditingController? nameController;

  String selectedPrice = '';
  String selectedCatName = '';
  String selecteddesc = '';
  String selectedImage = '';
  String id = '';

  void selectedID(String value) {
    id = value;
    update();
  }

  void selectedProductPrice(String price) {
    selectedPrice = price;
    update();
  }

  void selectedProductName(String pName) {
    selectedName = pName;
    update();
  }

  void selectedCategoryName(String cName) {
    selectedCatName = cName;
    update();
  }

  void selectedImages(String image) {
    selectedImage = image;
    update();
  }

  void selectedDescription(String dsc) {
    selecteddesc = dsc;
    update();
  }

  String _dsc = '';

  String get selectedPName => _dsc;

  set selectedDesc(String value) {
    _dsc = value;
    update();
  }
  //
  // String _images = '';
  // String get images => _images;
  //
  // set images(String value) {
  //   _images = value;
  //   update();
  // }
}
