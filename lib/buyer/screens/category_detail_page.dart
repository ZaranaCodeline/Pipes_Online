import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/screens/product_card_list.dart';

import '../../seller/common/s_text_style.dart';
import 'bottom_bar_screen_page/widget/cart_bottom_bar_route.dart';

class BCategoryDetailsPage extends StatelessWidget {
  const BCategoryDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Catefory Detail Page',
            style: STextStyle.bold700White14,
          ),
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
          backgroundColor: AppColors.primaryColor,
          toolbarHeight: Get.height * 0.09,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25),
            ),
          ),
        ),
         body: ProductCardList(),
      ),
    );
  }
}
