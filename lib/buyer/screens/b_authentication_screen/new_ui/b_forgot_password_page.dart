import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/new_ui/b_login_email_screen.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/buyer/view_model/b_login_home_controller.dart';
import 'package:pipes_online/seller/view/s_screens/s_image.dart';
import 'package:sizer/sizer.dart';

import '../../../../seller/view/s_screens/s_color_picker.dart';
import '../../../../seller/view/s_screens/s_common_button.dart';
import '../../../../seller/view/s_screens/s_text_style.dart';

class BForgotPasswordScreen extends StatefulWidget {
  const BForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<BForgotPasswordScreen> createState() => _BForgotPasswordScreenState();
}

class _BForgotPasswordScreenState extends State<BForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: SColorPicker.purple,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: Get.height * 0.1,
                width: Get.width,
                padding: EdgeInsets.only(
                  top: Get.height * 0.03,
                  right: Get.width * 0.05,
                  left: Get.width * 0.05,
                ),
                decoration: BoxDecoration(
                    color: SColorPicker.purple,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(20.sp))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: SColorPicker.white,
                      ),
                    ),
                    Text(
                      'Forgot Password'.toUpperCase(),
                      style: STextStyle.bold700White14,
                    ),
                    SizedBox(width: 20.sp),
                  ],
                ),
              ),
              GetBuilder<BLogInController>(
                builder: (controller) {
                  return Container(
                    height: Get.height * 0.864,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.sp),
                      ),
                    ),
                    child: Stack(
                      overflow: Overflow.visible,
                      children: [
                        Positioned(
                          left: Get.width * 0.1,
                          top: -Get.height * 0.04,
                          child: Container(
                            height: 50.sp,
                            width: 50.sp,
                            padding: EdgeInsets.only(top: 10.sp),
                            child: SvgPicture.asset(
                              "${SImagePick.authHome}",
                            ),
                            decoration: BoxDecoration(
                                color: SColorPicker.lightGrey,
                                shape: BoxShape.circle),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: Get.height * 0.1,
                              left: Get.width * 0.06,
                              right: Get.width * 0.06),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: Get.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Forgot Password',
                                      style: STextStyle.semiBold600Black15,
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.02,
                                    ),
                                    Text(
                                      'Enter the Email address\nassociated with your account.',
                                      style: STextStyle.regular400Black11,
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.06,
                              ),
                              CustomText(
                                  text: 'Email',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14.sp,
                                  alignment: Alignment.topLeft,
                                  color: AppColors.secondaryBlackColor),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Container(
                                height: Get.height * 0.06,
                                width: Get.width * 1,
                                child: TextFormField(
                                  validator: (email) {
                                    if (isEmailValid(email!)) {
                                      return null;
                                    } else {
                                      return 'Enter a valid email address';
                                    }
                                  },
                                  textInputAction: TextInputAction.done,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      // hintText: "Email",
                                      ),
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.04,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 40.sp),
                                child: SCommonButton().sCommonPurpleButton(
                                  name: "Reset Password".toUpperCase(),
                                  onTap: () async {
                                    resetPassword().then((value) {
                                      Get.to(() => BLoginEmailScreen());
                                    });
                                    // setState(() {
                                    //   isLoading = true;
                                    // });
                                    // Get.offAll(BottomNavigationBarScreen());
                                    //
                                    // setState(() {
                                    //   isLoading = false;
                                    // });

                                    // if (phoneNumber.text.isNotEmpty) {
                                    //   // if (otpCodeVisible) {
                                    //   //   // verify();
                                    //   //   verifyCode();
                                    //   // } else {
                                    //   //   await phoneSignIn(
                                    //   //       phoneNumber: phoneNumber.text);
                                    //   // }
                                    //
                                    //   await sendOtp(_auth).then(
                                    //     (value) => Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //         builder: (context) => VerifyOTP(),
                                    //       ),
                                    //     ),
                                    //   );
                                    // } else {}
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isEmailValid(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    return regex.hasMatch(email);
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim())
          .then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password Reset Email Sent'),
            backgroundColor: Colors.redAccent,
          ),
        );
      });
    } on FirebaseException catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${e.message}'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }
}
