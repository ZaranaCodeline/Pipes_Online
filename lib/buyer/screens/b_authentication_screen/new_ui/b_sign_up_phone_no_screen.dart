import 'dart:developer';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/b_login_screen.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/new_ui/b_login_email_screen.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/new_ui/b_sign_up_email_screen.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/new_ui/b_sign_up_phone_otp_screen.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/otp.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/buyer/screens/terms_condition_page.dart';
import 'package:pipes_online/buyer/view_model/b_login_home_controller.dart';
import 'package:pipes_online/seller/view/s_screens/s_color_picker.dart';
import 'package:pipes_online/seller/view/s_screens/s_image.dart';
import 'package:pipes_online/seller/view/s_screens/s_text_style.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';

import '../phone.dart';

// String? verificationCode;
enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class BSignUpPhoneNumberScreen extends StatefulWidget {
  const BSignUpPhoneNumberScreen({Key? key}) : super(key: key);

  @override
  State<BSignUpPhoneNumberScreen> createState() =>
      _BSignUpPhoneNumberScreenState();
}

class _BSignUpPhoneNumberScreenState extends State<BSignUpPhoneNumberScreen> {
  bool isLoading = false;
// String? dialogCodeDigits="+00";
  int? resendingTokenID;
  String? verificationId;
  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;
  FirebaseAuth _auth = FirebaseAuth.instance;
  BLogInController bLogInController = Get.find();
  final _phoneController = TextEditingController();
  final _globalKey = GlobalKey<ScaffoldState>();
  // String? dialCodeDigits = "+91";
  Future sendOtp() async {
    setState(() {
      isLoading = true;
    });
    print(
        '========code===${bLogInController.countryCode}${_phoneController.text}');

    await _auth.verifyPhoneNumber(
      phoneNumber:
          bLogInController.countryCode.toString() + _phoneController.text,
      verificationCompleted: (phoneAuthCredential) async {
        setState(() {
          isLoading = false;
        });
        // signInWithPhoneAuthCredential(phoneAuthCredential);
      },
      verificationFailed: (verificationFailed) async {
        setState(() {
          isLoading = false;
        });
        print('----verificationFailed---${verificationFailed.message}');
        Get.showSnackbar(
          GetSnackBar(
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: SColorPicker.red,
            duration: Duration(seconds: 5),
            message: verificationFailed.message,
          ),
        );
        // CommonSnackBar.showSnackBar(
        //     msg: verificationFailed.message, successStatus: false);
        print('${verificationFailed.message}');
      },
      codeSent: (verificationId, resendingToken) async {
        setState(() {
          isLoading = false;
          currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
          this.verificationId = verificationId;
          print('---------verificationId-------$verificationId');
          print('---------this.verificationId-------${this.verificationId}');

          // Get.to(OtpScreen(
          //   mobileNumber: controller.countryCode +
          //       _textEditingController.text,
          //   verificationId: verificationId,
          // ));

          Get.to(BSignUpPhoneOtpScreen(
            phone: _phoneController.text,
            verificationId: verificationId,
          ));
          print('====${verificationId}');
        });
      },
      codeAutoRetrievalTimeout: (verificationId) async {},
    );

    ///
    // await auth
    //     .verifyPhoneNumber(
    //       phoneNumber: "+91" + "${_phoneController.text}",
    //       timeout: const Duration(seconds: 60),
    //       verificationCompleted: (PhoneAuthCredential credential) async {
    //         await FirebaseAuth.instance
    //             .signInWithCredential(credential)
    //             .then((value) async {
    //           if (value.user != null) {
    //             print('user logged in');
    //           }
    //         });
    //       },
    //       // verificationCompleted: (phoneAuthCredential) async {
    //       //   print('Verification Completed');
    //       // },
    //       verificationFailed: (FirebaseAuthException e) async {
    //         if (e.code == 'invalid-phone-number') {
    //           print(e.message);
    //           Get.showSnackbar(
    //             GetSnackBar(
    //               snackPosition: SnackPosition.BOTTOM,
    //               backgroundColor: SColorPicker.red,
    //               duration: Duration(seconds: 5),
    //               message: e.message,
    //             ),
    //           );
    //           print('The provided phone number is not valid.');
    //         }
    //         log("verificationFailed error ${e.message}");
    //
    //         _globalKey.currentState?.showSnackBar(SnackBar(
    //           content: Text(e.message!),
    //         ));
    //       },
    //       codeSent: (verificationId, resendingToken) async {
    //         setState(() {
    //           verificationCode = verificationId;
    //           resendingTokenID = resendingToken;
    //         });
    //       },
    //       codeAutoRetrievalTimeout: (verificationId) async {
    //         setState(() {
    //           verificationCode = verificationId;
    //         });
    //       },
    //     )
    //     .then(
    //       (value) => Get.to(() => BSignUpPhoneOtpScreen(
    //             phone: _phoneController.text.trim(),
    //           )),
    //     )
    //     .catchError((onError) {
    //   print(onError.toString());
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(
        '========code===${bLogInController.countryCode} ${_phoneController.text}');

    print('==>dialCodeDigit===${bLogInController.countryCode}');
    // sendOtp(FirebaseAuth.instance);
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
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20.sp),
                  ),
                ),
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
                        Padding(
                          padding: EdgeInsets.only(
                              top: Get.height * 0.1,
                              left: Get.width * 0.06,
                              right: Get.width * 0.06),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CustomText(
                                    alignment: Alignment.topLeft,
                                    text: 'Mobile Number',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.sp,
                                    color: AppColors.secondaryBlackColor),
                                SizedBox(
                                  height: Get.height * 0.05,
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
                                          border: Border.all(
                                              color: Colors.grey, width: 0.5)),
                                      alignment: Alignment.centerLeft,
                                      child: CountryCodePicker(
                                        onChanged: (val) {
                                          controller.setCountryCode(val);
                                        },
                                        initialSelection: '+00',
                                        favorite: ['+91', 'IN'],
                                        showCountryOnly: false,
                                        showOnlyCountryWhenClosed: false,
                                      ),
                                    ),
                                    Container(
                                      height: Get.height * 0.07,
                                      width: Get.width * 0.6,
                                      child: TextFormField(
                                        controller: _phoneController,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(10)
                                        ],
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                          hintText: "Enter phone Number",
                                        ),
                                        validator: (value) {
                                          if (value!.trim().isEmpty) {
                                            return 'This field is required';
                                          }
                                          if (!RegExp(
                                                  r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                              .hasMatch(value)) {
                                            return 'please enter valid number';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.05,
                                ),
                                RichText(
                                  textAlign: TextAlign.start,
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
                                  height: Get.height * 0.10,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    sendOtp();
                                    // if (_phoneController.text.isNotEmpty) {
                                    //   isLoading = true;
                                    //   await sendOtp();
                                    // }
                                    // isLoading = false;
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //   SnackBar(
                                    //     content:
                                    //         Text('Enter valid phone number'),
                                    //     backgroundColor: Colors.redAccent,
                                    //   ),
                                    // );

                                    // await sendOtp(_auth).then(
                                    //   (value) => Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) => VerifyOTP(),
                                    //     ),
                                    //   ),
                                    // );
                                    // isLoading = true;
                                    // if (_phoneController.text.isNotEmpty) {
                                    //   if (otpCodeVisible) {
                                    //     // verify();
                                    //     verifyCode();
                                    //   } else {
                                    //     await phoneSignIn(
                                    //         phoneNumber: phoneNumber.text);
                                    //   }
                                    //
                                    //   await sendOtp(_auth).then(
                                    //         (value) => Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             VerifyOTP(),
                                    //       ),
                                    //     ),
                                    //   );
                                    // } else {}
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: Get.width * 0.6,
                                    height: Get.height * 0.08,
                                    decoration: BoxDecoration(
                                      color: SColorPicker.purple,
                                      borderRadius:
                                          BorderRadius.circular(10.sp),
                                    ),
                                    child:
                                        // isLoading
                                        //     ? Row(
                                        //   mainAxisAlignment:
                                        //   MainAxisAlignment.center,
                                        //   children: [
                                        //     CustomText(
                                        //         text: 'Loading...  ',
                                        //         fontWeight: FontWeight.w600,
                                        //         fontSize: 12.sp,
                                        //         color: AppColors
                                        //             .commonWhiteTextColor),
                                        //     CircularProgressIndicator(
                                        //       color: AppColors
                                        //           .commonWhiteTextColor,
                                        //     ),
                                        //   ],
                                        // )
                                        //     :
                                        Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          color: AppColors.commonWhiteTextColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                                // Padding(
                                //   padding:
                                //       EdgeInsets.symmetric(horizontal: 40.sp),
                                //   child: SCommonButton().sCommonPurpleButton(
                                //     name: otpCodeVisible ? "Login" : "Verify",
                                //     onTap: () async {
                                // isLoading = true;
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
                                //         builder: (context) =>
                                //             VerifyOTP(),
                                //       ),
                                //     ),
                                //   );
                                // } else {}
                                // },
                                //   ),
                                // ),
                                SizedBox(
                                  height: Get.height * 0.03,
                                ),
                                Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      print('it is Signup with Mobile Number');
                                      // setState(() {
                                      Get.to(BSignUpEmailScreen());
                                      // });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(12.sp),
                                      height: Get.height * 0.075,
                                      width: Get.height * 0.37,
                                      decoration: BoxDecoration(
                                        color: SColorPicker.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black12,
                                              spreadRadius: 0.5,
                                              blurRadius: 1),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(10.sp),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset(
                                            "${SImagePick.pipesEmailLogo}",
                                            width: 15.sp,
                                            height: 15.sp,
                                          ),
                                          Text(
                                            'Signup with Email',
                                            style: STextStyle.medium400Purple13,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: Get.height * 0.03),
                                Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      print('it is map');
                                      // setState(() {
                                      //   Get.to(MapsScreen());
                                      // });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(12.sp),
                                      height: Get.height * 0.075,
                                      width: Get.width * 0.6,
                                      decoration: BoxDecoration(
                                        color: SColorPicker.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black12,
                                              spreadRadius: 0.5,
                                              blurRadius: 1),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(10.sp),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SvgPicture.asset(
                                            "${SImagePick.locationColorIcon}",
                                          ),
                                          Text(
                                            'Signup with Google',
                                            style:
                                                STextStyle.semiBold600Black13,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.03,
                                ),
                                Center(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Already registered?',
                                          style: STextStyle.regular400Black13,
                                        ),
                                        TextSpan(
                                            text: '  Login',
                                            style: STextStyle.medium400Purple13,
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                print('=====>Login');
                                                Get.off(BLoginEmailScreen());
                                              }),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.05,
                                ),
                              ],
                            ),
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

// class BSignUpPhoneNumberScreen extends StatefulWidget {
//   const BSignUpPhoneNumberScreen({Key? key}) : super(key: key);
//
//   @override
//   State<BSignUpPhoneNumberScreen> createState() =>
//       _BSignUpPhoneNumberScreenState();
// }
//
// class _BSignUpPhoneNumberScreenState extends State<BSignUpPhoneNumberScreen> {
//   int? resendingTokenID;
//
//   FirebaseAuth _auth = FirebaseAuth.instance;
//
//   final _phoneController = TextEditingController();
//   final _globalKey = GlobalKey<ScaffoldState>();
//
//   Future sendOtp(FirebaseAuth auth) async {
//     await auth.verifyPhoneNumber(
//       phoneNumber: '${"+91" + "${_phoneController.text}"}',
//       verificationCompleted: (phoneAuthCredential) async {
//         print('Verification Completed');
//       },
//       verificationFailed: (verificationFailed) async {
//         log("verificationFailed error ${verificationFailed.message}");
//         _globalKey.currentState!.showSnackBar(SnackBar(
//           content: Text(verificationFailed.message!),
//         ));
//       },
//       codeSent: (verificationId, resendingToken) async {
//         verificationCode = verificationId;
//         resendingTokenID = resendingToken;
//       },
//       codeAutoRetrievalTimeout: (verificationId) async {},
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextFormField(
//               controller: _phoneController,
//               inputFormatters: [LengthLimitingTextInputFormatter(10)],
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 hintText: "Enter phone Number",
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 await sendOtp(_auth).then(
//                   (value) => Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => BSignUpPhoneOtpScreen(),
//                     ),
//                   ),
//                 );
//               },
//               child: Text("Send Otp"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
