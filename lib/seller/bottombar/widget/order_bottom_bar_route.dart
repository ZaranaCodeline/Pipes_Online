import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/seller/view/s_screens/s_order_screen.dart';

import '../../../routes/bottom_controller.dart';

BottomController homeController = Get.find();

Widget homeSubScreen() {
  switch (homeController.selectedScreen.value) {
    default:
      return SOrdersScreen();
  }
}
