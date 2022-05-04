import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:pinput/pinput.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/new_ui/b_first_user_info_screen.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/new_ui/b_login_email_screen.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/phone.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/b_navigationbar.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/buyer/screens/terms_condition_page.dart';
import 'package:pipes_online/buyer/view_model/b_login_home_controller.dart';
import 'package:pipes_online/routes/app_routes.dart';
import 'package:pipes_online/seller/view/s_screens/s_color_picker.dart';
import 'package:pipes_online/seller/view/s_screens/s_common_button.dart';
import 'package:pipes_online/seller/view/s_screens/s_image.dart';
import 'package:pipes_online/seller/view/s_screens/s_text_style.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';

class BLoginPhoneOtpScreen extends StatefulWidget {
  final String? phone;
  final String? verificationId;

  const BLoginPhoneOtpScreen({Key? key, this.phone, this.verificationId})
      : super(key: key);
  @override
  _BLoginPhoneOtpScreenState createState() => _BLoginPhoneOtpScreenState();
}

class _BLoginPhoneOtpScreenState extends State<BLoginPhoneOtpScreen> {
  final _globalKey = GlobalKey<ScaffoldState>();
  final TextEditingController pinOTPController = TextEditingController();
  final FocusNode _pinOTPCodeFocus = FocusNode();

  final _otpController = OtpFieldController();
  String? verificationCode;
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  verifyPhoneNumber() async {
    await FirebaseAuth.instance
        .verifyPhoneNumber(
            phoneNumber: "+91 ${widget.phone}",
            verificationCompleted: (PhoneAuthCredential credential) async {
              await FirebaseAuth.instance
                  .signInWithCredential(credential)
                  .then((value) {
                if (value.user != null) {
                  String? uid = FirebaseAuth.instance.currentUser!.uid;
                  PreferenceManager.setUId(uid);
                  print('=========${PreferenceManager.getUId()}');
                  Get.to(BFirstUserInfoScreen());
                  setState(() {
                    isLoading = false;
                  });
                }
              });
            },
            verificationFailed: (FirebaseAuthException e) {
              setState(() {
                isLoading = false;
              });
              print('----verificationFailed---${e.message}');
              Get.showSnackbar(
                GetSnackBar(
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: SColorPicker.red,
                  duration: Duration(seconds: 5),
                  message: e.message.toString(),
                ),
              );
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //   content: Text(e.message.toString()),
              //   duration: Duration(seconds: 5),
              // ));
            },
            codeSent: (String? vID, int? resendToken) {
              verificationCode = vID;
            },
            codeAutoRetrievalTimeout: (String? vID) {
              verificationCode = vID;
            },
            timeout: Duration(seconds: 60))
        .then(
          (value) => Get.to(() {
            // PreferenceManager.setUId(_auth.currentUser!.uid.toString());
            PreferenceManager.getUId();
            PreferenceManager.setPhoneNumber(widget.phone.toString());
            print('P========${widget.phone.toString()}');

            if (PreferenceManager.getUId() != null) {
              BFirstUserInfoScreen();
            }
            Get.snackbar('Oops', 'Invalid OTP');
          }),
        )
        .catchError((onError) {
      print(onError.toString());
    });
  }

  logInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {
    try {
      isLoading = true;

      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      if (authCredential.user != null) {
        print('Login successful');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login successful'),
          duration: Duration(seconds: 5),
        ));
      }
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
        duration: Duration(seconds: 5),
      ));
      print('----------ERROR----------');
    }
  }

  Future<void> verificationOTPCode(String otp) async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId!, smsCode: otp);
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
    _auth.signInWithCredential(phoneAuthCredential).then((value) {
      print("You are Signed in successfully");
      Get.showSnackbar(GetSnackBar(
        backgroundColor: SColorPicker.red,
        duration: Duration(seconds: 2),
        message: 'You are logged in successfully',
      ));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    print(
      'OTP Sent to Login +91 ${widget.phone} ',
    );
    print(
      'OTP Sent to Login +91 ${PreferenceManager.getPhoneNumber()} ',
    );
    print(
        'store in PreferenceManager.getPhoneNumber=========${PreferenceManager.getPhoneNumber()}');
    // verificationOTPCode();
    verifyPhoneNumber();
    super.initState();
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
                      'Login'.toUpperCase(),
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
                                      'OTP Sent to +91 ${widget.phone}',
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
                                    child: /*OTPTextField(
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
                                        })*/
                                        Container(
                                      width: Get.width * 0.865,
                                      child: Pinput(
                                        length: 6,
                                        focusNode: _pinOTPCodeFocus,
                                        controller: pinOTPController,
                                        pinAnimationType:
                                            PinAnimationType.rotation,
                                        onSubmitted: (pin) async {
                                          try {
                                            FirebaseAuth.instance
                                                .signInWithCredential(
                                                    PhoneAuthProvider.credential(
                                                        verificationId:
                                                            verificationCode!,
                                                        smsCode: pin))
                                                .then(
                                              (value) {
                                                if (value.user != null) {
                                                  Get.to(() =>
                                                      BFirstUserInfoScreen());
                                                }
                                              },
                                            );
                                          } catch (e) {
                                            FocusScope.of(context).unfocus();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text('Invalid OTP'),
                                                duration: Duration(seconds: 5),
                                              ),
                                            );
                                            print(e);
                                          }
                                        },
                                      ),
                                    ),
                                  ),
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
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 40.sp),
                                child: SCommonButton().sCommonPurpleButton(
                                    name: "Login".toUpperCase(),
                                    onTap: () async {
                                      // setState(() {
                                      //   isLoading = true;
                                      // });
                                      // verifyPhoneNumber();
                                      // // verificationOTPCode(
                                      // //     _otpController.toString());
                                      // // Get.offAll(BottomNavigationBarScreen());
                                      //
                                      // setState(() {
                                      //   isLoading = false;
                                      // });
                                      ///
                                      try {
                                        print(
                                            'Test:----${PreferenceManager.getUId()}--');
                                        PreferenceManager.getUId();
                                        PhoneAuthCredential
                                            phoneAuthCredential =
                                            PhoneAuthProvider.credential(
                                                verificationId:
                                                    widget.verificationId!,
                                                smsCode:
                                                    _otpController.toString());
                                        await logInWithPhoneAuthCredential(
                                                phoneAuthCredential)
                                            .then((value) async {
                                          // PreferenceManager.setUId(FirebaseAuth
                                          //     .instance.currentUser!.uid);
                                          PreferenceManager.getUId();
                                          // PreferenceManager.setPhoneNumber(
                                          //     widget.phone.toString());
                                          // PreferenceManager.getPhoneNumber();
                                          //
                                          // PreferenceManager.setUserType(
                                          //     'Buyer');
                                          // PreferenceManager.getUserType() ==
                                          //     'Buyer';
                                          // print(
                                          //     'addData==Buyer==getUID=========${PreferenceManager.getUId()}');
                                          // print(
                                          //     'addData==Buyer==getUserType=========${PreferenceManager.getUserType()}');
                                          try {
                                            print('Test:-1');

                                            if (PreferenceManager.getUId() !=
                                                null) {
                                              print('Test:-2');
                                              // PreferenceManager
                                              //     .getPhoneNumber();
                                              PreferenceManager
                                                  .getPhoneNumber();
                                              print(
                                                  '===getUId======${PreferenceManager.getUId()}');
                                              print(
                                                  '===getPhone======${PreferenceManager.getPhoneNumber()}');
                                              await Get.to(
                                                  () => BFirstUserInfoScreen(
                                                        phone: widget.phone,
                                                      ));
                                            } else {
                                              print('Test:-3');
                                              GetSnackBar(
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                                backgroundColor:
                                                    SColorPicker.red,
                                                duration: Duration(seconds: 5),
                                                message: 'Invalid Credantial',
                                              );
                                            }
                                          } on FirebaseAuthException catch (e) {
                                            print('Test:-4');

                                            print(e);
                                            Get.showSnackbar(
                                              GetSnackBar(
                                                snackPosition:
                                                    SnackPosition.BOTTOM,
                                                backgroundColor:
                                                    SColorPicker.red,
                                                duration: Duration(seconds: 5),
                                                message: e.message,
                                              ),
                                            );
                                          }
                                        });
                                      } catch (e) {
                                        print('Firebase Exception:- ${e}');
                                        Get.showSnackbar(
                                          GetSnackBar(
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: SColorPicker.red,
                                            duration: Duration(seconds: 5),
                                            message: 'Please Resend OTP ',
                                          ),
                                        );
                                      }
                                    }
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
                                    //         builder: (context) => VerifyOTP(),
                                    //       ),
                                    //     ),
                                    //   );
                                    // } else {}

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
    );
  }
}
