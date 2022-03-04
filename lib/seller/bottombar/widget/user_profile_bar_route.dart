import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:pipes_online/seller/view/s_screens/s_profile_screen.dart';

import '../../../buyer/screens/drawer_profile_page.dart';
import '../../../routes/bottom_controller.dart';

BottomController homeController = Get.find();

Widget userSubScreen() {
  switch (homeController.selectedScreen.value) {
    case 'UserUpdateProfileScreen':
      return DrawerProfilePage();
        // SProfileScreen();
      break;
    // case 'AddCartScreen':
    //   return AddCartScreen();
    //   break;
    // case 'WishListScreen':
    //   return WishListScreen();
    //   break;
    default:
      return DrawerProfilePage();
  }
}
