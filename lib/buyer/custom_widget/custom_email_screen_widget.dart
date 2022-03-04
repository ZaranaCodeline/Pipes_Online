import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:get/get.dart';
import '../app_constant/app_colors.dart';
import '../authentificaion/functions.dart';
import 'widgets/custom_widget/custom_button.dart';
import 'widgets/check_terms_and_condition_widget.dart';
import 'widgets/custom_widget/custom_text.dart';

class CustomEmailScreenWidget extends StatefulWidget {
  final bool? isLogin;

  CustomEmailScreenWidget({Key? key, this.isLogin}) : super(key: key);

  @override
  State<CustomEmailScreenWidget> createState() =>
      _CustomEmailScreenWidgetState();
}

class _CustomEmailScreenWidgetState extends State<CustomEmailScreenWidget> {
  bool isLoading = false;

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            height: Get.height / 1.4,
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.05,
                ),
                CustomText(
                  text: 'Email',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: AppColors.primaryColor,
                  alignment: Alignment.topLeft,
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    hintText: 'Enter Email',
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                CustomText(
                  text: 'Password',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: AppColors.primaryColor,
                  alignment: Alignment.topLeft,
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    hintText: 'Enter Password',
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                widget.isLogin!
                    ? SizedBox()
                    : const Expanded(
                        child: CheckTermsAndConditionWidget(),
                      ),
                Custombutton(
                  name: widget.isLogin! ? 'Login' : 'Sign Up',
                  function: () {},
                  height: Get.height * 0.06,
                  width: Get.width / 3,
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                CustomText(
                  text: widget.isLogin! ? 'Or Login with' : 'Or Sign Up with',
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
                        text: widget.isLogin!
                            ? 'Don’ have an account?'
                            : 'Already registered?',
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: AppColors.secondaryBlackColor),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    TextButton(
                      onPressed: () {
                        // AuthController.instance.register(
                        //   emailController.text.trim(),
                        //   passwordController.text.trim(),
                        // );
                      },
                      child: TextButton(
                        onPressed: (){
                          // Get.to(()=>SignUpPage());
                        },
                        child: CustomText(
                            text: widget.isLogin! ? 'Sing Up' : ' Login',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: AppColors.primaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void performLogin() {
  //   if (emailController.text.trim().isNotEmpty &&
  //       passwordController.text.trim().isNotEmpty) {
  //     isLoading = true;
  //     createAccount(emailController.text.trim().toString(),
  //             passwordController.text.trim().toString())
  //         .then((user) {
  //       if (user != null) {
  //         setState(() {
  //           isLoading = false;
  //           print('Login Successfully');
  //         });
  //       } else {
  //         print("Login Failed");
  //       }
  //     });
  //   } else {
  //     print('Enter Feild');
  //   }
  // }
}
