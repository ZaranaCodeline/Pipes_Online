import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_constant/app_colors.dart';
import '../custom_widget/widgets/custom_widget/custom_button.dart';
import '../custom_widget/widgets/custom_widget/custom_text.dart';
import 'home_screen_widget.dart';

class ConfirmOrderPage extends StatelessWidget {
  const ConfirmOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: CustomText(
          alignment: Alignment.centerLeft,
          text: 'CONFIRM ORDER',
          fontWeight: FontWeight.w700,
          fontSize: 22,
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
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(child: Image.asset('assets/images/confirm_img.png')),
          Center(
            child: CustomText(
              text: 'Your Order has been \n placed successfully !!',
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: AppColors.secondaryBlackColor,textAlign: TextAlign.center,),
          ),
          CustomText(
            text:
            'You can check your order process in my \n orders section.',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.hintTextColor,textAlign: TextAlign.center,),
          CustomText(
            text:
            'My Orders',
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: AppColors.primaryColor,textAlign: TextAlign.center,),
          Custombutton(
            name: 'Get Started',
            function: () => Get.to(() => HomePage()),
            height: Get.height * 0.07,
            width: Get.width / 2,
          ),
        ],
      ),
    );
  }
}
