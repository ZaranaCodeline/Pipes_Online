import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SSubScribeController extends GetxController {
  String? radioValue;

  void setRadioValue(val) {
    radioValue = val;
    print('radioValue---: $radioValue');
    update();
  }

}