// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:consultancy/ViewModel/otp_screeen_controllert.dart';
// import 'package:consultancy/common/bottom_controller.dart';
// import 'package:consultancy/common/button_common.dart';
// import 'package:consultancy/common/circularprogress_indicator.dart';
// import 'package:consultancy/common/common_widget.dart';
// import 'package:consultancy/common/coomon_snackbar.dart';
// import 'package:consultancy/common/preference_manager.dart';
// import 'package:consultancy/common/size_box.dart';
// import 'package:consultancy/common/text_filed.dart';
// import 'package:consultancy/model/requestModel/register_relasiya_req_moel.dart';
// import 'package:consultancy/res/Colors/colors_class.dart';
// import 'package:consultancy/res/text/text_common.dart';
// import 'package:consultancy/view/bottombar/navigation_bar.dart';
// import 'package:consultancy/view/charges/app_charges.dart';
// import 'package:consultancy/view/charges/by_default_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:otp_text_field/otp_field.dart';
// import 'package:otp_text_field/otp_field_style.dart';
// import 'package:otp_text_field/style.dart';
// import 'package:pipes_online/routes/bottom_controller.dart';
// import 'package:sizer/sizer.dart';
//
// class OtpScreen extends StatefulWidget {
//   const OtpScreen({Key? key, this.verificationId, this.mobileNumber})
//       : super(key: key);
//   final String? verificationId;
//   final String? mobileNumber;
//
//   @override
//   _OtpScreenState createState() => _OtpScreenState();
// }
//
// final FirebaseAuth auth = FirebaseAuth.instance;
//
// class _OtpScreenState extends State<OtpScreen> with TickerProviderStateMixin {
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore kFireStore = FirebaseFirestore.instance;
//   BottomController _bottomController = Get.find();
//   // RegisterRelasiyaReqModel _user = RegisterRelasiyaReqModel();
//   //bool showLoading = false;
//   // OtpScreenController _otpScreenController = Get.find();
//   int? otpPin;
//   AnimationController? _controller;
//   int levelClock = 180;
//   OtpFieldController otpController = OtpFieldController();
//   TextEditingController? _textEditingController = TextEditingController();
//
//   signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {
//     _otpScreenController.showLoading = true;
//
//     try {
//       final authCredential =
//           await _auth.signInWithCredential(phoneAuthCredential);
//       PreferenceManager.setTokenId(_auth.currentUser!.uid.toString());
//
//       if (authCredential.user != null) {
//         PreferenceManager.setLoginType('mobile');
//         String bearer = await _auth.currentUser!.getIdToken();
//         PreferenceManager.setAuthTokenFirebase(
//             authTokenFirebase: bearer.toString());
//         CommonSnackBar.showSnackBar(
//             successStatus: true, msg: 'Login successful');
//         Future.delayed(Duration(seconds: 2), () {
//           PreferenceManager.setLoginValue(widget.mobileNumber!);
//           _otpScreenController.showLoading = false;
//
//           navigatorScreen();
//         });
//       }
//     } on FirebaseAuthException catch (e) {
//       _otpScreenController.showLoading = false;
//       CommonSnackBar.showSnackBar(msg: '${e.message}', successStatus: false);
//     }
//   }
//
//   bool? exist;
//   var isStatusData;
//   Future<bool?> checkExist() async {
//     try {
//       await FirebaseFirestore.instance
//           .collection("UserAllData")
//           .doc(PreferenceManager.getTokenId())
//           .get()
//           .then((doc) {
//         exist = doc.exists;
//       });
//       return exist;
//     } catch (e) {
//       // If any error
//       return false;
//     }
//   }
//
//   navigatorScreen() async {
//     await checkExist();
//     if (exist == true) {
//       var collection = FirebaseFirestore.instance
//           .collection('UserAllData')
//           .doc(PreferenceManager.getTokenId());
//       var querySnapshot = await collection.get();
//
//       if (querySnapshot['profileDetails'] == true) {
//         PreferenceManager.setFnameId(querySnapshot['name']);
//         PreferenceManager.setProfesson(profession: querySnapshot['Profession']);
//         PreferenceManager.setTransferId(querySnapshot['transaction_id']);
//
//         PreferenceManager.setImage(querySnapshot['userImage']);
//         PreferenceManager.setNotSearchHandel(querySnapshot['user_name']);
//
//         FirebaseFirestore.instance
//             .collection('UserAllData')
//             .doc(querySnapshot['auth_Token'])
//             .update({'fcm_token': PreferenceManager.getFcmToken()});
//
//         if (querySnapshot['isCharges'] == false) {
//           Get.offAll(AppCharges());
//         } else {
//           Get.offAll(NavigationBarScreen());
//         }
//       } else {
//         Get.offAll(ByDefaultScreen());
//       }
//     } else {
//       Get.offAll(ByDefaultScreen());
//     }
//   }
//
//   @override
//   void dispose() {
//     // _controller?.dispose();
//     _textEditingController!.dispose();
//
//     super.dispose();
//   }
//
//   // @override
//   // void initState() {
//   //   super.initState();
//   //
//   //   _controller = AnimationController(
//   //       vsync: this, duration: Duration(seconds: levelClock));
//   //
//   //   _controller?.forward();
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorPicker.themBlackColor,
//       floatingActionButton: CommonButton.proccedButton(
//           name: 'Proceed',
//           onPress: () async {
//             _otpScreenController.showLoading = true;
//
//             if (_textEditingController!.text.length == 6) {
//               PhoneAuthCredential phoneAuthCredential =
//                   PhoneAuthProvider.credential(
//                       verificationId: widget.verificationId!,
//                       smsCode: _textEditingController!.text);
//
//               await signInWithPhoneAuthCredential(phoneAuthCredential);
//
//               _otpScreenController.showLoading = false;
//             } else {
//               _otpScreenController.showLoading = false;
//
//               CommonSnackBar.showSnackBar(
//                   successStatus: false, msg: 'Please valid otp');
//             }
//           }),
//       body: GetBuilder<OtpScreenController>(
//         builder: (controller) {
//           return controller.showLoading
//               ? circularProgress()
//               : Stack(
//                   alignment: Alignment.topRight,
//                   children: [
//                     SingleChildScrollView(
//                       child: Container(
//                         padding: EdgeInsets.all(10),
//                         child: Column(
//                           children: [
//                             CommonSizeBox.commonSizeBox(
//                                 height: Get.height / 16),
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: InkWell(
//                                   onTap: () {
//                                     Get.back();
//                                   },
//                                   child: CommonWidget.svgPicture(
//                                       image: 'assets/svg/left_arrw.svg')),
//                             ),
//                             CommonSizeBox.commonSizeBox(height: 10.sp),
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: CommonText.textBold700PDynamicP(
//                                   fontSize: 17.sp,
//                                   text: 'Register',
//                                   textColor: ColorPicker.buttonColor),
//                             ),
//                             CommonSizeBox.commonSizeBox(height: 8.sp),
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   CommonText.textRegularW400(
//                                       text:
//                                           'We’ve sent an SMS code with an \nactivation code to your phone'),
//                                   CommonText.textBold700PDynamicP(
//                                       text: '${widget.mobileNumber}',
//                                       textColor: ColorPicker.buttonColor)
//                                 ],
//                               ),
//                             ),
//                             CommonSizeBox.commonSizeBox(height: 20.sp),
//                             Align(
//                               alignment: Alignment.centerLeft,
//                               child: CommonText.textMediumDynamicColor400(
//                                   text: 'Verification Code',
//                                   textSize: 13.sp,
//                                   textColor: ColorPicker.whiteColor),
//                             ),
//                             CommonSizeBox.commonSizeBox(height: 10.sp),
//
//                             TextFormField(
//                               keyboardType: TextInputType.number,
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   color: ColorPicker.whiteColor,
//                                   fontWeight: FontWeight.w500,
//                                   fontFamily: 'Poppins'),
//                               controller: _textEditingController,
//                               cursorColor: ColorPicker.whiteColor,
//                               decoration: InputDecoration(
//                                 border: OutlineInputBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(12)),
//                                   borderSide: BorderSide(
//                                       color: ColorPicker.hintTextColor,
//                                       width: 1.5),
//                                 ),
//                                 hintText: 'Ex; 1234',
//                                 contentPadding: EdgeInsets.all(10.sp),
//                                 hintStyle: TextStyle(
//                                     color: Color(0xff0777777),
//                                     fontWeight: FontWeight.w600,
//                                     // fontSize: 10.sp,
//                                     fontFamily: 'Poppins'),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(12)),
//                                   borderSide: BorderSide(
//                                       color: ColorPicker.buttonColor,
//                                       width: 1.5),
//                                 ),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(12)),
//                                   borderSide: BorderSide(
//                                       color: ColorPicker.buttonColor,
//                                       width: 1.5),
//                                 ),
//                               ),
//                             ),
//                             // OTPTextField(
//                             //   onChanged: (value) {
//                             //     //   setState(() {});
//                             //   },
//                             //   length: 6,
//                             //   width: 300, controller: otpController,
//                             //   fieldWidth: 30,
//                             //   style: TextStyle(
//                             //       fontFamily: 'Poppins',
//                             //       fontWeight: FontWeight.w500,
//                             //       color: ColorPicker.whiteColor),
//                             //   // textFieldAlignment: MainAxisAlignment.spaceAround,
//                             //   fieldStyle: FieldStyle.underline,
//                             //
//                             //   otpFieldStyle: OtpFieldStyle(
//                             //       enabledBorderColor: ColorPicker.whiteColor,
//                             //       errorBorderColor: ColorPicker.whiteColor,
//                             //       //backgroundColor: ColorPicker.whiteColor,
//                             //       borderColor: ColorPicker.whiteColor,
//                             //       disabledBorderColor: ColorPicker.whiteColor,
//                             //       focusBorderColor: ColorPicker.whiteColor),
//                             //   onCompleted: (pin) {
//                             //     print("Completed: }" + pin);
//                             //     _textEditingController =
//                             //         TextEditingController(text: pin.toString());
//                             //   },
//                             // ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     CommonWidget.commonStackMark()
//                   ],
//                 );
//         },
//       ),
//     );
//   }
// }
//
// class Countdown extends AnimatedWidget {
//   Countdown({Key? key, required this.animation})
//       : super(key: key, listenable: animation);
//   Animation<int> animation;
//
//   @override
//   build(BuildContext context) {
//     Duration clockTimer = Duration(seconds: animation.value);
//
//     String timerText =
//         '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';
//
//     return CommonText.textMediumDynamicColorP(
//         text: "$timerText", textColor: ColorPicker.whiteColor, textSize: 16.sp);
//   }
// }
