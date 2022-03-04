import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/view_model/b_bottom_bar_controller.dart';

BBottomBarIndexController bottomBarIndexController = Get.find();

Widget chatSubScreen() {
  switch (bottomBarIndexController.selectedScreen.value) {
    case 'ChatPage':
      return Container();
        // ChatPage();
      break;

    default:
      return Container();
        // ChatPage();
  }
}
