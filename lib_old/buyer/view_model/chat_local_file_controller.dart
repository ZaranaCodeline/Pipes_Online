import 'dart:io';

import 'package:get/get.dart';

class LocalFileController extends GetxController {

  RxList<File> _fileImageArray = <File>[].obs;

  RxList<File> get fileImageArray => _fileImageArray;

  void addFileImageArray(File value) {
    _fileImageArray.add(value);
    update();
  }

  void clearImage() {
    _fileImageArray.clear();
    update();
  }
}