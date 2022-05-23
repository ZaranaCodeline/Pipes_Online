import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/seller/view/s_screens/s_show_subscription_val_screen.dart';

import '../../../routes/bottom_controller.dart';
import '../../view/s_screens/s_add_product_screen.dart';
import '../../view/s_screens/s_cateloge_home_screen.dart';
import '../../view/s_screens/s_edit_product_screen.dart';
import '../../view/s_screens/s_selected_product_screen.dart';
import '../../view/s_screens/s_subscribe_screen.dart';

BottomController homeController = Get.find();

Widget categorySubScreen() {
  print("..>>>>>>${homeController.selectedScreen.value}");
  switch (homeController.selectedScreen.value) {
    case 'SCatelogeHomeScreen':
      return SCatelogeHomeScreen();

    case 'SSelectedProductScreen':
      return SSelectedProductScreen();

    case 'SSubscribeScreen':
      return SSubscribeScreen();

    case 'SShowSubcriptionValueScreen':
      return SShowSubcriptionValueScreen();

    case 'SAddProductScreen':
      return SAddProductScreen();

    case 'SeditProductScreen':
      return SeditProductScreen();

    default:
      return SCatelogeHomeScreen();
  }
}
