import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/new_ui/b_first_user_info_screen.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/new_ui/b_login_email_screen.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/new_ui/b_sign_up_phone_no_screen.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/register_repo.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/buyer/screens/terms_condition_page.dart';
import 'package:pipes_online/buyer/view_model/b_login_home_controller.dart';
import 'package:pipes_online/seller/view/s_screens/s_color_picker.dart';
import 'package:pipes_online/seller/view/s_screens/s_image.dart';
import 'package:pipes_online/seller/view/s_screens/s_text_style.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';

class BSignUpEmailScreen extends StatefulWidget {
  const BSignUpEmailScreen({Key? key}) : super(key: key);

  @override
  State<BSignUpEmailScreen> createState() => _BSignUpEmailScreenState();
}

class _BSignUpEmailScreenState extends State<BSignUpEmailScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController conPass = TextEditingController();
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isGoogleLoading = false;
  bool selectedPass = false;
  bool selectedCPass = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PreferenceManager.getFcmToken();

    PreferenceManager.getEmail();
    PreferenceManager.getPhoneNumber();
    print(
        'b sign up screen getUserType ======>${PreferenceManager.getUserType()}');
  }

  @override
  void dispose() {
    email.clear();
    pass.clear();
    conPass.clear();
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
                    height: Get.height * 1,
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
                                      // Text(
                                      Text(
                                        'Email',
                                        style: STextStyle.semiBold600Black13,
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.02,
                                      ),
                                      Container(
                                        height: Get.height * 0.06,
                                        width: Get.width * 1,
                                        child: TextFormField(
                                          validator: (email) {
                                            if (isEmailValid(email!)) {
                                              return null;
                                            } else {
                                              return 'Enter a valid email address';
                                            }
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
                                        height: Get.height * 0.02,
                                      ),
                                      Text(
                                        'Password',
                                        style: STextStyle.semiBold600Black13,
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.025,
                                      ),
                                      Container(
                                        height: Get.height * 0.06,
                                        width: Get.width * 1,
                                        child: TextFormField(
                                          validator: (password) {
                                            RegExp regex = RegExp(
                                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                            if (password!.isEmpty) {
                                              return 'Please enter password';
                                            } else if (!regex
                                                .hasMatch(password)) {
                                              return 'Use a combination of uppercase letters, lower case letters,numbers, and special characters';
                                            }
                                            return null;
                                          },
                                          obscureText:
                                              selectedPass ? false : true,
                                          controller: pass,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                              suffixIcon: IconButton(
                                            icon: Icon(
                                              selectedPass == false
                                                  ? Icons.remove_red_eye
                                                  : Icons
                                                      .remove_red_eye_outlined,
                                              color: selectedPass
                                                  ? Colors.black
                                                  : Colors.grey,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                selectedPass = !selectedPass;
                                              });
                                            },
                                          )
                                              // hintText: "Password",
                                              ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.025,
                                      ),
                                      Text(
                                        'Confirm Password',
                                        style: STextStyle.semiBold600Black13,
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.02,
                                      ),
                                      Container(
                                        height: Get.height * 0.063,
                                        width: Get.width * 1,
                                        child: TextFormField(
                                          validator: (password) {
                                            if (password!.isEmpty) {
                                              return 'Please enter confirm password';
                                            } else if (password != pass.text) {
                                              return 'Confirm Password does not match ';
                                            }
                                            return null;
                                          },
                                          obscureText:
                                              selectedCPass ? false : true,
                                          controller: conPass,
                                          decoration: InputDecoration(
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                selectedCPass == false
                                                    ? Icons.remove_red_eye
                                                    : Icons
                                                        .remove_red_eye_outlined,
                                                color: selectedCPass
                                                    ? Colors.black
                                                    : Colors.grey,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  selectedCPass =
                                                      !selectedCPass;
                                                });
                                              },
                                            ),
                                            // hintText: " Confirm Password",
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.03,
                              ),
                              RichText(
                                textAlign: TextAlign.start,
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
                                            Get.to(TermsAndConditionPage());
                                            print('Terms and Conditons');
                                          }),
                                    TextSpan(
                                      text: ' of this app.',
                                      style: STextStyle.regular600Black11,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.03,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  print('It is me');
                                  if (formGlobalKey.currentState!.validate()) {
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
                                    formGlobalKey.currentState!.save();
                                    try {
                                      BRegisterRepo.emailRegister(
                                              email: email.text,
                                              pass: pass.text)
                                          .then((value) async {
                                        PreferenceManager.setEmail(email.text);

                                        print(
                                            '-PRE_Email-${PreferenceManager.getEmail()}');
                                        PreferenceManager.getEmail();
                                        PreferenceManager.getUserType();
                                        Get.showSnackbar(
                                          GetSnackBar(
                                            snackPosition: SnackPosition.BOTTOM,
                                            duration: Duration(seconds: 5),
                                            message:
                                                'Sign up successfully done',
                                          ),
                                        );
                                        setState(() {
                                          isLoading = false;
                                        });
                                      });
                                    } on firebase_storage
                                        .FirebaseException catch (error) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text('ERROR :- ${error}'),
                                        duration: Duration(seconds: 5),
                                      ));
                                    }
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: Get.width * 0.6,
                                  height: Get.height * 0.08,
                                  decoration: BoxDecoration(
                                    color: SColorPicker.purple,
                                    borderRadius: BorderRadius.circular(10.sp),
                                  ),
                                  child: Text(
                                    'Sign Up',
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
                                    print('it is Signup with Mobile Number');
                                    // setState(() {
                                    Get.to(BSignUpPhoneNumberScreen());
                                    // });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10.sp),
                                    height: Get.height * 0.075,
                                    width: Get.height * 0.5,
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
                                        SizedBox(
                                          width: Get.width * 0.01,
                                        ),
                                        Text(
                                          'SignUp with Mobile Number',
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
                                    setState(() {
                                      isGoogleLoading = true;
                                    });
                                    print('it is Signup with Google');
                                    print('ID->${PreferenceManager.getUId()}');
                                    loginwithgoogle().then((value) {
                                      Get.to(BFirstUserInfoScreen(
                                        email: email.text,
                                      ));
                                      setState(() {
                                        isGoogleLoading = false;
                                      });

                                      ///
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
                                                child:
                                                    CircularProgressIndicator(
                                                  color: AppColors.primaryColor
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            );
                                          });
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(10.sp),
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
                                          'SignUp with Google',
                                          style: STextStyle.semiBold600Black13,
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
                                        text: 'Already registered?',
                                        style: STextStyle.regular400Black13,
                                      ),
                                      TextSpan(
                                          text: '  Login',
                                          style: STextStyle.medium400Purple13,
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              print('=====>Login');
                                              Get.off(BLoginEmailScreen());
                                            }),
                                    ],
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

  Future<String?> uploadImageToFirebase(
      {BuildContext? context, String? fileName, File? file}) async {
    try {
      var response = await firebase_storage.FirebaseStorage.instance
          .ref('uploads/$fileName')
          .putFile(file!);
      print("Response>>>>>>>>>>>>>>>>>>$response");
      return response.storage.ref('uploads/$fileName').getDownloadURL();
    } catch (e) {
      print(e);
    }
  }

  bool isPasswordValid(String password) => password.length <= 50;

  bool isEmailValid(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    return regex.hasMatch(email);
  }
}
