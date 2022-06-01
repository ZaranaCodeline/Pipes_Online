import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/b_navigationbar.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/buyer/view_model/b_login_home_controller.dart';
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
  String? verificationCode;
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;

  // verifyPhoneNumber() async {
  //   await FirebaseAuth.instance
  //       .verifyPhoneNumber(
  //           phoneNumber: "+91 ${widget.phone}",
  //           verificationCompleted: (PhoneAuthCredential credential) async {
  //             await FirebaseAuth.instance
  //                 .signInWithCredential(credential)
  //                 .then((value) {
  //               if (value.user != null) {
  //                 String? uid = FirebaseAuth.instance.currentUser!.uid;
  //                 PreferenceManager.setUId(uid);
  //                 print('=========${PreferenceManager.getUId()}');
  //
  //                 ///TODO fix routes
  //                 Get.to(() => BottomNavigationBarScreen());
  //                 setState(() {
  //                   isLoading = false;
  //                 });
  //               }
  //             });
  //           },
  //           verificationFailed: (FirebaseAuthException e) {
  //             setState(() {
  //               isLoading = false;
  //             });
  //             print('----verificationFailed---${e.message}');
  //             Get.showSnackbar(
  //               GetSnackBar(
  //                 snackPosition: SnackPosition.BOTTOM,
  //                 backgroundColor: SColorPicker.red,
  //                 duration: Duration(seconds: 5),
  //                 message:
  //                     'The format of the phone number provided is incorrect.',
  //               ),
  //             );
  //           },
  //           codeSent: (String? vID, int? resendToken) {
  //             verificationCode = vID;
  //           },
  //           codeAutoRetrievalTimeout: (String? vID) {
  //             verificationCode = vID;
  //           },
  //           timeout: Duration(seconds: 60))
  //       .then(
  //         (value) => Get.to(() {
  //           PreferenceManager.getUId();
  //           PreferenceManager.setPhoneNumber(widget.phone.toString());
  //           print('P========${widget.phone.toString()}');
  //           if (PreferenceManager.getUId() != null) {
  //             BottomNavigationBarScreen();
  //           }
  //           Get.snackbar('Oops', 'Invalid OTP');
  //         }),
  //       )
  //       .catchError((onError) {
  //     print(onError.toString());
  //   });
  // }

  signInWithPhoneAuthCredential(PhoneAuthCredential phoneAuthCredential) async {
    isLoading = true;

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      PreferenceManager.setUId(_auth.currentUser!.uid.toString());
      if (authCredential.user != null) {
        print('Login successful');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login successful'),
          duration: Duration(seconds: 5),
        ));
        Future.delayed(Duration(seconds: 2), () {
          isLoading = false;

          Get.offAll(BottomNavigationBarScreen());
        });
      }
    } on FirebaseAuthException catch (e) {
      print('--ERROR----');
      isLoading = false;
      print(e.message);
    }
  }

  // Future<void> verificationOTPCode(String otp) async {
  //   PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
  //       verificationId: widget.verificationId!, smsCode: otp);
  //   if (phoneAuthCredential == null) {
  //     _globalKey.currentState!.showSnackBar(
  //       SnackBar(
  //         content: Text("Please enter valid otp"),
  //       ),
  //     );
  //     return;
  //   } else {
  //     await FirebaseAuth.instance.signInWithCredential(phoneAuthCredential);
  //
  //     print("successful");
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => BottomNavigationBarScreen(),
  //       ),
  //     );
  //   }
  //   _auth.signInWithCredential(phoneAuthCredential).then((value) {
  //     print("You are Signed in successfully");
  //     Get.showSnackbar(GetSnackBar(
  //       backgroundColor: SColorPicker.red,
  //       duration: Duration(seconds: 2),
  //       message: 'You are logged in successfully',
  //     ));
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    print(
      'OTP Sent to Login +91 ${widget.phone} ',
    );
    print(
        'store in PreferenceManager.getPhoneNumber=========${PreferenceManager.getPhoneNumber()}');
    // verificationOTPCode(widget.verificationId!);
    // verifyPhoneNumber();

    super.initState();
  }

  BLogInController bLogInController = Get.find();

  Future sendOtp() async {
    isLoading = true;
    print('========code===${bLogInController.countryCode}${widget.phone}');

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
            message: verificationFailed.message,
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
          Get.to(
            BLoginPhoneOtpScreen(
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
  void dispose() {
    pinOTPController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _globalKey,
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
                                    child: Container(
                                      width: Get.width * 0.865,
                                      child: Pinput(
                                        length: 6,
                                        focusNode: _pinOTPCodeFocus,
                                        controller: pinOTPController,
                                        pinAnimationType:
                                            PinAnimationType.rotation,
                                        onSubmitted: (pin) async {
                                          print('Check--1');
                                          setState(() {
                                            isLoading = true;
                                          });
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
                                                  print('Test-call-1');
                                                  Get.offAll(
                                                      BottomNavigationBarScreen());
                                                }
                                              },
                                            );
                                          } catch (e) {
                                            print('Check--1');
                                            setState(() {
                                              isLoading = false;
                                            });
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
                                onPressed: () async {
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
                                  // try {
                                  //   print('Test:------');
                                  //   setState(() {
                                  //     isLoading = true;
                                  //   });
                                  //   PhoneAuthCredential phoneAuthCredential =
                                  //   PhoneAuthProvider.credential(
                                  //       verificationId:
                                  //       widget.verificationId!,
                                  //       smsCode: pinOTPController.text);
                                  //   await signInWithPhoneAuthCredential(
                                  //       phoneAuthCredential)
                                  //       .then((value) async {
                                  //     PreferenceManager.setUId(FirebaseAuth
                                  //         .instance.currentUser!.uid);
                                  //     PreferenceManager.getUId();
                                  //     PreferenceManager.setPhoneNumber(
                                  //         widget.phone.toString());
                                  //     PreferenceManager.getPhoneNumber();
                                  //
                                  //     PreferenceManager.setUserType('Buyer');
                                  //     PreferenceManager.getUserType() ==
                                  //         'Buyer';
                                  //     print(
                                  //         'addData==Buyer==login=========${PreferenceManager.getUId()}');
                                  //     print(
                                  //         'addData==Buyer==getUserType=========${PreferenceManager.getUserType()}');
                                  //     try {
                                  //       print('Test:-1');
                                  //
                                  //       if (PreferenceManager.getUId() !=
                                  //           null) {
                                  //         print('Test:-2');
                                  //         PreferenceManager.getPhoneNumber();
                                  //         print(
                                  //             'PhoneNumber=========${PreferenceManager.getPhoneNumber()}');
                                  //         await Get.to(BottomNavigationBarScreen())?.then((value) {
                                  //           pinOTPController.clear();
                                  //           setState(() {
                                  //             isLoading = false;
                                  //           });
                                  //         });
                                  //       } else {
                                  //         print('Test:-3');
                                  //         GetSnackBar(
                                  //           snackPosition: SnackPosition.BOTTOM,
                                  //           backgroundColor: SColorPicker.red,
                                  //           duration: Duration(seconds: 5),
                                  //           message: 'Invalid Credantial',
                                  //         );
                                  //       }
                                  //     } on FirebaseAuthException catch (e) {
                                  //       print('Test:-4');
                                  //
                                  //       print(e);
                                  //       Get.showSnackbar(
                                  //         GetSnackBar(
                                  //           snackPosition: SnackPosition.BOTTOM,
                                  //           backgroundColor: SColorPicker.red,
                                  //           duration: Duration(seconds: 5),
                                  //           message: e.message,
                                  //         ),
                                  //       );
                                  //     }
                                  //   });
                                  // } catch (e) {
                                  //   print('=-=-=-${e}');
                                  //   Get.showSnackbar(
                                  //     GetSnackBar(
                                  //       snackPosition: SnackPosition.BOTTOM,
                                  //       backgroundColor: SColorPicker.red,
                                  //       duration: Duration(seconds: 5),
                                  //       message: 'Please Resend OTP ',
                                  //     ),
                                  //   );
                                  // }
                                  setState(() {
                                    isLoading = true;
                                  });
                                  try {
                                    print('Check--3');
                                    PhoneAuthCredential phoneAuthCredential =
                                        PhoneAuthProvider.credential(
                                            verificationId:
                                                widget.verificationId!,
                                            smsCode: pinOTPController.text);
                                    await signInWithPhoneAuthCredential(
                                            phoneAuthCredential)
                                        .then(
                                      (value) async {
                                        print(
                                            '--buyer--${phoneAuthCredential.signInMethod}');
                                        PreferenceManager.setUId(FirebaseAuth
                                            .instance.currentUser!.uid);
                                        PreferenceManager.getUId();
                                        print(
                                            '==UserID===${PreferenceManager.getUId()}');
                                        print(
                                            '==UserPhone===${PreferenceManager.getPhoneNumber()}');
                                        PreferenceManager.setPhoneNumber(
                                            widget.phone.toString());
                                        PreferenceManager.getPhoneNumber();

                                        PreferenceManager.setUserType('Buyer');
                                        PreferenceManager.getUserType() ==
                                            'Buyer';
                                        print(
                                            'addData==Buyer==login=========${PreferenceManager.getUId()}');
                                        print(
                                            'addData==Buyer==getUserType=========${PreferenceManager.getUserType()}');
                                        try {
                                          print('Check--4');

                                          if (PreferenceManager.getUId() !=
                                              null) {
                                            print('Check--5');
                                            PreferenceManager.getPhoneNumber();
                                            print(
                                                '=========${PreferenceManager.getPhoneNumber()}');
                                            if (phoneAuthCredential == null) {
                                              _globalKey.currentState!
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      "Please enter valid otp"),
                                                ),
                                              );
                                              return await Get.off(
                                                      BottomNavigationBarScreen())
                                                  ?.then((value) {
                                                pinOTPController.clear();
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              });
                                            }
                                          } else {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            print('Check--6');
                                            GetSnackBar(
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              backgroundColor: SColorPicker.red,
                                              duration: Duration(seconds: 5),
                                              message: 'Invalid Credantial',
                                            );
                                          }
                                        } on FirebaseAuthException catch (e) {
                                          print('Test:-7');
                                          setState(() {
                                            isLoading = false;
                                          });
                                          print(e);
                                          Get.showSnackbar(
                                            GetSnackBar(
                                              snackPosition:
                                                  SnackPosition.BOTTOM,
                                              backgroundColor: SColorPicker.red,
                                              duration: Duration(seconds: 5),
                                              message: e.message,
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  } catch (e) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    print('Check--7-${e}');
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
                                          'Login',
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
