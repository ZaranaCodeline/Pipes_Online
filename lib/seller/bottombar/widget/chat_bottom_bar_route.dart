import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/seller/view/s_screens/s_chat_screen.dart';

import '../../../routes/bottom_controller.dart';

BottomController homeController = Get.find();

Widget SchatScreenRoute() {
  print('---BOTTOM SCHOOL--${homeController.selectedScreen}');
  switch (homeController.selectedScreen.value) {
    case 'SchatScreen':
      return const SChatScreen();

    default:
      return const SChatScreen();
  }
}
