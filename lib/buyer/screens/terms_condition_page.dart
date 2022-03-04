import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_constant/app_colors.dart';
import '../custom_widget/widgets/custom_widget/custom_text.dart';

class TermsAndConditionPage extends StatelessWidget {
  const TermsAndConditionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          alignment: Alignment.centerLeft,
          text: 'TERMS & CONDITIONS',
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
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomText(
                text: 'Terms and conditions\nfor Users',
                fontWeight: FontWeight.w600,
                fontSize: 25,
                color: AppColors.secondaryBlackColor,
                textAlign: TextAlign.start,
                alignment: Alignment.topLeft,
              ),
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            CustomText(
                text:
                    'Lorem ipsum dolor sit amet, consectetur \n  adipiscing elit, sed do eiusmod tempor\n incididunt ut labore et dolore magna,aliqua.',
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: AppColors.secondaryBlackColor),
            SizedBox(
              height: Get.height * 0.05,
            ),
            CustomText(
                text:
                'Lorem ipsum dolor sit amet, consectetur \n  adipiscing elit, sed do eiusmod tempor\n incididunt ut labore et dolore magna,aliqua.',
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: AppColors.secondaryBlackColor),
            SizedBox(
              height: Get.height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomText(
                text: '1. Services',
                fontWeight: FontWeight.w600,
                fontSize: 25,
                color: AppColors.secondaryBlackColor,
                textAlign: TextAlign.start,
                alignment: Alignment.topLeft,
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            CustomText(
                text:
                'Lorem ipsum dolor sit amet, consectetur \n  adipiscing elit, sed do eiusmod tempor\n incididunt ut labore et dolore magna,aliqua.',
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: AppColors.secondaryBlackColor),
          ],
        ),
      ),
    );
  }
}
