import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/seller/common/s_text_style.dart';
import 'package:sizer/sizer.dart';

import '../app_constant/app_colors.dart';
import 'custom_widget/custom_text.dart';

class TermsAndConditionPage extends StatelessWidget {
  const TermsAndConditionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'TERMS & CONDITIONS',
          style: STextStyle.bold700White14,
        ),
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: Get.height * 0.1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.sp,
        ),
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.02,
            ),
            CustomText(
              text: 'Terms and conditions for Users',
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              color: AppColors.secondaryBlackColor,
              textAlign: TextAlign.start,
              alignment: Alignment.topLeft,
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            CustomText(
                text:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna,aliqua.',
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                color: AppColors.secondaryBlackColor),
            SizedBox(
              height: Get.height * 0.02,
            ),
            CustomText(
                text:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna,aliqua.',
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                color: AppColors.secondaryBlackColor),
            SizedBox(
              height: Get.height * 0.05,
            ),
            CustomText(
              text: '1. Services',
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              color: AppColors.secondaryBlackColor,
              textAlign: TextAlign.start,
              alignment: Alignment.topLeft,
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            CustomText(
                text:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna,aliqua.',
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                color: AppColors.secondaryBlackColor),
          ],
        ),
      ),
    );
  }
}
