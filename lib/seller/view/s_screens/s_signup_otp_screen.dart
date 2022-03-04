import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:pipes_online/seller/common/s_common_button.dart';
import 'package:pipes_online/seller/common/s_image.dart';
import 'package:pipes_online/seller/common/s_text_style.dart';
import 'package:pipes_online/seller/view/s_authentication_screen/s_submit_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SSignUpOTPScreen extends StatefulWidget {
  @override
  _SSignUpOTPScreenState createState() => _SSignUpOTPScreenState();
}

class _SSignUpOTPScreenState extends State<SSignUpOTPScreen> {
  String? _verificationCode;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var data=Get.arguments;
  String? _otp;
  @override
  Widget build(BuildContext context) {
    print(data[1]);
    print(data[0]);
    // var data=Get.arguments;
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
                      'SIGN UP',
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
                                  'We have sent an OTP TO ${data[1]}',
                                  style: STextStyle.regular400Black11,
                                ),
                              ],
                            ),
                          ),
                          OTPTextField(
                            length: 6,
                            width: Get.width * 1,
                            fieldWidth: 40.sp,
                            style: TextStyle(fontSize: 17.sp),
                            //textFieldAlignment: MainAxisAlignment.spaceAround,
                            fieldStyle: FieldStyle.underline,
                            onCompleted: (pin) async {
                                print("Completed: " + pin);
                                _otp = pin;

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
                              name: 'Sign Up',
                              onTap: () {
                                verifyCode();
                                // Get.toNamed(SRoutes.SSubmitProfileScreen);
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
    );
  }
  void verifyCode() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: data[0]!, smsCode: _otp!);
    await _auth.signInWithCredential(credential).then((value) {
      print('You are logged in successfully');
      _prefs.setBool('isLoggedIn', true);
      Get.offAll(SSubmitProfileScreen());
    });
  }
}
