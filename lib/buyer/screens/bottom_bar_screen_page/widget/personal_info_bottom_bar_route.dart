import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/screens/personal_info_page.dart';
import 'package:pipes_online/buyer/view_model/b_bottom_bar_controller.dart';

BBottomBarIndexController bottomBarIndexController = Get.find();

Widget personalInfoSubScreen() {
  switch (bottomBarIndexController.selectedScreen.value) {
    case 'PersonalInfoPage':
      return PersonalInfoPage();
      break;

    default:
      return PersonalInfoPage();
  }
}