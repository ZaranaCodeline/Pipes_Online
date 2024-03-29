import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/register_repo.dart';
import 'package:pipes_online/routes/app_routes.dart';
import 'package:pipes_online/seller/bottombar/s_navigation_bar.dart';
import 'package:pipes_online/seller/view/s_authentication_screen/s_phone_otp_screen.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../seller/view/s_screens/s_color_picker.dart';
import '../../../seller/view/s_screens/s_text_style.dart';

class SLoginScreen extends StatefulWidget {
  const SLoginScreen({Key? key}) : super(key: key);

  @override
  State<SLoginScreen> createState() => _SLoginScreenState();
}

class _SLoginScreenState extends State<SLoginScreen> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();

    TextEditingController email = TextEditingController();
    TextEditingController pass = TextEditingController();
    bool selected = false;

    @override
    void dispose() {
      email.dispose();
      pass.dispose();
      super.dispose();
    }

    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: Get.height * 0.1,
                  width: Get.width,
                  padding: EdgeInsets.only(
                    top: Get.height * 0.04,
                    right: Get.width * 0.05,
                    left: Get.width * 0.05,
                  ),
                  decoration: BoxDecoration(
                      color: Color(0xff3751AE),
                      borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(20.sp))),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          print('seller');
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: SColorPicker.white,
                        ),
                      ),
                      Text(
                        'Login'.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: STextStyle.bold700White14,
                      ),
                      SizedBox(width: 20.sp),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formGlobalKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          TextFormField(
                            controller: email,
                            decoration: InputDecoration(
                                hintText: 'Email',
                                filled: true,
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.blue.withOpacity(0.5),
                                        width: 2)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.5),
                                        width: 2)),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 2),
                                )),
                            validator: (email) {
                              if (isEmailValid(email!)) {
                                return null;
                              } else {
                                return 'Enter a valid email address';
                              }
                            },
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          TextFormField(
                              obscureText: selected ? false : true,
                              controller: pass,
                              decoration: InputDecoration(
                                  hintText: 'Password',
                                  filled: true,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      selected == false
                                          ? Icons.remove_red_eye
                                          : Icons.remove_red_eye_outlined,
                                      color:
                                          selected ? Colors.black : Colors.grey,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        selected = !selected;
                                      });
                                    },
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.blue.withOpacity(0.5),
                                          width: 2)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.grey.withOpacity(0.5),
                                          width: 2)),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.red, width: 2))),
                              validator: (password) {
                                if (password!.isEmpty) {
                                  return 'Please enter password';
                                } else if (!isPasswordValid(password)) {
                                  return 'Enter a valid password';
                                }
                                return null;
                              }),
                          SizedBox(
                            height: Get.height * 0.05,
                          ),
                          InkWell(
                            child: Container(
                              width: 400,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              )),
                            ),
                            onTap: () async {
                              if (formGlobalKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Processing Data'),
                                    backgroundColor: AppColors.primaryColor,
                                  ),
                                );
                                formGlobalKey.currentState!.save();
                                SRegisterRepo()
                                    .LogIn(email.text.trim().toString(),
                                        pass.text.trim().toString())
                                    .then((value) async {
                                  PreferenceManager.setUserType('Seller');
                                  PreferenceManager.getUserType() == 'Seller';
                                  print(
                                      'addData==seller==login=========${PreferenceManager.getUId()}');
                                  print(
                                      'addData==seller==getUserType=========${PreferenceManager.getUserType()}');

                                  await Get.to(() => NavigationBarScreen());
                                  /* PreferenceManager.setUId('uid');
                                  PreferenceManager.setUId('email');
                                  PreferenceManager.setUserType('Seller');*/
                                }).catchError((e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'The login is invalid.Please Try again'),
                                      backgroundColor: Colors.redAccent,
                                    ),
                                  );
                                });

                                //   RegisterRepo.emailLogin(
                                //           email: email.text.trim(), pass: pass.text.trim())
                                //       .then((value) async {
                                //     await Get.offAll(
                                //         () => BottomNavigationBarScreen());
                                //   });
                                //       /*.then((value) async {
                                //     await addData();
                                //   });*/
                              }
                            },
                          ),
                          SizedBox(
                            height: Get.height * 0.06,
                          ),
                          Center(
                            child: Text(
                              'Or Login With',
                              style: STextStyle.regular400Black13,
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.02,
                              ),
                              height: Get.height * 0.06,
                              width: Get.width * 0.9,
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
                              child: GestureDetector(
                                onTap: () {
                                  // BAuthMethods().signInWithGoogle(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return SPhoneOTP_Screen();
                                      },
                                    ),
                                  );
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.phone,
                                      color: AppColors.primaryColor,
                                    ),
                                    // SvgPicture.asset(
                                    //   "${SImagePick.googleIcon}",
                                    // ),
                                    Text(
                                      ' Phone OTP',
                                      style: STextStyle.bold700Purple16,
                                    )
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
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Or Create an Account?',
                                    style: STextStyle.regular400Black13,
                                  ),
                                  TextSpan(
                                      text: ' Sign Up'.toUpperCase(),
                                      style: STextStyle.medium400Purple13,
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          print('aaa');
                                          //TODO
                                          Get.offNamed(
                                              SRoutes.SSignUpRagistraionScreen);
                                        }),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
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

  // Future<void> addData() async {
  //   String? imageUrl = await uploadImageToFirebase(
  //       context: context, file: _image, fileName: '${email.text}_profile.jpg');
  //   RegisterRepo.currentUser()
  //       .then((value) {
  //     CollectionReference userCollection =
  //     kFirebaseStore.collection('Profile');
  //     userCollection.doc('${PreferenceManager.getUId()}').set({
  //       'email': email.text,
  //       'password': pass.text,
  //       'phoneno': phn.text,
  //       'firstname': fname.text,
  //       'lastname': lname.text,
  //       'imageProfile': imageUrl,
  //     });
  //   })
  //       .catchError((e) => print('Error ===>>> $e'))
  //       .then((value) => Navigator.push(context, MaterialPageRoute(
  //     builder: (context) {
  //       return LoginScreen();
  //     },
  //   )));
  // }

  bool isPasswordValid(String password) => password.length <= 50;

  bool isEmailValid(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    return regex.hasMatch(email);
  }
}
