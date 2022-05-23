import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/screens/terms_condition_page.dart';
import 'package:pipes_online/s_onboarding_screen/s_buyer_seller_screen.dart';
import 'package:pipes_online/seller/bottombar/s_navigation_bar.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:pipes_online/seller/common/s_common_button.dart';
import 'package:pipes_online/seller/common/s_image.dart';
import 'package:pipes_online/seller/common/s_text_style.dart';
import 'package:pipes_online/seller/view_model/s_login_home_controller.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';

class SPhoneOTP_Screen extends StatefulWidget {
  @override
  _SPhoneOTP_ScreenState createState() => _SPhoneOTP_ScreenState();
}

class _SPhoneOTP_ScreenState extends State<SPhoneOTP_Screen> {
  SLogInController sLogInController = Get.put(SLogInController());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  bool otpCodeVisible = false;

  String? verificationId;
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController otpCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: Builder(
        builder: (context) => SafeArea(
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
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(20.sp))),
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
                  GetBuilder<SLogInController>(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Enter Mobile Number',
                                          style: STextStyle.semiBold600Black15,
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.01,
                                        ),
                                        Text(
                                          'OTP will be sent to this number',
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
                                        height: Get.height * 0.07,
                                        width: Get.width * 0.25,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.sp),
                                            border:
                                                Border.all(color: Colors.grey)),
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
                                            border:
                                                Border.all(color: Colors.grey)),
                                        alignment: Alignment.centerLeft,
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          controller: phoneNumber,
                                          decoration: InputDecoration(
                                              hintText: 'Enter Number',
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.sp),
                                                  borderSide: BorderSide.none),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.sp),
                                                  borderSide: BorderSide.none),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.sp),
                                                  borderSide: BorderSide.none),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.sp),
                                                  borderSide: BorderSide.none)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.04,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.sp),
                                        border: Border.all(color: Colors.grey)),
                                    height: Get.height * 0.07,
                                    width: Get.width * 0.9,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: otpCode,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          hintText: 'Enter Otp',
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
                                  SizedBox(
                                    height: Get.height * 0.04,
                                  ),
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              'By continuing, you agree to the',
                                          style: STextStyle.regular600Black11,
                                        ),
                                        TextSpan(
                                            text: ' terms and conditions',
                                            style:
                                                STextStyle.semiBold600Purple11,
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Get.to(() =>
                                                    TermsAndConditionPage());
                                                print('Terms and Conditons');
                                              }),
                                        TextSpan(
                                          text: ' of this app.',
                                          style: STextStyle.regular600Black11,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.04,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 40.sp),
                                    child: SCommonButton().sCommonPurpleButton(
                                      name: otpCodeVisible ? "Login" : "Verify",
                                      onTap: () async {
                                        if (phoneNumber.text.isNotEmpty) {
                                          // final progress =
                                          //     ProgressHUD.of(context);
                                          // // progress?.show;
                                          // print("it's me");
                                          // progress!.showWithText('');
                                          if (otpCodeVisible) {
                                            verifyCode();
                                          } else {
                                            await phoneSignIn(
                                                phoneNumber: phoneNumber.text);
                                          }
                                        } else {
                                          Get.showSnackbar(
                                            GetSnackBar(
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              backgroundColor: SColorPicker.red,
                                              duration: Duration(seconds: 2),
                                              message:
                                                  'Please enter mobile number',
                                            ),
                                          );
                                        }
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
        ),
      ),
    );
  }

  Future<void> phoneSignIn({required String phoneNumber}) async {
    await _auth.verifyPhoneNumber(
        phoneNumber: '+91 ' + phoneNumber,
        verificationCompleted: _onVerificationCompleted,
        verificationFailed: _onVerificationFailed,
        codeSent: _onCodeSent,
        codeAutoRetrievalTimeout: _onCodeTimeout);
  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    print("verification completed ${authCredential.smsCode}");
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      this.otpCode.text = authCredential.smsCode!;
    });
    if (authCredential.smsCode != null) {
      try {
        UserCredential credential =
            await user!.linkWithCredential(authCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'provider-already-linked') {
          await _auth.signInWithCredential(authCredential);
        }
      }
      setState(() {
        isLoading = false;
      });
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  _onVerificationFailed(FirebaseAuthException exception) {
    if (exception.code == 'invalid-phone-number') {
      showMessage("The phone number entered is invalid!");
    }
  }

  _onCodeSent(String verificationId, int? forceResendingToken) {
    this.verificationId = verificationId;
    print(forceResendingToken);
    print("code sent");
    otpCodeVisible = true;
  }

  _onCodeTimeout(String timeout) {
    return null;
  }

  void showMessage(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(errorMessage),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () async {
                  Navigator.of(builderContext).pop();
                },
              )
            ],
          );
        }).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  void verifyCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!, smsCode: otpCode.text);
    _auth.signInWithCredential(credential).then((value) {
      print('You are logged in successfully');
      if (PreferenceManager.getUId().toString() != null) {
        print('TEST:- 1');
        if (PreferenceManager.getUserType() == '' ||
            PreferenceManager.getUserType() == null) {
          print('TEST:- 2');
          Get.offAll(SBuyerSellerScreen());
        } else {
          print('TEST:- 4');
          PreferenceManager.getUserType() == 'Seller';
          Get.offAll(NavigationBarScreen());
        }
      }

      // Get.off(NavigationBarScreen());
    });
  }
}
