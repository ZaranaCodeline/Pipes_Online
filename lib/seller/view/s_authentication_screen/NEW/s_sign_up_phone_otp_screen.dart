import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/seller/view/s_authentication_screen/NEW/s_first_user_info_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_color_picker.dart';
import 'package:pipes_online/seller/view/s_screens/s_image.dart';
import 'package:pipes_online/seller/view/s_screens/s_text_style.dart';
import 'package:pipes_online/seller/view_model/s_login_home_controller.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';

class SSignUpPhoneOtpScreen extends StatefulWidget {
  final String? phone;
  final String? verificationId;

  const SSignUpPhoneOtpScreen({Key? key, this.phone, this.verificationId})
      : super(key: key);

  @override
  _SSignUpPhoneOtpScreenState createState() => _SSignUpPhoneOtpScreenState();
}

class _SSignUpPhoneOtpScreenState extends State<SSignUpPhoneOtpScreen> {
  final _scaffoldState = GlobalKey<ScaffoldState>();

  final TextEditingController pinOTPController = TextEditingController();
  final FocusNode _pinOTPCodeFocus = FocusNode();
  String? verificationCode;

  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {
    isLoading = true;

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      PreferenceManager.setUId(_auth.currentUser!.uid.toString());

      if (authCredential.user != null) {
        print('You are Signed in successfully');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Sign Up successful'),
          duration: Duration(seconds: 5),
        ));
      }
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      print(e.message);
    }
  }

  SLogInController bLogInController = Get.find();
  Future sendOtp() async {
    print(
        '========code===${bLogInController.countryCode}${PreferenceManager.getPhoneNumber()}');
    await _auth.verifyPhoneNumber(
      phoneNumber:
          bLogInController.countryCode.toString() + widget.phone.toString(),
      verificationCompleted: (phoneAuthCredential) async {
        setState(() {
          isLoading = false;
        });
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
            message: 'The phone number entered is invalid',
          ),
        );
        print(
            'The phone number entered is invalid!====${verificationFailed.message}');
      },
      codeSent: (verificationId, resendingToken) async {
        setState(() {
          isLoading = false;
          this.verificationCode = verificationId;
          print('---------verificationId-------$verificationId');
          print('---------this.verificationId-------${this.verificationCode}');

          ///check
          Get.to(
            SSignUpPhoneOtpScreen(
              phone: widget.phone,
              verificationId: verificationId,
            ),
          );
          print('====${verificationId}');
        });
      },
      codeAutoRetrievalTimeout: (verificationId) async {},
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(
      'OTP Sent to ${SLogInController().countryCode}${widget.phone} ',
    );
    // verifyPhoneNumber();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pinOTPController.clear();
    pinOTPController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldState,
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
                      'SIGN UP'.toUpperCase(),
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
                                      'OTP Sent to ${controller.countryCode}-${widget.phone} ',
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
                                                    SFirstUserInfoScreen());
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
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.04,
                              ),
                              TextButton(
                                onPressed: () {
                                  sendOtp();
                                },
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
                              GestureDetector(
                                onTap: () async {
                                  try {
                                    print('Test:------');
                                    setState(() {
                                      isLoading = true;
                                    });
                                    PhoneAuthCredential phoneAuthCredential =
                                        PhoneAuthProvider.credential(
                                            verificationId:
                                                widget.verificationId!,
                                            smsCode: pinOTPController.text);
                                    await signInWithPhoneAuthCredential(
                                            phoneAuthCredential)
                                        .then((value) async {
                                      PreferenceManager.setUId(FirebaseAuth
                                          .instance.currentUser!.uid);
                                      PreferenceManager.getUId();
                                      PreferenceManager.setPhoneNumber(
                                          widget.phone.toString());
                                      PreferenceManager.getPhoneNumber();

                                      PreferenceManager.setUserType('Seller');
                                      PreferenceManager.getUserType() ==
                                          'Buyer';
                                      print(
                                          'addData==Buyer==login=========${PreferenceManager.getUId()}');
                                      print(
                                          'addData==Buyer==getUserType=========${PreferenceManager.getUserType()}');
                                      try {
                                        print('Test:-1');

                                        if (PreferenceManager.getUId() !=
                                            null) {
                                          print('Test:-2');
                                          PreferenceManager.getPhoneNumber();
                                          print(
                                              '=========${PreferenceManager.getPhoneNumber()}');
                                          await Get.to(SFirstUserInfoScreen(
                                            phone: widget.phone,
                                          ))?.then((value) {
                                            pinOTPController.clear();
                                            setState(() {
                                              isLoading = false;
                                            });
                                          });
                                        } else {
                                          print('Test:-3');
                                          GetSnackBar(
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: SColorPicker.red,
                                            duration: Duration(seconds: 5),
                                            message: 'Invalid Credantial',
                                          );
                                        }
                                      } on FirebaseAuthException catch (e) {
                                        print('Test:-4');

                                        print(e);
                                        Get.showSnackbar(
                                          GetSnackBar(
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: SColorPicker.red,
                                            duration: Duration(seconds: 5),
                                            message: e.message,
                                          ),
                                        );
                                      }
                                    });
                                  } catch (e) {
                                    print('=-=-=-${e}');
                                    Get.showSnackbar(
                                      GetSnackBar(
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: SColorPicker.red,
                                        duration: Duration(seconds: 5),
                                        message: 'Please Resend OTP ',
                                      ),
                                    );
                                  }
                                },
                                child: isLoading
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.primaryColor,
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.center,
                                        width: Get.width * 0.6,
                                        height: Get.height * 0.08,
                                        decoration: BoxDecoration(
                                          color: SColorPicker.purple,
                                          borderRadius:
                                              BorderRadius.circular(10.sp),
                                        ),
                                        child: Text(
                                          'SIGN UP',
                                          style: TextStyle(
                                              color: AppColors
                                                  .commonWhiteTextColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
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
