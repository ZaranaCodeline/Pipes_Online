import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/screens/b_category_detail_page.dart';
import 'package:pipes_online/buyer/screens/b_home_screen_widget.dart';
import 'package:pipes_online/buyer/view_model/b_bottom_bar_controller.dart';

BBottomBarIndexController bottomBarIndexController = Get.find();

Widget homeSubScreen() {
  switch (bottomBarIndexController.selectedScreen.value) {
    case 'HomeScreen':
      return CatelogeHomeWidget();

    case 'BCategoryDetailsPage':
      return BCategoryDetailsPage();

    default:
      return CatelogeHomeWidget();
  }
}
