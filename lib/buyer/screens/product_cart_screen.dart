import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/seller/view/s_screens/s_text_style.dart';

import 'bottom_bar_screen_page/widget/b_home_bottom_bar_route.dart';

class ProductCartScreen extends StatelessWidget {
  const ProductCartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                if (bottomBarIndexController.bottomIndex.value == 1) {
                  bottomBarIndexController.setSelectedScreen(
                      value: 'HomeScreen');
                  bottomBarIndexController.bottomIndex.value = 0;
                } else {
                  Get.back();
                }
              },
              icon: Icon(Icons.arrow_back_rounded)),
          title: Text(
            'cart'.toUpperCase(),
            style: STextStyle.bold700White14,
          ),
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          toolbarHeight: Get.height * 0.1,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25),
            ),
          ),
        )
    );
  }
}
