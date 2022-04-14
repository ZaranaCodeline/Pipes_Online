import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/seller/view/s_screens/s_chat_screen.dart';

import '../../../routes/bottom_controller.dart';

BottomController homeController = Get.find();

Widget SchatScreenRoute() {
  print('---BOTTOM SCHOOL--${homeController.selectedScreen}');
  switch (homeController.selectedScreen.value) {
    case 'SchatScreen':
      return SChatScreen();

    case 'SchatScreen':
      return SChatScreen();

    // case 'SchoolScreen':
    //   return SchoolScreen();
    //   break;
    // case 'SubCategoryList':
    //   return SubCategoryList(
    //     onPress: () {
    //       homeController.selectedScreen('SchoolDetailScreen');
    //     },
    //     willPopScope: () {
    //       homeController.selectedScreen('SchoolDetailScreen');
    //
    //       return Future.value(false);
    //     },
    //   );
      break;
    // case 'BookItemClassScreen':
    //   return BookItemClassScreen();
    //   break;
    // case 'AddCartScreen':
    //   return AddCartScreen();
    //   break;
    // case 'WishListScreen':
    //   return WishListScreen();
    //   break;
    // case 'ProductDetailScreen':
    //   return ProductDetailScreen(
    //     onPress: () {
    //       homeController.selectedScreen('SubCategoryList');
    //     },
    //     willPopScope: () {
    //       homeController.selectedScreen('SubCategoryList');
    //       return Future.value(false);
    //     },
    //   );
      break;

    default:
      return SChatScreen();
  }
}
