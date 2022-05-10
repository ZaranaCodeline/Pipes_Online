import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/register_repo.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/b_navigationbar.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/buyer/screens/maps_screen.dart';
import 'package:pipes_online/buyer/view_model/geolocation_controller.dart';
import 'package:pipes_online/routes/bottom_controller.dart';
import 'package:pipes_online/seller/bottombar/s_navigation_bar.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:pipes_online/seller/common/s_image.dart';
import 'package:pipes_online/seller/common/s_text_style.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';

import '../../../bottombar/widget/category_bottom_bar_route.dart';

class SFirstUserInfoScreen extends StatefulWidget {
  const SFirstUserInfoScreen({
    Key? key,
    this.email,
    this.mobile,
    this.name,
    this.pass,
    this.phone,
  }) : super(key: key);
  final String? email, mobile, name, pass, phone;
  @override
  _SFirstUserInfoScreenState createState() => _SFirstUserInfoScreenState();
}

class _SFirstUserInfoScreenState extends State<SFirstUserInfoScreen> {
  File? _image;

  final picker = ImagePicker();
  bool isLoading = false;
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

  @override
  void initState() {
    super.initState();
    print('user name===${nameController.text}');
    print('user mobilevontroller===${mobilecontroller.text}');
    print('user phone===${widget.phone}');
    print(
        'b sign up screen getUserType ======>${PreferenceManager.getUserType()}');
    print(
        'buyer addData Preference Id==============>${PreferenceManager.getUId().toString()}');
    print('buyer addData-getTime==============>${PreferenceManager.getTime()}');
    print('=======>${widget.email}');
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  GeolocationController _controller = Get.find();

  BottomController bottomController = Get.find();

  @override
  void dispose() {
    emailController.dispose();
    addressController.dispose();
    nameController.dispose();
    mobilecontroller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Builder(
          builder: (context) => SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: GetBuilder<GeolocationController>(
                  builder: (controller) {
                    return Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formKey,
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
                                  'PROFILE',
                                  style: STextStyle.bold700White14,
                                ),
                                SizedBox(width: 20.sp),
                              ],
                            ),
                          ),
                          SizedBox(height: 15.sp),
                          Container(
                            height: Get.height * 0.075,
                            width: Get.width * 0.62,
                            decoration: BoxDecoration(
                                color: SColorPicker.purple,
                                borderRadius: BorderRadius.circular(20.sp)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    print('it is openable image');

                                    showModalBottomSheet<void>(
                                      elevation: 0.5,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft:
                                                  const Radius.circular(20.0),
                                              topRight:
                                                  const Radius.circular(20.0))),
                                      backgroundColor: Colors.white,
                                      context: context,
                                      builder: (context) =>
                                          FractionallySizedBox(
                                        heightFactor: 0.5.sp,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: 35.sp,
                                                height: 5.sp,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    color:
                                                        AppColors.primaryColor),
                                              ),
                                              SizedBox(
                                                height: 0.2,
                                              ),
                                              CustomText(
                                                  alignment: Alignment.topLeft,
                                                  text: '    Add profile photo',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14.sp,
                                                  color: AppColors
                                                      .secondaryBlackColor),
                                              Container(
                                                child: MaterialButton(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/png/camera.png',
                                                        width: 15.sp,
                                                        height: 15.sp,
                                                      ),
                                                      SizedBox(
                                                        width: Get.width * 0.05,
                                                      ),
                                                      Text(
                                                        ' Take a photo',
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .primaryColor,
                                                            fontSize: 14.sp),
                                                      ),
                                                    ],
                                                  ),
                                                  onPressed: () {
                                                    getCamaroImage();
                                                    Get.back();
                                                  },
                                                ),
                                              ),
                                              Container(
                                                child: MaterialButton(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/png/gallery.png',
                                                        width: 15.sp,
                                                        height: 15.sp,
                                                      ),
                                                      SizedBox(
                                                        width: Get.width * 0.05,
                                                      ),
                                                      Text(
                                                        ' Upload from photos',
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .primaryColor,
                                                            fontSize: 14.sp),
                                                      ),
                                                    ],
                                                  ),
                                                  onPressed: () {
                                                    getGalleryImage();
                                                    Get.back();
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: _image != null
                                      ? Container(
                                          height: 35.sp,
                                          width: 35.sp,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Image.file(
                                              _image!,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          child: SvgPicture.asset(
                                            "${SImagePick.uploadImageIcon}",
                                          ),
                                        ),
                                ),
                                SizedBox(
                                  width: 10.sp,
                                ),
                                Text(
                                  'Upload your Image',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: SColorPicker.white,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: 'Nunito-Bold'),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 25.sp),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name',
                                style: STextStyle.semiBold600Black13,
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Container(
                                width: Get.width * 0.8,
                                height: Get.height * 0.07,
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
                                  controller: nameController,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                      // hintText: widget.email,
                                      ),
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Text(
                                widget.email != null ? 'Mobile' : 'Email',
                                style: STextStyle.semiBold600Black13,
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Container(
                                width: Get.width * 0.8,
                                height: Get.height * 0.07,
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Required';
                                    }
                                  },
                                  controller: widget.email != null
                                      ? mobilecontroller
                                      : emailController,
                                  decoration: InputDecoration(

                                      // hintText: "Name",
                                      ),
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Text(
                                'Address',
                                style: STextStyle.semiBold600Black13,
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Container(
                                height: Get.height * 0.09,
                                width: Get.width * 0.75,
                                alignment: Alignment.centerLeft,
                                child: TextFormField(
                                  // cursorColor: AppColors.primaryColor,
                                  keyboardType: TextInputType.streetAddress,
                                  // autocorrect: true,
                                  // autovalidateMode:
                                  //     AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Required';
                                    } else {
                                      return null;
                                    }
                                  },
                                  maxLines: 2,
                                  controller:
                                      _controller.addressController == null
                                          ? controller.addressController
                                          : _controller.addressController,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.sp),
                          Text(
                            'Add location using google map....',
                            style: STextStyle.semiBold600Black13,
                          ),
                          SizedBox(height: 15.sp),
                          GestureDetector(
                            onTap: () {
                              print('is Maps  ');
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
                          SizedBox(height: 25.sp),
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                print('Validate');
                                addData();
                                // Get.offAll(() => BottomNavigationBarScreen());
                              } else {
                                print('InValidate');
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: Get.width * 0.6,
                              height: Get.height * 0.07,
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
                                            color:
                                                AppColors.commonWhiteTextColor),
                                        CircularProgressIndicator(
                                          color: AppColors.commonWhiteTextColor,
                                        ),
                                      ],
                                    )
                                  : Text(
                                      'Submit',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              AppColors.commonWhiteTextColor),
                                    ),
                            ),
                          ),
                          // if (!address.isEmpty) SizedBox(height: Get.height * 0.05),
                          SizedBox(height: Get.height * 0.1),
                        ],
                      ),
                    );
                  },
                ),
              ),
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

  Future<void> addData() async {
    print('user name===${nameController.text}');
    print('user mobilevontroller===${mobilecontroller.text}');
    print('user phone===${widget.phone}');
    print(
        'buyer addData Preference Id==============>${PreferenceManager.getUId().toString()}');
    print(
        'buyer addData-getTime==============>${PreferenceManager.getTime().toString()}');
    String? imageUrl = await uploadImageToFirebase(
        context: context,
        file: _image,
        fileName: '${emailController.text}_profile.jpg');
    SRegisterRepo.emailRegister()
        .then((value) async {
          CollectionReference ProfileCollection =
              bFirebaseStore.collection('SProfile');
          ProfileCollection.doc('${PreferenceManager.getUId()}')
              // .collection('UserID')
              // .add({
              .set({
            'isOnline': false,
            'sellerID': PreferenceManager.getUId(),
            'email': widget.email != null ? widget.email : emailController.text,
            // 'password': widget.pass,
            'phoneno':
                widget.phone != null ? widget.phone : mobilecontroller.text,
            'user_name': nameController.text,
            'imageProfile': imageUrl,
            'address': _controller.addressController == null
                ? _controller.addressController
                : _controller.addressController!.text,
            'userType': PreferenceManager.getUserType(),
            'userDetails': 'true',
            'time': DateTime.now(),
          });
        })
        .catchError((e) => print('Error ====seller=====>>> $e'))
        .then((value) => Navigator.of(context)
                .pushReplacement(MaterialPageRoute(
                    builder: (context) => NavigationBarScreen()))
                .then((value) {
              setState(() {
                isLoading = false;
              });
            }));
  }

  bool isPasswordValid(String password) => password.length <= 8;

  bool isEmailValid(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    return regex.hasMatch(email);
  }
}
