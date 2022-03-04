import 'package:country_code_picker/country_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class BDrawerController extends GetxController {
  bool readOnly = true;

  void setEdit() {
    readOnly = !readOnly;
    print('readOnly: $readOnly');
    update();
  }
}
