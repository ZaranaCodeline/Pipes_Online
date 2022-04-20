import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/screens/b_cart_page.dart';
import 'package:pipes_online/buyer/screens/b_product_cart_screen.dart';
import 'package:pipes_online/buyer/view_model/b_bottom_bar_controller.dart';

BBottomBarIndexController bottomBarIndexController = Get.find();

Widget cartSubScreen() {
  switch (bottomBarIndexController.selectedScreen.value) {
    case 'ProductCartScreen':
      return ProductCartScreen();

    case 'CartPage':
      return CartPage();

    default:
      return ProductCartScreen();
  }
}
