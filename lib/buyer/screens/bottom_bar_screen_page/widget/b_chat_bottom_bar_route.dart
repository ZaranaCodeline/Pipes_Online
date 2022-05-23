import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/screens/b_chat_screen.dart';
import 'package:pipes_online/buyer/view_model/b_bottom_bar_controller.dart';

BBottomBarIndexController bottomBarIndexController = Get.find();

Widget chatSubScreen() {
  switch (bottomBarIndexController.selectedScreen.value) {
    case 'BChatScreen':
      return BChatScreen();
      break;

    default:
      return BChatScreen();
  }
}
