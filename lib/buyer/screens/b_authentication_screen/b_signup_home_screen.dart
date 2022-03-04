import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/b_signup_otp_screen.dart';
import 'package:pipes_online/buyer/screens/terms_condition_page.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:pipes_online/seller/common/s_common_button.dart';
import 'package:pipes_online/seller/common/s_image.dart';
import 'package:pipes_online/seller/common/s_text_style.dart';
import 'package:pipes_online/routes/app_routes.dart';
import 'package:pipes_online/seller/view_model/s_signup_home_controller.dart';
import 'package:sizer/sizer.dart';

class BSignUpHomeScreen extends StatefulWidget {
  @override
  _BSignUpHomeScreenState createState() => _BSignUpHomeScreenState();
}

class _BSignUpHomeScreenState extends State<BSignUpHomeScreen> {
  SSignUpHomeController sSignUpHomeController =
      Get.put(SSignUpHomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: SColorPicker.purple,
        // appBar: AppBar(
        //     backgroundColor: Colors.transparent,
        //     elevation: 0,
        //     title: Text(
        //       'SIGN UP',
        //       style: STextStyle.bold700White14,
        //     ),
        //     centerTitle: true),
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
                      'SIGN UP',
                      style: STextStyle.bold700White14,
                    ),
                    SizedBox(width: 20.sp),
                  ],
                ),
              ),
              GetBuilder<SSignUpHomeController>(
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
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.05,
                              vertical: Get.height * 0.08),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: Get.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Enter Mobile Number',
                                      style: STextStyle.semiBold600Black15,
                                    ),
                                    Text(
                                      'OTP will be sent to this number',
                                      style: STextStyle.regular400Black11,
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: Get.height * 0.07,
                                    width: Get.width * 0.25,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.sp),
                                        border: Border.all(color: Colors.grey)),
                                    alignment: Alignment.centerLeft,
                                    child: CountryCodePicker(
                                      onChanged: (val) {
                                        controller.setCountryCode(val);
                                      },
                                      initialSelection: '+91',
                                    ),
                                  ),
                                  Container(
                                    height: Get.height * 0.07,
                                    width: Get.width * 0.6,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.sp),
                                        border: Border.all(color: Colors.grey)),
                                    alignment: Alignment.centerLeft,
                                    child: TextFormField(
                                      controller: controller.mobileNumber,
                                      decoration: InputDecoration(
                                          hintText: 'Enter Number',
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.sp),
                                              borderSide: BorderSide.none),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.sp),
                                              borderSide: BorderSide.none),
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.sp),
                                              borderSide: BorderSide.none)),
                                    ),
                                  ),
                                ],
                              ),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'By continuing, you agree to the',
                                      style: STextStyle.regular600Black11,
                                    ),
                                    TextSpan(
                                        text: ' terms and conditions',
                                        style: STextStyle.semiBold600Purple11,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                          Get.to(()=>TermsAndConditionPage());
                                            print('Terms and Conditons');
                                          }),
                                    TextSpan(
                                      text: ' of this app.',
                                      style: STextStyle.regular600Black11,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 40.sp),
                                child: SCommonButton().sCommonPurpleButton(
                                  name: 'Send OTP',
                                  onTap: () {
                                    Get.to(()=>BSignUpOTPScreen());
                                  },
                                ),
                              ),
                              Text(
                                'Or Sign Up with',
                                style: STextStyle.regular400Black13,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.02,
                                ),
                                height: Get.height * 0.06,
                                width: Get.width * 0.4,
                                decoration: BoxDecoration(
                                  color: SColorPicker.white,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        spreadRadius: 0.5,
                                        blurRadius: 1),
                                  ],
                                  borderRadius: BorderRadius.circular(10.sp),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SvgPicture.asset(
                                      "${SImagePick.googleIcon}",
                                    ),
                                    Text(
                                      'Google',
                                      style: STextStyle.semiBold600Black16,
                                    )
                                  ],
                                ),
                              ),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Already registered?',
                                      style: STextStyle.regular400Black13,
                                    ),
                                    TextSpan(
                                        text: ' Login',
                                        style: STextStyle.medium400Purple13,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            print('aaa');
                                            Get.offNamed(
                                                SRoutes.SLogInHomeScreen);
                                          }),
                                  ],
                                ),
                              ),
                              SizedBox(),
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
