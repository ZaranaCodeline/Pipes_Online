import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/screens/b_personal_info_page.dart';
import 'package:pipes_online/seller/view/s_screens/s_prosonal_info_page.dart';
// import 'package:pipes_online/seller/view/s_screens/s_profile_screen.dart';

import '../../../routes/bottom_controller.dart';

BottomController homeController = Get.find();

Widget userSubScreen() {
  switch (homeController.selectedScreen.value) {
    case 'SPersonalInfoPage':
      return SPersonalInfoPage();

    // case 'AddCartScreen':
    //   return AddCartScreen();
    //   break;
    // case 'WishListScreen':
    //   return WishListScreen();
    //   break;
    default:
      return SPersonalInfoPage();
  }
}
