// import 'package:consultancy/ViewModel/country_pick_viewmode.dart';
// import 'package:consultancy/common/button_common.dart';
// import 'package:consultancy/common/circularprogress_indicator.dart';
// import 'package:consultancy/common/common_widget.dart';
// import 'package:consultancy/common/coomon_snackbar.dart';
// import 'package:consultancy/common/preference_manager.dart';
// import 'package:consultancy/common/size_box.dart';
// import 'package:consultancy/customPackage/lib/country_code_picker.dart';
// import 'package:consultancy/res/Colors/colors_class.dart';
// import 'package:consultancy/res/text/text_common.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
//
// import 'otp_screen.dart';
//
// enum MobileVerificationState {
//   SHOW_MOBILE_FORM_STATE,
//   SHOW_OTP_FORM_STATE,
// }
//
// class CountryPicker extends StatefulWidget {
//   const CountryPicker({Key? key}) : super(key: key);
//
//   @override
//   _CountryPickerState createState() => _CountryPickerState();
// }
//
// class _CountryPickerState extends State<CountryPicker> {
//   CountryPickViewModel _countryPickViewModel = Get.find();
//   String? verificationId;
//
//   TextEditingController _textEditingController = TextEditingController();
//   bool showLoading = false;
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   MobileVerificationState currentState =
//       MobileVerificationState.SHOW_MOBILE_FORM_STATE;
//   var con;
//   bool isTermCondition = false;
//   @override
//   Widget build(BuildContext context) {
//     // ModalProgressHUD
//
//     return GetBuilder<CountryPickViewModel>(
//       builder: (controller) => Scaffold(
//         floatingActionButton: CommonButton.proccedButton(
//             name: 'Proceed',
//             onPress: () async {
//               if (_countryPickViewModel.isDropMenu != '') {
//                 if (_textEditingController.text.length == 10) {
//                   setState(() {
//                     showLoading = true;
//                   });
//
//                   await _auth.verifyPhoneNumber(
//                     phoneNumber:
//                         controller.countryCode + _textEditingController.text,
//                     verificationCompleted: (phoneAuthCredential) async {
//                       setState(() {
//                         showLoading = false;
//                       });
//                       // signInWithPhoneAuthCredential(phoneAuthCredential);
//                     },
//                     verificationFailed: (verificationFailed) async {
//                       setState(() {
//                         showLoading = false;
//                       });
//                       print(
//                           '----verificationFailed---${verificationFailed.message}');
//                       CommonSnackBar.showSnackBar(
//                           msg: verificationFailed.message,
//                           successStatus: false);
//                     },
//                     codeSent: (verificationId, resendingToken) async {
//                       setState(() {
//                         showLoading = false;
//                         currentState =
//                             MobileVerificationState.SHOW_OTP_FORM_STATE;
//                         this.verificationId = verificationId;
//                         print('---------verificationId-------$verificationId');
//                         print(
//                             '---------this.verificationId-------${this.verificationId}');
//
//                         Get.to(OtpScreen(
//                           mobileNumber: controller.countryCode +
//                               _textEditingController.text,
//                           verificationId: verificationId,
//                         ));
//                       });
//                     },
//                     codeAutoRetrievalTimeout: (verificationId) async {},
//                   );
//                 } else {
//                   CommonSnackBar.showSnackBar(
//                       msg: 'Please enter your mobile number');
//                 }
//               } else {
//                 CommonSnackBar.showSnackBar(msg: 'Please choose a country');
//               }
//             }),
//         backgroundColor: ColorPicker.themBlackColor,
//         body: showLoading
//             ? circularProgress()
//             : Stack(
//                 alignment: Alignment.topRight,
//                 children: [
//                   SingleChildScrollView(
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 20.sp),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CommonSizeBox.commonSizeBox(height: Get.height / 16),
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: InkWell(
//                                 onTap: () {
//                                   Get.back();
//                                 },
//                                 child: CommonWidget.svgPicture(
//                                     image: 'assets/svg/left_arrw.svg')),
//                           ),
//                           CommonSizeBox.commonSizeBox(height: 10.sp),
//                           CommonWidget.registerText(),
//                           CommonSizeBox.commonSizeBox(height: 20.sp),
//
//                           CountryCodePicker(
//                             onChanged: (value) {
//                               // countryCode = value.dialCode.toString();
//                               _countryPickViewModel.isDropMenu =
//                                   value.name.toString();
//                               _countryPickViewModel.countryCode =
//                                   value.dialCode.toString();
//                               print(
//                                   '---------COUNTRY CODE ${value.dialCode.toString()}');
//                             },
//                             //hideMainText: true,
//                             initialSelection: "IN",
//                             showCountryOnly: false,
//
//                             showFlagDialog: true,
//                             showOnlyCountryWhenClosed: true,
//                             showFlag: false,
//                             showDropDownButton: false,
//                           ),
//                           Divider(
//                             thickness: 1,
//                             color: ColorPicker.whiteColor,
//                           ),
//                           Row(
//                             children: [
//                               Container(
//                                 color: Colors.transparent,
//                                 width: Get.width / 6,
//                                 height: 63,
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     Spacer(),
//                                     CommonText.textMediumP(
//                                         text:
//                                             '${controller.countryCode.isNotEmpty ? controller.countryCode : '+'}'),
//                                     Divider(
//                                       thickness: 1,
//                                       color: ColorPicker.whiteColor,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Spacer(),
//                               Container(
//                                 //color: Colors.deepOrange,
//                                 width: Get.width / 1.6,
//                                 height: 50,
//                                 child: TextFormField(
//                                   controller: _textEditingController,
//                                   cursorColor: ColorPicker.whiteColor,
//                                   style: CommonText.textStyleSemiBold600(),
//                                   keyboardType: TextInputType.number,
//
//                                   maxLength: 10, maxLengthEnforced: true,
//                                   // style: TextStyle(color: ColorPicker.whiteColor),
//                                   inputFormatters: [
//                                     LengthLimitingTextInputFormatter(10),
//                                     FilteringTextInputFormatter.digitsOnly
//                                   ],
//                                   decoration: InputDecoration(
//                                       counterText: '',
//                                       focusedBorder: UnderlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: ColorPicker.whiteColor),
//                                       ),
//                                       enabledBorder: UnderlineInputBorder(
//                                         borderSide: BorderSide(
//                                             color: ColorPicker.whiteColor),
//                                       ),
//                                       fillColor: ColorPicker.whiteColor),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           CommonSizeBox.commonSizeBox(height: Get.height / 40),
//
//                           CommonText.textMediumP(
//                               text:
//                                   'Please confirm your country code and enter your  phone number.'),
//                           CommonSizeBox.commonSizeBox(height: Get.height / 30),
//
//                           Row(
//                             children: [
//                               Container(
//                                   height: 26.sp,
//                                   width: 26.sp,
//                                   child:
//                                       SvgPicture.asset('assets/svg/check.svg')),
//                               CommonSizeBox.commonSizeBox(
//                                   width: Get.width / 30),
//                               CommonText.textSemiBoldDynamicP(
//                                 text: 'Sync Contacts',
//                                 textColor: ColorPicker.whiteColor,
//                               )
//                             ],
//                           ),
//                           Container(
//                             height: 60,
//                             child: Row(
//                               children: [
//                                 InkWell(
//                                   child: isTermCondition
//                                       ? Container(
//                                           height: 26.sp,
//                                           width: 26.sp,
//                                           child: SvgPicture.asset(
//                                               'assets/svg/check.svg'))
//                                       : Container(
//                                           height: 26.sp,
//                                           width: 26.sp,
//                                           child: Image.asset(
//                                             'assets/images/Mark.png',
//                                             scale: 2,
//                                           ),
//                                         ),
//                                   onTap: () {
//                                     isTermCondition = !isTermCondition;
//                                     setState(() {});
//                                   },
//                                 ),
//                                 CommonSizeBox.commonSizeBox(
//                                     width: Get.width / 30),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     CommonText.textSemiBoldDynamicP(
//                                         text: "Please confirm acceptance of ",
//                                         textColor: ColorPicker.whiteColor),
//                                     Row(
//                                       children: [
//                                         CommonText.textSemiBoldDynamicP(
//                                             text: "+App’s ",
//                                             textColor: ColorPicker.whiteColor),
//                                         CommonText.textSemiBoldDynamicP(
//                                             text: "terms & conditions",
//                                             textColor: Color(0xffF0B8B8))
//                                       ],
//                                     )
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//
//                           //  TextFormField()
//                         ],
//                       ),
//                     ),
//                   ),
//                   CommonWidget.commonStackMark()
//                 ],
//               ),
//       ),
//     );
//   }
// }
