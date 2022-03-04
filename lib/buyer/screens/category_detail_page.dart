import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/screens/product_card_list.dart';

import '../../seller/common/s_text_style.dart';

class BCategoryDetailsPage extends StatelessWidget {
  const BCategoryDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Catefory Detail Page',
          style: STextStyle.bold700White14,
        ),
        leading: BackButton(color: AppColors.commonWhiteTextColor,),
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: Get.height * 0.09,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
      ),
       body: ProductCardList(),
    );
  }
}
