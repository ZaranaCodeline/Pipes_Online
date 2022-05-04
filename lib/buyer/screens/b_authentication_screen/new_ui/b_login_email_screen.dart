import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/authentificaion/b_functions.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/b_login_screen.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/new_ui/b_forgot_password_page.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/new_ui/b_login_phone_no_screen.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/new_ui/b_sign_up_email_screen.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/new_ui/b_sign_up_phone_no_screen.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/register_repo.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/b_navigationbar.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/buyer/screens/terms_condition_page.dart';
import 'package:pipes_online/buyer/view_model/b_login_home_controller.dart';
import 'package:pipes_online/seller/view/s_screens/s_color_picker.dart';
import 'package:pipes_online/seller/view/s_screens/s_image.dart';
import 'package:pipes_online/seller/view/s_screens/s_text_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class BLoginEmailScreen extends StatefulWidget {
  const BLoginEmailScreen({Key? key}) : super(key: key);

  @override
  State<BLoginEmailScreen> createState() => _BLoginEmailScreenState();
}

class _BLoginEmailScreenState extends State<BLoginEmailScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
  bool isLoading = false;
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
              GetBuilder<BLogInController>(
                builder: (controller) {
                  return Container(
                    height: Get.height * 0.9,
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
                                Container(
                                  width: Get.width,
                                  child: Form(
                                    key: formGlobalKey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: Get.height * 0.01,
                                        ),
                                        Text(
                                          'Email',
                                          style: STextStyle.semiBold600Black13,
                                        ),
                                        Container(
                                          height: Get.height * 0.07,
                                          width: Get.width * 1,
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value!.trim().isEmpty) {
                                                return 'This field is required';
                                              } else if (!RegExp('[a-zA-Z]')
                                                  .hasMatch(value)) {
                                                return 'please enter valid name';
                                              }
                                              return null;
                                            },
                                            controller: email,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                                // hintText: "Email",
                                                ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.01,
                                        ),
                                        Text(
                                          'Password',
                                          style: STextStyle.semiBold600Black13,
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.01,
                                        ),
                                        Container(
                                          height: Get.height * 0.07,
                                          width: Get.width * 1,
                                          child: TextFormField(
                                            validator: (password) {
                                              RegExp regex = RegExp(
                                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
                                              if (password!.isEmpty) {
                                                return 'Please enter password';
                                              } else if (!isPasswordValid(
                                                  password)) {
                                                return 'Enter a valid password';
                                              } else if (password.length < 6) {
                                                return 'Password must be altest 6 degit';
                                              }
                                              // else if (!regex.hasMatch(value)) {
                                              //   return 'Enter valid password';
                                              // }
                                              return null;
                                            },
                                            controller: pass,
                                            decoration: InputDecoration(
                                                // hintText: "Password",
                                                ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.02,
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Get.to(
                                                () => BForgotPasswordScreen());
                                          },
                                          child: CustomText(
                                            alignment: Alignment.topLeft,
                                            text: 'Forgot Password?',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.04,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                // RichText(
                                //   textAlign: TextAlign.start,
                                //   text: TextSpan(
                                //     children: [
                                //       TextSpan(
                                //         text: 'By continuing, you agree to the',
                                //         style: STextStyle.regular600Black11,
                                //       ),
                                //       TextSpan(
                                //           text: ' terms and conditions',
                                //           style: STextStyle.semiBold600Purple11,
                                //           recognizer: TapGestureRecognizer()
                                //             ..onTap = () {
                                //               Get.to(() =>
                                //                   TermsAndConditionPage());
                                //               print('Terms and Conditons');
                                //             }),
                                //       TextSpan(
                                //         text: ' of this app.',
                                //         style: STextStyle.regular600Black11,
                                //       ),
                                //     ],
                                //   ),
                                // ),

                                GestureDetector(
                                  onTap: () async {
                                    print('login click');

                                    if (formGlobalKey.currentState!
                                        .validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      print(
                                          'login email========>${email.text.toString()}');
                                      print(
                                          'login password========>${pass.text.toString()}');
                                      SharedPreferences sp =
                                          await SharedPreferences.getInstance();
                                      sp.setString('email', email.text);
                                      formGlobalKey.currentState!.save();
                                      BRegisterRepo()
                                          .LogIn(email.text.trim().toString(),
                                              pass.text.trim().toString())
                                          .then((value) async {
                                        await Get.offAll(
                                            () => BottomNavigationBarScreen());
                                        setState(() {
                                          isLoading = false;
                                        });
                                        /* PreferenceManager.setUId('uid');
                                  PreferenceManager.setUserType('Buyer');
                                  PreferenceManager.setUId('email');*/
                                      }).catchError((e) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'The login is invalid.Please Try again'),
                                            backgroundColor: Colors.redAccent,
                                          ),
                                        );
                                      });
                                    }
                                    // setState(() {
                                    //   isLoading = true;
                                    // });
                                    // await sendOtp(_auth).then(
                                    //   (value) => Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) => VerifyOTP(),
                                    //     ),
                                    //   ),
                                    // );
                                    // isLoading = true;
                                    // if (phoneNumber.text.isNotEmpty) {
                                    //   if (otpCodeVisible) {
                                    //     // verify();
                                    //     verifyCode();
                                    //   } else {
                                    //     await phoneSignIn(
                                    //         phoneNumber: phoneNumber.text);
                                    //   }

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
                                    width: Get.width * 0.5,
                                    height: Get.height * 0.08,
                                    decoration: BoxDecoration(
                                      color: SColorPicker.purple,
                                      borderRadius:
                                          BorderRadius.circular(10.sp),
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
                                            'Login',
                                            style: TextStyle(
                                                color: AppColors
                                                    .commonWhiteTextColor,
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
                                  height: Get.height * 0.04,
                                ),
                                Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      print('it is Signup with Mobile Number');
                                      // setState(() {
                                      Get.to(BLoginPhoneNumberScreen());
                                      // });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(12.sp),
                                      height: Get.height * 0.075,
                                      width: Get.height * 0.4,
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
                                            "${SImagePick.pipesphoneLogo}",
                                            width: 10.sp,
                                            height: 10.sp,
                                          ),
                                          Text(
                                            'Login with Mobile Number',
                                            style: STextStyle.medium400Purple13,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: Get.height * 0.04),
                                Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      print('it is map');
                                      loginwithgoogle();
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
                                            'Login with Google',
                                            style:
                                                STextStyle.semiBold600Black13,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.04,
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
                                            text: '  Sign Up',
                                            style: STextStyle.medium400Purple13,
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                print(
                                                    '=====>BSignUpEmailScreen');
                                                Get.off(
                                                    () => BSignUpEmailScreen());
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

  bool isPasswordValid(String password) => password.length <= 6;

  bool isEmailValid(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    return regex.hasMatch(email);
  }
}
