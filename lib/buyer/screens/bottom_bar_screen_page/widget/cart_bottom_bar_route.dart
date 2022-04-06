import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/screens/cart_page.dart';
import 'package:pipes_online/buyer/screens/category_detail_page.dart';
import 'package:pipes_online/buyer/view_model/b_bottom_bar_controller.dart';

BBottomBarIndexController bottomBarIndexController = Get.find();

Widget cartSubScreen() {
  switch (bottomBarIndexController.selectedScreen.value) {
    case 'CartPage':
      return CartPage();





    default:
      return CartPage();
  }
}
