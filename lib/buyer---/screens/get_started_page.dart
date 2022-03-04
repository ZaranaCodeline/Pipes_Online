import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_constant/app_colors.dart';
import '../authentificaion/views/login_page.dart';
import '../authentificaion/views/sign_up_page.dart';
import '../custom_widget/widgets/custom_widget/custom_button.dart';
import '../custom_widget/widgets/custom_widget/custom_text.dart';
import 'home_screen_widget.dart';

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
            child: Image.asset('assets/images/get_start_logo.png'),
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
            function: () => Get.to(() => HomePage()),
            height: Get.height * 0.07,
            width: Get.width / 2,
          ),
        ],
      ),
    );
  }
}
