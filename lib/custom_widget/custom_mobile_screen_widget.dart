import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import 'package:pipes_online/app_constant/app_colors.dart';
import 'package:pipes_online/custom_widget/widgets/custom_widget/custom_text.dart';
import '../screens/get_otp_screen_page.dart';
import '../screens/personal_info_page.dart';
import 'widgets/custom_widget/custom_button.dart';
import 'widgets/check_terms_and_condition_widget.dart';

class CustomMobileScreenWidget extends StatelessWidget {

  final bool? isLogin;

  const CustomMobileScreenWidget({Key? key, this.isLogin}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: Get.height / 1.4,
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.04,
              ),
              CustomText(
                text: 'Mobile No.',
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: AppColors.primaryColor,
                alignment: Alignment.topLeft,
              ),
              SizedBox(
                height: Get.height * 0.01,
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
                    height: Get.height * 0.05,width: Get.width / 3,
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
                height: Get.height * 0.01,
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
                height: Get.height * 0.02,
              ),
             isLogin! ? SizedBox(): const Expanded(
                child: CheckTermsAndConditionWidget(),
              ),
              Custombutton(
                  name: isLogin! ? 'Login': 'Sign Up',
                  function: () {
                    //temporory
                    Get.to(() => CustomPersonalInfoPage());
                  },
                  height: Get.height * 0.06,width: Get.width / 3,),
              SizedBox(
                height: Get.height * 0.01,
              ),
              CustomText(
                text:  isLogin! ? 'Or Login with': 'Or Sign Up with' ,
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
                      text:  isLogin!? 'Don’ have an account?':'Already registered?',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: AppColors.secondaryBlackColor),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  TextButton(
                    onPressed: () {
                      // Get.to(() => SignInPageWidget());
                    },
                    child: CustomText(
                        text: isLogin! ? 'Sign Up':'Login',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
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
