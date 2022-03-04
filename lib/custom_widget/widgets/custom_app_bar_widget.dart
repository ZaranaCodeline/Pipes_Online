import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_constant/app_colors.dart';
import 'custom_widget/custom_text.dart';

class CustomAppBarWidget extends StatelessWidget {
  const CustomAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          alignment: Alignment.centerLeft,
          text: 'PERSONAL INFORMATION',
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: AppColors.commonWhiteTextColor,
        ),
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: Get.height * 0.1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
      ),
    );
  }
}
