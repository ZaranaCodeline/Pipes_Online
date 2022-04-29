import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/new_ui/b_first_user_info_screen.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/new_ui/b_login_email_screen.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/phone.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/b_navigationbar.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/buyer/screens/terms_condition_page.dart';
import 'package:pipes_online/buyer/view_model/b_login_home_controller.dart';
import 'package:pipes_online/seller/view/s_screens/s_color_picker.dart';
import 'package:pipes_online/seller/view/s_screens/s_common_button.dart';
import 'package:pipes_online/seller/view/s_screens/s_image.dart';
import 'package:pipes_online/seller/view/s_screens/s_text_style.dart';
import 'package:sizer/sizer.dart';

class BSignUpPhoneOtpScreen extends StatefulWidget {
  @override
  _BSignUpPhoneOtpScreenState createState() => _BSignUpPhoneOtpScreenState();
}

class _BSignUpPhoneOtpScreenState extends State<BSignUpPhoneOtpScreen> {
  final _globalKey = GlobalKey<ScaffoldState>();

  final _otpController = OtpFieldController();
  String? verificationCode;
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  Future<void> verificationOTPCode(String otp) async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationCode!, smsCode: otp);
    if (phoneAuthCredential == null) {
      _globalKey.currentState!.showSnackBar(
        SnackBar(
          content: Text("Please enter valid otp"),
        ),
      );
      return;
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavigationBarScreen(),
        ),
      );
    }
    _auth.signInWithCredential(phoneAuthCredential);
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
                      'SIGN UP'.toUpperCase(),
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
                                      'Enter OTP',
                                      style: STextStyle.semiBold600Black15,
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Text(
                                      'OTP Sent to +91  ',
                                      style: STextStyle.regular400Black11,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.04,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: Get.width * 0.85,
                                    child: OTPTextField(
                                        controller: _otpController,
                                        length: 6,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fieldWidth: 30,
                                        style: TextStyle(fontSize: 15),
                                        textFieldAlignment:
                                            MainAxisAlignment.spaceAround,
                                        fieldStyle: FieldStyle.underline,
                                        onCompleted: (pin) {
                                          print("Completed: " + pin);
                                        },
                                        onChanged: (pin) {
                                          print("onChanged: " + pin);
                                        }),
                                  ),
                                  // ElevatedButton(
                                  //   onPressed: () {
                                  //     // verificationOTPCode(_otpController.toString());
                                  //     // log("OTP==>>${_otpController.toString()}");
                                  //   },
                                  //   child: Text("Verify Otp"),
                                  // ),
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.04,
                              ),
                              TextButton(
                                onPressed: () {},
                                child: CustomText(
                                  alignment: Alignment.topLeft,
                                  text: 'Resend OTP',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.04,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  Get.to(BFirstUserInfoScreen());
                                  isLoading = false;
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: Get.width * 0.6,
                                  height: Get.height * 0.08,
                                  decoration: BoxDecoration(
                                    color: SColorPicker.purple,
                                    borderRadius: BorderRadius.circular(10.sp),
                                  ),
                                  child: isLoading
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomText(
                                                text: 'Loading...  ',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.sp,
                                                color: AppColors
                                                    .commonWhiteTextColor),
                                            CircularProgressIndicator(
                                              color: AppColors
                                                  .commonWhiteTextColor,
                                            ),
                                          ],
                                        )
                                      : Text(
                                          'SIGN UP',
                                          style: TextStyle(
                                              color: AppColors
                                                  .commonWhiteTextColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                ),
                              ),
                              // Padding(
                              //   padding:
                              //       EdgeInsets.symmetric(horizontal: 40.sp),
                              //   child: SCommonButton().sCommonPurpleButton(
                              //     name: "SIGN UP",
                              //     onTap: () async {
                              //       setState(() {
                              //         isLoading = true;
                              //       });
                              //       Get.to(BFirstUserInfoScreen());
                              //       isLoading = false;
                              //     },
                              //   ),
                              // ),
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
}
