import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/screens/b_home_screen_widget.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_button.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';

import '../app_constant/app_colors.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({Key? key}) : super(key: key);

//get_start_logo
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: Get.height * 0.01,
          ),
          Center(
            child: Image.asset('assets/images/png/get_start_logo.png'),
          ),
          Center(
            child: CustomText(
              text: 'Add products in cart \n and shop now',
              fontWeight: FontWeight.w600,
              fontSize: 30,
              color: AppColors.primaryColor,
              textAlign: TextAlign.center,
            ),
          ),
          CustomText(
            text:
                'You can buy pipes from this App in \ndifferent categories such as plastic,\ncopper, iron and steel.',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: AppColors.hintTextColor,
            textAlign: TextAlign.center,
          ),
          Custombutton(
            name: 'Get Started',
              // function:(){}
              // _bottomController.selectedScreen('SCatelogeHomeScreen');
              // _bottomController.bottomIndex.value=0;
            function: () => Get.to(() => CatelogeHomeWidget()),
            height: Get.height * 0.07,
            width: Get.width / 2,
          ),
        ],
      ),
    );
  }
}
