import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/bottom_bar_screen_page.dart';
import 'package:pipes_online/buyer/screens/home_screen_widget.dart';
import 'package:pipes_online/buyer/view_model/b_signup_home_controller.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:pipes_online/seller/common/s_common_button.dart';
import 'package:pipes_online/seller/common/s_image.dart';
import 'package:pipes_online/seller/common/s_text_style.dart';
import 'package:pipes_online/seller/view_model/s_signup_home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../../routes/app_routes.dart';

class BLogInOTPScreen extends StatefulWidget {
  @override
  _BLogInOTPScreenState createState() => _BLogInOTPScreenState();
}

class _BLogInOTPScreenState extends State<BLogInOTPScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  BSignUpHomeController bSignUpHomeController = Get.put(BSignUpHomeController());

  var data=Get.arguments;
  String? _otp;
  @override
  Widget build(BuildContext context) {
    print(data[1]);
    print(data[0]);
    return ProgressHUD(child: Builder(builder: (context) => SafeArea(
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
                      'LOGIN',
                      style: STextStyle.bold700White14,
                    ),
                    SizedBox(width: 20.sp),
                  ],
                ),
              ),
              Container(
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
                            "${SImagePick.authOTP}",
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
                                  'Enter the OTP',
                                  style: STextStyle.semiBold600Black15,
                                ),
                                Text(
                                  'We have sent an OTP TO ${bSignUpHomeController.mobileNumber.text.toString()} ',
                                  style: STextStyle.regular400Black11,
                                ),
                              ],
                            ),
                          ),
                          OTPTextField(
                            length: 4,
                            width: MediaQuery.of(context).size.width * 0.7,

                            fieldWidth: 40.sp,
                            style: TextStyle(fontSize: 17.sp),
                            //textFieldAlignment: MainAxisAlignment.spaceAround,
                            fieldStyle: FieldStyle.underline,
                            onCompleted: (pin) {
                              print("Completed: " + pin);
                            },
                          ),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Didn't receive the OTP? ",
                                  style: STextStyle.regular400Black13,
                                ),
                                TextSpan(
                                    text: 'Resend OTP',
                                    style: STextStyle.medium400Purple13,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {}),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40.sp),
                            child: SCommonButton().sCommonPurpleButton(
                              name: 'Login',
                              onTap: () {
                                final progress =
                                ProgressHUD.of(context);
                                // progress?.show;
                                print("it is loading to go profile page");
                                progress!.showWithText('');
                                verifyCode();
                              },
                            ),
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),));
  }
  void verifyCode() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: data[0], smsCode: _otp!);
    await _auth.signInWithCredential(credential).then((value) {
      print('Buyer side...B...You are logged in successfully');
      _prefs.setBool('isLoggedIn', true);
      Get.offAll(BRoutes.BSubmitProfileScreen);
    });
  }
}
