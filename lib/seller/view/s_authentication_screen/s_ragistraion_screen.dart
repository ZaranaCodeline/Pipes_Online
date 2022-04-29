import 'dart:math';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/register_repo.dart';
import 'package:pipes_online/buyer/screens/maps_screen.dart';
import 'package:pipes_online/buyer/view_model/geolocation_controller.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/b_login_screen.dart';
import 'package:pipes_online/routes/app_routes.dart';
import 'package:pipes_online/s_onboarding_screen/s_buyer_seller_contoller.dart';
import 'package:pipes_online/seller/view/s_authentication_screen/s_login_creen.dart';

import 'package:sizer/sizer.dart';
import '../../../buyer/screens/b_image.dart';
import '../../../routes/bottom_controller.dart';
import '../../../seller/view/s_screens/s_color_picker.dart';
import '../../../seller/view/s_screens/s_image.dart';
import '../../../seller/view/s_screens/s_text_style.dart';
import '../../../shared_prefarence/shared_prefarance.dart';

class SSignUpRagistraionScreen extends StatefulWidget {
  const SSignUpRagistraionScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SSignUpRagistraionScreenState createState() =>
      _SSignUpRagistraionScreenState();
}

class _SSignUpRagistraionScreenState extends State<SSignUpRagistraionScreen> {
  File? _image;
  GeolocationController _controller = Get.find();
  BottomController homeController = Get.find();
  final picker = ImagePicker();
  BuyerSellerController buyerSellerController =
      Get.put(BuyerSellerController());

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile!.path);
      print(_image);
    });
  }

  Future getGalleryImage() async {
    var imaGe = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (imaGe != null) {
        _image = File(imaGe.path);
        print("=============ImagePath==========${imaGe.path}");
        imageCache!.clear();
      } else {
        print('no image selected');
      }
    });
  }

  Future getCamaroImage() async {
    var imaGe = await picker.getImage(source: ImageSource.camera);
    print("==========ImagePath=============${imaGe!.path}");
    setState(() {
      if (imaGe != null) {
        _image = File(imaGe.path);
        print("===========ImagePath============${_image}");
        print("=============ImagePath==========${imaGe.path}");

        imageCache!.clear();
      } else {
        print('no image selected');
      }
    });
  }

  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addController = TextEditingController();
  TextEditingController mobileCnt = TextEditingController();
  BottomController bottomController = Get.find();
  String? Img;
  bool selected = false;
  int hobbySelected = 0;
  bool? password;
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController phn = TextEditingController();
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  String _userName = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: GetBuilder<GeolocationController>(
              builder: (controller) {
                return Column(
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
                            'sign up'.toUpperCase(),
                            style: STextStyle.bold700White14,
                          ),
                          SizedBox(width: 20.sp),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: formGlobalKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Center(
                                  child: Column(
                                    children: [
                                      //assets/images/profile.png
                                      GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet<void>(
                                            elevation: 0.5,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        const Radius.circular(
                                                            20.0),
                                                    topRight:
                                                        const Radius.circular(
                                                            20.0))),
                                            backgroundColor: Colors.white,
                                            context: context,
                                            builder: (context) =>
                                                FractionallySizedBox(
                                              heightFactor: 0.2.sp,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    25.sp),
                                                        border: Border.all(
                                                            color: AppColors
                                                                .primaryColor)),
                                                    child: MaterialButton(
                                                      child: Text(
                                                        'GALLERY'.toUpperCase(),
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .commonWhiteTextColor,
                                                            fontSize: 14.sp),
                                                      ),
                                                      onPressed: () {
                                                        getGalleryImage();
                                                        Get.back();
                                                      },
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: AppColors
                                                            .primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    25.sp),
                                                        border: Border.all(
                                                            color: AppColors
                                                                .primaryColor)),
                                                    child: MaterialButton(
                                                      child: Text(
                                                        'camera'.toUpperCase(),
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .commonWhiteTextColor,
                                                            fontSize: 14.sp),
                                                      ),
                                                      onPressed: () {
                                                        getCamaroImage();
                                                        Get.back();
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          height: 50.sp,
                                          width: 50.sp,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: _image == null
                                                ? SvgPicture.asset(
                                                    "${BImagePick.PersonIcon}",
                                                    color: AppColors
                                                        .primaryColor
                                                        .withOpacity(0.5))
                                                // Image.network(Img==null?'${BImagePick.PersonIcon}':Img!,fit: BoxFit.fill,)
                                                : Image.file(_image!,
                                                    fit: BoxFit.fill),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.02,
                                      ),
                                      CustomText(
                                          text: 'Change profile picture.',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.sp,
                                          color: AppColors.primaryColor),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: fname,
                                    validator: (value) {
                                      if (value!.trim().isEmpty) {
                                        return 'This field is required';
                                      } else if (!RegExp('[a-zA-Z]')
                                          .hasMatch(value)) {
                                        return 'please enter valid name';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.name,
                                    inputFormatters: [
                                      LengthLimitingTextInputFormatter(20)
                                    ],
                                    onChanged: (value) => _userName = value,
                                    decoration: InputDecoration(
                                        hintText: 'First Name',
                                        filled: true,
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.blue
                                                    .withOpacity(0.5),
                                                width: 2)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: BorderSide(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                width: 2)),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 2),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 2),
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
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
                                    onTap: () {},
                                    controller: lname,
                                    decoration: InputDecoration(
                                      hintText: 'Last Name',
                                      filled: true,
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color:
                                                  Colors.blue.withOpacity(0.5),
                                              width: 2)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              width: 2)),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 2),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 2),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
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
                              validator: (value) {
                                if (value!.trim().isEmpty) {
                                  return 'This field is required';
                                }
                                if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                    .hasMatch(value)) {
                                  return 'please enter valid number';
                                }
                                return null;
                              },
                              controller: phn,
                              keyboardType: TextInputType.phone,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10)
                              ],
                              decoration: InputDecoration(
                                hintText: 'Mobile no.',
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
                                ),
                              ),
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
                              },
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            TextFormField(
                              maxLines: 2,
                              controller: _controller.addressController == null
                                  ? _controller.addressController
                                  : _controller
                                      .addressController /* addController==null?addController:_controller.addressController*/,
                              decoration: InputDecoration(
                                  hintText: 'Address',
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
                              validator: (value) {
                                if (value!.isNotEmpty) {
                                  return null;
                                } else {
                                  return 'Enter a valid email address';
                                }
                              },
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            Center(
                              child: Text(
                                'Add location using google map',
                                style: STextStyle.semiBold600Black13,
                              ),
                            ),
                            SizedBox(height: 15.sp),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  print('is enterggg');
                                  Get.to(MapsScreen());
                                },
                                child: Container(
                                  padding: EdgeInsets.all(12.sp),
                                  height: Get.height * 0.075,
                                  width: Get.height * 0.23,
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
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SvgPicture.asset(
                                        "${SImagePick.locationColorIcon}",
                                      ),
                                      Text(
                                        'Get Locaton',
                                        style: STextStyle.semiBold600Black13,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 15.sp),
                            InkWell(
                              child: Container(
                                width: 400,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text(
                                  'Submit',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                )),
                              ),
                              onTap: () async {
                                if (formGlobalKey.currentState!.validate()) {
                                  // _register();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Processing Data'),
                                      backgroundColor: AppColors.primaryColor,
                                    ),
                                  );
                                  formGlobalKey.currentState!.save();
                                  SRegisterRepo.emailRegister(
                                          email: email.text, pass: pass.text)
                                      .then((value) async {
                                    await addData();
                                  });
                                  Get.to(SLoginScreen());
                                }
                              },
                            ),
                            SizedBox(
                              height: Get.height * 0.05,
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
                                        text: '  Log In',
                                        style: STextStyle.medium400Purple13,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            print('aaa');
                                            Get.to(SLoginScreen());
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
                    ),
                  ],
                );
              },
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

  /*Future<void> addData() async {
    String? imageUrl = await uploadImageToFirebase(
        context: context, file: _image, fileName: '${email.text}_profile.jpg');
    SRegisterRepo.currentUser()
        .then((value) {
      CollectionReference userCollection =
      bFirebaseStore.collection('SProfile');
      userCollection.doc('${PreferenceManager.getUId()}').set({
        'email': email.text,
        'password': pass.text,
        'phoneno': phn.text,
        'firstname': fname.text,
        'lastname': lname.text,
        'imageProfile': imageUrl,
        'address': _controller.addressController == null
            ? _controller.addressController
            : _controller.addressController!.text,
        'userType':'Seller',
        'time': DateTime.now(),

      });
    })
        .catchError((e) => print('Error =========>>> $e'))
        .then((value) => Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return SLoginScreen();
      },
    )));
  }*/
  Future<void> addData() async {
    print(
        'buyer addData PreferenceManager.getUserType()=====>${PreferenceManager.getUserType().toString()}');
    print(
        'buyer addData Preference Id==============>${PreferenceManager.getUId().toString()}');
    String? imageUrl = await uploadImageToFirebase(
        context: context, file: _image, fileName: '${email.text}_profile.jpg');
    SRegisterRepo.emailRegister()
        .then((value) async {
          CollectionReference ProfileCollection =
              bFirebaseStore.collection('SProfile');
          print('addData==seller===========${PreferenceManager.getUId()}');
          ProfileCollection.doc('${PreferenceManager.getUId()}').set({
            'sellerID': '1',
            'email': email.text,
            'password': pass.text,
            'phoneno': phn.text,
            'firstname': fname.text,
            'lastname': lname.text,
            'imageProfile': imageUrl,
            'address': _controller.addressController == null
                ? _controller.addressController
                : _controller.addressController!.text,
            'userType': PreferenceManager.getUserType(),
            'time': DateTime.now(),
          });
        })
        .catchError((e) => print('Error ====seller=====>>> $e'))
        .then(
          (value) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return SLoginScreen();
              },
            ),
          ),
        );
  }

  bool isPasswordValid(String password) => password.length <= 8;

  bool isEmailValid(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    return regex.hasMatch(email);
  }
}
