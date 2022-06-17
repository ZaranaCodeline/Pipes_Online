import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/register_repo.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/seller/view/s_authentication_screen/NEW/s_first_user_info_screen.dart';
import 'package:pipes_online/seller/view/s_authentication_screen/NEW/s_login_email_screen.dart';
import 'package:pipes_online/seller/view/s_authentication_screen/NEW/s_login_phone_otp_screen.dart';
import 'package:pipes_online/seller/view/s_authentication_screen/NEW/s_sign_up_email_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_color_picker.dart';
import 'package:pipes_online/seller/view/s_screens/s_image.dart';
import 'package:pipes_online/seller/view/s_screens/s_text_style.dart';
import 'package:pipes_online/seller/view_model/s_login_home_controller.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';

class SLoginPhoneNumberScreen extends StatefulWidget {
  final String? phone;

  const SLoginPhoneNumberScreen({Key? key, this.phone}) : super(key: key);
  @override
  State<SLoginPhoneNumberScreen> createState() =>
      _SLoginPhoneNumberScreenState();
}

class _SLoginPhoneNumberScreenState extends State<SLoginPhoneNumberScreen> {
  bool isLoading = false;
  final _phoneController = TextEditingController();

  ///BLOgincontroller
  SLogInController sLogInController = Get.find();
  FirebaseAuth _auth = FirebaseAuth.instance;
  String? verificationId;

  int? resendingTokenID;

  final _globalKey = GlobalKey<ScaffoldState>();

  Future sendOtp() async {
    try {
      print(
          '========code===${sLogInController.countryCode}${PreferenceManager.getPhoneNumber()}');

      await _auth.verifyPhoneNumber(
        phoneNumber:
            sLogInController.countryCode.toString() + _phoneController.text,
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
            // currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
            this.verificationId = verificationId;
            print('---------verificationId-------$verificationId');
            print('---------this.verificationId-------${this.verificationId}');
            Get.to(
              SLoginPhoneOtpScreen(
                phone: _phoneController.text,
                verificationId: verificationId,
              ),
            );
            print('====${verificationId}');
          });
        },
        codeAutoRetrievalTimeout: (verificationId) async {},
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${e.message}'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('--code---${sLogInController.countryCode.toString()}');
    print('_phoneController.text=>${_phoneController.text}');
    print(
        '_phoneController.PreferenceManager=>${PreferenceManager.getPhoneNumber()}');
    print(
        '_phoneController.PreferenceManager getUId=>${PreferenceManager.getUId()}');
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
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
                      'Login'.toUpperCase(),
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
                      clipBehavior: Clip.none,
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
                                  height: Get.height * 0.04,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: Get.height * 0.07,
                                      width: Get.width * 0.2,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.sp),
                                          border:
                                              Border.all(color: Colors.grey)),
                                      alignment: Alignment.center,
                                      child: CountryCodePicker(
                                        onChanged: (val) {
                                          controller.setCountryCode(val);
                                        },
                                        initialSelection: '+00',
                                        favorite: ['+91', 'IN'],
                                        showCountryOnly: false,
                                        showOnlyCountryWhenClosed: false,
                                        hideMainText: true,
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
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          hintText: "Enter phone Number",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.08,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        isScrollControlled: true,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Container(
                                            height: Get.height,
                                            width: Get.width,
                                            color: Colors.black12,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                color: AppColors.primaryColor
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          );
                                        });
                                    sendOtp();

                                    // if (PreferenceManager.getUId() != null) {
                                    //   sendOtp();
                                    // } else {
                                    //   ScaffoldMessenger.of(context)
                                    //       .showSnackBar(
                                    //     SnackBar(
                                    //       content: Text(
                                    //           'This Mobile number is not register'),
                                    //     ),
                                    //   );
                                    //   setState(() {
                                    //     isLoading = false;
                                    //   });
                                    // }
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
                                    child: Text(
                                      'Send OTP',
                                      style: TextStyle(
                                          color: AppColors.commonWhiteTextColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.03,
                                ),
                                Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      print('Login with Email');
                                      // setState(() {
                                      Get.to(() => SLoginEmailScreen());
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
                                            'Login with Email',
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
                                      print('seller---login with google');
                                      loginwithgoogle().then((value) {
                                        Get.to(SFirstUserInfoScreen());
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(12.sp),
                                      height: Get.height * 0.075,
                                      width: Get.width * 0.8,
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
                                            "${SImagePick.googleIcon}",
                                          ),
                                          Text(
                                            'Sign In with Google',
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
                                          text: 'Don’t have an Account?',
                                          style: STextStyle.regular400Black13,
                                        ),
                                        TextSpan(
                                            text: ' Sign Up',
                                            style: STextStyle.medium400Purple13,
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                print('=====>Login');
                                                Get.off(SSignUpEmailScreen());
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
