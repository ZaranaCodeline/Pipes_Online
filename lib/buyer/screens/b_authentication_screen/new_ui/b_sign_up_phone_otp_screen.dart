import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/new_ui/b_first_user_info_screen.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/buyer/view_model/b_login_home_controller.dart';
import 'package:pipes_online/seller/view/s_screens/s_color_picker.dart';
import 'package:pipes_online/seller/view/s_screens/s_image.dart';
import 'package:pipes_online/seller/view/s_screens/s_text_style.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';

class BSignUpPhoneOtpScreen extends StatefulWidget {
  final String? phone;
  final String? verificationId;

  const BSignUpPhoneOtpScreen({Key? key, this.phone, this.verificationId})
      : super(key: key);

  @override
  _BSignUpPhoneOtpScreenState createState() => _BSignUpPhoneOtpScreenState();
}

class _BSignUpPhoneOtpScreenState extends State<BSignUpPhoneOtpScreen> {
  // GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  final _scaffoldState = GlobalKey<ScaffoldState>();

  // final _otpController = OtpFieldController();
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
      // PreferenceManager.setTokenId(_auth.currentUser!.uid.toString());
      PreferenceManager.setUId(_auth.currentUser!.uid.toString());

      if (authCredential.user != null) {
        // PreferenceManager.setLoginType('mobile');
        // String bearer = await _auth.currentUser!.getIdToken();
        // PreferenceManager.setAuthTokenFirebase(
        //     authTokenFirebase: bearer.toString());
        print('Login successful');
        // CommonSnackBar.showSnackBar(
        //     successStatus: true, msg: 'Login successful');

      }
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      print(e.message);
    }
  }

  Future<void> verificationOTPCode(String otp) async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationCode!, smsCode: otp);
    if (phoneAuthCredential == null) {
      _scaffoldState.currentState!.showSnackBar(
        SnackBar(
          content: Text("Please enter valid otp"),
        ),
      );
      return;
    } else {
      PreferenceManager.setPhoneNumber(widget.phone.toString());
      print('phone=========>${widget.phone}');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BFirstUserInfoScreen(
            phone: widget.phone,
          ),
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
    ;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(
      'OTP Sent to ${BLogInController().countryCode}${widget.phone} ',
    );
    // verificationOTPCode();
    verifyPhoneNumber();
  }

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
                  PreferenceManager.setEmail(uid);
                  Get.to(BFirstUserInfoScreen());
                  setState(() {
                    isLoading = false;
                  });
                }
              });
            },
            verificationFailed: (FirebaseAuthException e) {
              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //   content: Text(e.message.toString()),
              //   duration: Duration(seconds: 5),
              // ));
            },
            codeSent: (String? vID, int? resendToken) {
              setState(() {
                verificationCode = vID;
              });
            },
            codeAutoRetrievalTimeout: (String? vID) {
              setState(() {
                verificationCode = vID;
              });
            },
            timeout: Duration(seconds: 60))
        .then(
          (value) => Get.to(() => BFirstUserInfoScreen()),
        )
        .catchError((onError) {
      print(onError.toString());
    });
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
                                      'OTP Sent to.. +${controller.countryCode}-${widget.phone} ',
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
                                  // Container(
                                  //   width: Get.width * 0.85,
                                  //   child: OTPTextField(
                                  //       controller: _otpController,
                                  //       length: 6,
                                  //       width:
                                  //           MediaQuery.of(context).size.width,
                                  //       fieldWidth: 30,
                                  //       style: TextStyle(fontSize: 15),
                                  //       textFieldAlignment:
                                  //           MainAxisAlignment.spaceAround,
                                  //       fieldStyle: FieldStyle.underline,
                                  //       onCompleted: (pin) async {
                                  //         print("Completed: " + pin);
                                  //       },
                                  //       // onCompleted: (pin) async {
                                  //       //   print("Completed: " + pin);
                                  //       //   await FirebaseAuth.instance
                                  //       //       .signInWithCredential(
                                  //       //           PhoneAuthProvider.credential(
                                  //       //               verificationId:
                                  //       //                   verificationCode!,
                                  //       //               smsCode: _otpController
                                  //       //                   .toString()))
                                  //       //       .then((value) async {
                                  //       //     if (value.user != null) {
                                  //       //       print(
                                  //       //           '===============>paas to home');
                                  //       //     }
                                  //       //   }).catchError((e) => print(
                                  //       //           'error===>${e.toString()}'));
                                  //       //   FocusScope.of(context).unfocus();
                                  //       //   _globalKey.currentState?.showSnackBar(
                                  //       //       SnackBar(
                                  //       //           content:
                                  //       //               Text('invalid OTP')));
                                  //       // },
                                  //       onChanged: (pin) {
                                  //         print("onChanged: " + pin);
                                  //       }),
                                  // ),
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
                              GestureDetector(
                                onTap: () async {
                                  PhoneAuthCredential phoneAuthCredential =
                                      PhoneAuthProvider.credential(
                                          verificationId:
                                              widget.verificationId!,
                                          smsCode: pinOTPController.text);
                                  await signInWithPhoneAuthCredential(
                                          phoneAuthCredential)
                                      .then((value) async {
                                    PreferenceManager.setUserType('Buyer');
                                    PreferenceManager.getUserType() == 'Buyer';
                                    print(
                                        'addData==Buyer==login=========${PreferenceManager.getUId()}');
                                    print(
                                        'addData==Buyer==getUserType=========${PreferenceManager.getUserType()}');

                                    await Get.to(() => BFirstUserInfoScreen());
                                    /* PreferenceManager.setUId('uid');
                                  PreferenceManager.setUId('email');
                                  PreferenceManager.setUserType('Seller');*/
                                  });

                                  // setState(() {
                                  //   isLoading = true;
                                  // });
                                  // verifyPhoneNumber();

                                  // await verificationOTPCode;
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: Get.width * 0.6,
                                  height: Get.height * 0.08,
                                  decoration: BoxDecoration(
                                    color: SColorPicker.purple,
                                    borderRadius: BorderRadius.circular(10.sp),
                                  ),
                                  child: isLoading
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CustomText(
                                                text: 'Loading...  ',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.sp,
                                                color: AppColors
                                                    .commonWhiteTextColor),
                                            CircularProgressIndicator(
                                              color: AppColors
                                                  .commonWhiteTextColor,
                                            ),
                                          ],
                                        )
                                      : Text(
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
