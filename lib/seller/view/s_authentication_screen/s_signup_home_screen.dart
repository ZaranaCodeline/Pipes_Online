import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:pipes_online/seller/common/s_common_button.dart';
import 'package:pipes_online/seller/common/s_image.dart';
import 'package:pipes_online/seller/common/s_text_style.dart';
import 'package:pipes_online/routes/app_routes.dart';
import 'package:pipes_online/seller/view/s_authentication_screen/s_signup_otp_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_cateloge_home_screen.dart';
import 'package:pipes_online/seller/view_model/s_signup_home_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../PhoneAuthFor,.dart';
import '../../../buyer/authentificaion/functions.dart';

class SSignUpHomeScreen extends StatefulWidget {
  @override
  _SSignUpHomeScreenState createState() => _SSignUpHomeScreenState();
}

class _SSignUpHomeScreenState extends State<SSignUpHomeScreen> {
  SSignUpHomeController sSignUpHomeController =
      Get.put(SSignUpHomeController());

  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var verificationCode = '';
  var isRegister = true;
  var isOTPScreen = false;

  TextEditingController _otp = TextEditingController();

  bool otpCodeVisible = false;
  String? verificationId;

  @override
  void dispose() {
    sSignUpHomeController.mobileNumber.dispose();
    super.dispose();
  }
  Future<void> phoneSignIn({required String phoneNumber}) async {
print(phoneNumber);
    await _auth.verifyPhoneNumber(
        phoneNumber: '+91' + phoneNumber,
        verificationCompleted: _onVerificationCompleted,
        verificationFailed: _onVerificationFailed,
        codeSent: _onCodeSent,
        codeAutoRetrievalTimeout: _onCodeTimeout);
  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    print("verification completed ${authCredential.smsCode}");
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      this._otp.text = authCredential.smsCode!;
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
      Get.to(SSignUpOTPScreen(),
          arguments: _otp.text
              .toString());
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => SSignUpOTPScreen()));
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
    Get.to(SSignUpOTPScreen(),arguments:[verificationId,_otp.text]  );
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
        verificationId: verificationId!, smsCode:sSignUpHomeController
        .mobileNumber.text);
    await _auth.signInWithCredential(credential).then((value) {
      print('You are logged in successfully');
    });
  }
  // Future signUp() async {
  //   print('SIGN UP-------');
  //
  //   setState(() {
  //     isLoading = true;
  //   });
  //   var _phoneNumnber = '+91' + sSignUpHomeController.mobileNumber.text.trim();
  //   var verifyPhonenumber = sSignUpHomeController.auth.verifyPhoneNumber(
  //     phoneNumber: _phoneNumnber,
  //     verificationCompleted: (phoneAuthCredential) {
  //       sSignUpHomeController.auth
  //           .signInWithCredential(phoneAuthCredential)
  //           .then(
  //             (user) async => {
  //               if (user != null)
  //                 {
  //                   //logged in
  //                   await _firestore
  //                       .collection('users')
  //                       .doc(sSignUpHomeController.auth.currentUser!.uid)
  //                       .set(
  //                     {
  //                       'cellNumber':
  //                           sSignUpHomeController.mobileNumber.text.trim(),
  //                     },
  //                   ).then(
  //                     (value) => {
  //                       setState(
  //                         () {
  //                           isLoading = false;
  //                           isRegister = false;
  //                           isOTPScreen = false;
  //                           Get.to(() => SCatelogeHomeScreen());
  //                         },
  //                       ),
  //                     },
  //                   ),
  //                 },
  //             },
  //           );
  //     },
  //     verificationFailed: (FirebaseAuthException error) {
  //       debugPrint('Error loggong in :' + error.message!);
  //       setState(() {
  //         isLoading = false;
  //       });
  //     },
  //     codeSent: (verificationId, [forceResendingToken]) {
  //       debugPrint('Gideon test 6');
  //       setState(
  //         () {
  //           isLoading = false;
  //           verificationCode = verificationId;
  //         },
  //       );
  //     },
  //     codeAutoRetrievalTimeout: (String verificationId) {
  //       debugPrint('Gideon test 7');
  //       setState(
  //         () {
  //           isLoading = false;
  //           verificationCode = verificationId;
  //         },
  //       );
  //     },
  //     timeout: Duration(seconds: 60),
  //   );
  //   debugPrint('Gideon test 7');
  //   await verifyPhonenumber;
  //   debugPrint('Gideon test 8');
  // }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Form(
      key: _formKey,
      child: SafeArea(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter mobile number';
                                          }
                                          return null;
                                        },
                                        controller: _otp,
                                        decoration: InputDecoration(
                                            hintText: 'Enter Number',
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
                                    name:'Sign Up',
                                    onTap: () async{
                                      // Get.to(PhoneAuthForm());
                                      if(_formKey.currentState!.validate()){
                                          await phoneSignIn(phoneNumber: _otp.text.trim());
                                          // Get.toNamed(SRoutes.SSignUpOTPScreen);
                                      }
                                      _formKey.currentState!.save();
                                      // sSignUpHomeController.verifyNumber();
                                      // if (_formKey.currentState!.validate()) {
                                      //   // Get.to(() => SSignUpOTPScreen(),
                                      //   //     arguments: sSignUpHomeController
                                      //   //         .mobileNumber.text
                                      //   //         .toString());
                                      //   // Get.toNamed(SRoutes.SSignUpOTPScreen);
                                      // } else {
                                      //   Get.snackbar('InValid',
                                      //       'Please enter mobile number');
                                      //   return 'Please enter mobile number';
                                      // }
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
                                      GestureDetector(
                                        onTap: (){
                                          loginwithgoogle();
                                        },
                                        child: Text(
                                          'Google',
                                          style: STextStyle.semiBold600Black16,
                                        ),
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
      ),
    );
  }
}
