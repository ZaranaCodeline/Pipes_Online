// import 'dart:developer';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:otp_text_field/otp_text_field.dart';
// import 'package:otp_text_field/style.dart';
// import 'package:pipes_online/buyer/screens/b_authentication_screen/phone.dart';
// import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/b_navigationbar.dart';
// import 'package:pipes_online/buyer/screens/terms_condition_page.dart';
// import 'package:pipes_online/buyer/view_model/b_login_home_controller.dart';
// import 'package:pipes_online/seller/view/s_screens/s_color_picker.dart';
// import 'package:pipes_online/seller/view/s_screens/s_common_button.dart';
// import 'package:pipes_online/seller/view/s_screens/s_image.dart';
// import 'package:pipes_online/seller/view/s_screens/s_text_style.dart';
// import 'package:sizer/sizer.dart';
//
// class BSignUpPhoneOtpScreen extends StatefulWidget {
//   final String? phone;
//   const BSignUpPhoneOtpScreen({
//     Key? key,
//     this.phone,
//   }) : super(key: key);
//
//   @override
//   _BSignUpPhoneOtpScreenState createState() => _BSignUpPhoneOtpScreenState();
// }
//
// class _BSignUpPhoneOtpScreenState extends State<BSignUpPhoneOtpScreen> {
//   final _globalKey = GlobalKey<ScaffoldState>();
//
//   final _otpController = OtpFieldController();
//   String? verificationCode;
//   FirebaseAuth _auth = FirebaseAuth.instance;
//
//   Future<void> verificationOTPCode(String otp) async {
//     PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
//         verificationId: verificationCode!, smsCode: otp);
//     if (phoneAuthCredential == null) {
//       _globalKey.currentState!.showSnackBar(
//         SnackBar(
//           content: Text("Please enter valid otp"),
//         ),
//       );
//       return;
//     } else {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//           builder: (context) => BottomNavigationBarScreen(),
//         ),
//       );
//     }
//     _auth.signInWithCredential(phoneAuthCredential);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: SColorPicker.purple,
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Container(
//                 height: Get.height * 0.1,
//                 width: Get.width,
//                 padding: EdgeInsets.only(
//                   top: Get.height * 0.03,
//                   right: Get.width * 0.05,
//                   left: Get.width * 0.05,
//                 ),
//                 decoration: BoxDecoration(
//                     color: SColorPicker.purple,
//                     borderRadius:
//                         BorderRadius.vertical(bottom: Radius.circular(20.sp))),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Get.back();
//                       },
//                       child: Icon(
//                         Icons.arrow_back_rounded,
//                         color: SColorPicker.white,
//                       ),
//                     ),
//                     Text(
//                       'SIGN UP',
//                       style: STextStyle.bold700White14,
//                     ),
//                     SizedBox(width: 20.sp),
//                   ],
//                 ),
//               ),
//               GetBuilder<BLogInController>(
//                 builder: (controller) {
//                   return Container(
//                     height: Get.height * 0.864,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(30.sp),
//                       ),
//                     ),
//                     child: Stack(
//                       overflow: Overflow.visible,
//                       children: [
//                         Positioned(
//                           left: Get.width * 0.1,
//                           top: -Get.height * 0.04,
//                           child: Container(
//                             height: 50.sp,
//                             width: 50.sp,
//                             padding: EdgeInsets.only(top: 10.sp),
//                             child: SvgPicture.asset(
//                               "${SImagePick.authHome}",
//                             ),
//                             decoration: BoxDecoration(
//                                 color: SColorPicker.lightGrey,
//                                 shape: BoxShape.circle),
//                           ),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.only(
//                               top: Get.height * 0.1,
//                               left: Get.width * 0.06,
//                               right: Get.width * 0.06),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Container(
//                                 width: Get.width,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Enter Mobile Number',
//                                       style: STextStyle.semiBold600Black15,
//                                     ),
//                                     SizedBox(
//                                       height: Get.height * 0.01,
//                                     ),
//                                     Text(
//                                       'OTP will be sent to this number',
//                                       style: STextStyle.regular400Black11,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: Get.height * 0.04,
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                     width: Get.width * 0.85,
//                                     child: OTPTextField(
//                                         controller: _otpController,
//                                         length: 6,
//                                         width:
//                                             MediaQuery.of(context).size.width,
//                                         fieldWidth: 30,
//                                         style: TextStyle(fontSize: 15),
//                                         textFieldAlignment:
//                                             MainAxisAlignment.spaceAround,
//                                         fieldStyle: FieldStyle.underline,
//                                         onCompleted: (pin) {
//                                           print("Completed: " + pin);
//                                         },
//                                         onChanged: (pin) {
//                                           print("onChanged: " + pin);
//                                         }),
//                                   ),
//                                   // ElevatedButton(
//                                   //   onPressed: () {
//                                   //     // verificationOTPCode(_otpController.toString());
//                                   //     // log("OTP==>>${_otpController.toString()}");
//                                   //   },
//                                   //   child: Text("Verify Otp"),
//                                   // ),
//                                 ],
//                               ),
//                               // SizedBox(
//                               //   height: Get.height * 0.04,
//                               // ),
//                               // Container(
//                               //   decoration: BoxDecoration(
//                               //       borderRadius:
//                               //           BorderRadius.circular(10.sp),
//                               //       border: Border.all(color: Colors.grey)),
//                               //   height: Get.height * 0.07,
//                               //   width: Get.width * 0.9,
//                               //   child: TextFormField(
//                               //     keyboardType: TextInputType.number,
//                               //     controller: otpCode,
//                               //     obscureText: true,
//                               //     decoration: InputDecoration(
//                               //         hintText: 'Enter Otp',
//                               //         focusedBorder: OutlineInputBorder(
//                               //             borderRadius:
//                               //                 BorderRadius.circular(10.sp),
//                               //             borderSide: BorderSide.none),
//                               //         enabledBorder: OutlineInputBorder(
//                               //             borderRadius:
//                               //                 BorderRadius.circular(10.sp),
//                               //             borderSide: BorderSide.none),
//                               //         border: OutlineInputBorder(
//                               //             borderRadius:
//                               //                 BorderRadius.circular(10.sp),
//                               //             borderSide: BorderSide.none)),
//                               //   ),
//                               // ),
//                               SizedBox(
//                                 height: Get.height * 0.04,
//                               ),
//                               RichText(
//                                 textAlign: TextAlign.center,
//                                 text: TextSpan(
//                                   children: [
//                                     TextSpan(
//                                       text: 'By continuing, you agree to the',
//                                       style: STextStyle.regular600Black11,
//                                     ),
//                                     TextSpan(
//                                         text: ' terms and conditions',
//                                         style: STextStyle.semiBold600Purple11,
//                                         recognizer: TapGestureRecognizer()
//                                           ..onTap = () {
//                                             Get.to(
//                                                 () => TermsAndConditionPage());
//                                             print('Terms and Conditons');
//                                           }),
//                                     TextSpan(
//                                       text: ' of this app.',
//                                       style: STextStyle.regular600Black11,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: Get.height * 0.04,
//                               ),
//                               Padding(
//                                 padding:
//                                     EdgeInsets.symmetric(horizontal: 40.sp),
//                                 child: SCommonButton().sCommonPurpleButton(
//                                   name: "SIGN UP",
//                                   onTap: () async {
//                                     // if (phoneNumber.text.isNotEmpty) {
//                                     //   // if (otpCodeVisible) {
//                                     //   //   // verify();
//                                     //   //   verifyCode();
//                                     //   // } else {
//                                     //   //   await phoneSignIn(
//                                     //   //       phoneNumber: phoneNumber.text);
//                                     //   // }
//                                     //
//                                     //   await sendOtp(_auth).then(
//                                     //     (value) => Navigator.push(
//                                     //       context,
//                                     //       MaterialPageRoute(
//                                     //         builder: (context) => VerifyOTP(),
//                                     //       ),
//                                     //     ),
//                                     //   );
//                                     // } else {}
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//
//     //   Scaffold(
//     //   key: _globalKey,
//     //   body: Padding(
//     //     padding: const EdgeInsets.symmetric(horizontal: 15),
//     //     child: Column(
//     //       mainAxisAlignment: MainAxisAlignment.center,
//     //       children: [
//     //         Container(
//     //           width: Get.width * 0.9,
//     //           child: OTPTextField(
//     //               controller: _otpController,
//     //               length: 6,
//     //               width: MediaQuery.of(context).size.width,
//     //               fieldWidth: 30,
//     //               style: TextStyle(fontSize: 17),
//     //               textFieldAlignment: MainAxisAlignment.spaceAround,
//     //               fieldStyle: FieldStyle.underline,
//     //               onCompleted: (pin) {
//     //                 print("Completed: " + pin);
//     //               },
//     //               onChanged: (pin) {
//     //                 print("onChanged: " + pin);
//     //               }),
//     //         ),
//     //         ElevatedButton(
//     //           onPressed: () {
//     //             verificationOTPCode(_otpController.toString());
//     //             log("OTP==>>${_otpController.toString()}");
//     //           },
//     //           child: Text("Verify Otp"),
//     //         ),
//     //       ],
//     //     ),
//     //   ),
//     // );
//   }
//
//   // void verifyCode() async {
//   //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
//   //       verificationId: verificationId!, smsCode: otpCode.text);
//   //   await _auth.signInWithCredential(credential).then((value) {
//   //     print('You are logged in successfully');
//   //   });
//   // }
// }
