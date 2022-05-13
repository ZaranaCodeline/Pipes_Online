import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddProductController extends GetxController {
  String _selectedSubscribeTime = '';

  String get selectedSubscribeTime => _selectedSubscribeTime;

  set selectedSubscribeTime(String value) {
    _selectedSubscribeTime = value;
    update();
  }

  String _selectedSubscribe = '';

  String get selectedSubscribe => _selectedSubscribe;

  set selectedSubscribe(String value) {
    _selectedSubscribe = value;
    update();
  }

  String _selectedPrice = '';

  String get selectedPrice => _selectedPrice;

  set selectedPrice(String value) {
    _selectedPrice = value;
    update();
  }

  String _name = '';

  String get name => _name;

  set name(String value) {
    _name = value;
    update();
  }

  String _images = '';

  String get images => _images;

  set images(String value) {
    _images = value;
    update();
  }

  String _prices = '';

  String get prices => _prices;

  set prices(String value) {
    _prices = value;
    update();
  }

  String _descs = '';

  String get descs => _descs;

  set descs(String value) {
    _descs = value;
    update();
  }

  String _cat = '';

  String get category => _cat;

  set category(String value) {
    _cat = value;
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
    if (await Permission.camera.request().isGranted) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.camera,
      ].request();
      print(statuses[Permission.camera]);
      final imaGe = await picker.pickImage(source: ImageSource.camera);

      if (imaGe != null) {
        // setState(() {
        // _image = File(imaGe.path);
        // });

        print("=============ImagePath==========${imaGe.path}");
      } else {
        print('no image selected');
      }
      // Either the permission was already granted before or the user just granted it.
    }

// You can request multiple permissions at once.
  }
}
