import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import 'package:pipes_online/app_constant/app_colors.dart';
import 'package:pipes_online/custom_widget/widgets/custom_widget/custom_text.dart';
import '../screens/get_otp_screen_page.dart';
import 'widgets/custom_widget/custom_button.dart';

class CustomMobileScreenWidget extends StatelessWidget {
  const CustomMobileScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.05,
              ),
              CustomText(
                text: 'Mobile No.',
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: AppColors.primaryColor,
                alignment: Alignment.topLeft,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              TextField(
                // controller: _controller,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  hintText: 'Enter Mobile Number',
                  suffixIcon: Custombutton(
                    name: 'Get OTP',
                    function: () => Get.to(() => GetOTPScreenPage()),
                    height: Get.height * 0.05,
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              CustomText(
                text: 'OTP',
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: AppColors.primaryColor,
                alignment: Alignment.topLeft,
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              const TextField(
                // controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  hintText: 'Enter OTP',
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Custombutton(
                  name: 'Login', function: () {}, height: Get.height * 0.06),
              SizedBox(
                height: Get.height * 0.05,
              ),
              CustomText(
                text: 'Or Login with',
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColors.secondaryBlackColor,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              SignInButton(
                Buttons.Google,
                onPressed: () {
                  // loginwithgoogle();
                },
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                      text: 'Don’ have an account?',
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.secondaryBlackColor),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  TextButton(
                    onPressed: () {
                      // Get.to(() => SignInPageWidget());
                    },
                    child: CustomText(
                        text: 'Sing Up',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppColors.primaryColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
