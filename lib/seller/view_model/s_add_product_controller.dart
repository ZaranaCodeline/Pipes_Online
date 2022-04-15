import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
class AddProductController extends GetxController{

  // TextEditingController productName = TextEditingController();
  // TextEditingController desc = TextEditingController();
  // TextEditingController price = TextEditingController();
  // TextEditingController imageUrl = TextEditingController();

  String _selectedPrice='';

  String get selectedPrice => _selectedPrice;

  set selectedPrice(String value) {
    _selectedPrice = value;
    update();
  }

  String _name='';

  String get name => _name;

  set name(String value) {
    _name = value;
    update();
  }
  String _images='';

  String get images => _images;

  set images(String value) {
    _images = value;
    update();
  }
  String _prices='';

  String get prices => _prices;

  set prices(String value) {
    _prices = value;
    update();
  }
  String _descs='';

  String get descs => _descs;

  set descs(String value) {
    _descs = value;
    update();
  }


  File? image;
  final picker = ImagePicker();

  Future getGalleryImage() async {
    var imaGe = await picker.getImage(source: ImageSource.gallery);
      if (imaGe != null) {
        image = File(imaGe.path);
        print("=============ImagePath==========${imaGe.path}");
        imageCache!.clear();
      } else {
        print('no image selected');
      }
  }
  Future getCamaroImage() async {
    var imaGe = await picker.getImage(source: ImageSource.camera);
    print("==========ImagePath=============${imaGe!.path}");
      if (imaGe != null) {
        image = File(imaGe.path);
        print("===========ImagePath============${image}");
        print("=============ImagePath==========${imaGe.path}");
        imageCache!.clear();
      } else {
        print('no image selected');
      }
  }





}