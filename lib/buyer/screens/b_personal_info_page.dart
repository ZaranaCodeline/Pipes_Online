import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/app_constant/b_image.dart';
import 'package:pipes_online/buyer/view_model/b_profile_view_model.dart';
import 'package:pipes_online/seller/common/s_text_style.dart';
import 'package:pipes_online/seller/view/s_screens/s_color_picker.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';
import '../app_constant/app_colors.dart';
import 'bottom_bar_screen_page/widget/b_home_bottom_bar_route.dart';
import 'custom_widget/custom_text.dart';

class PersonalInfoPage extends StatefulWidget {
  final bool? isBottomBarVisible;
  PersonalInfoPage({
    Key? key,
    this.isBottomBarVisible,
  }) : super(key: key);

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  File? _image;
  String? Img;
  String? uploadImage;
  bool isLoading = false;
  BProfileViewModel _model = Get.find();
  final picker = ImagePicker();
  TextEditingController? firstname;
  TextEditingController? email;
  TextEditingController? address;
  TextEditingController? phoneno;

  CollectionReference profileCollection = bFirebaseStore.collection('BProfile');

  Future<void> getData() async {
    print('demo seller.....');
    final user =
        await profileCollection.doc('${PreferenceManager.getUId()}').get();
    Map<String, dynamic>? getUserData = user.data() as Map<String, dynamic>?;

    setState(() {
      _model.firstnameController =
          TextEditingController(text: getUserData?['user_name'] ?? "");
      _model.phoneController =
          TextEditingController(text: getUserData?['phoneno'] ?? "");
      _model.emailController =
          TextEditingController(text: getUserData?['email'] ?? "");
      _model.addressController =
          TextEditingController(text: getUserData?['address'] ?? "");
      Img = getUserData?['imageProfile'];
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
    if (await Permission.camera.request().isGranted) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.camera,
      ].request();
      print(statuses[Permission.camera]);
      final imaGe = await picker.pickImage(source: ImageSource.camera);

      if (imaGe != null) {
        setState(() {
          _image = File(imaGe.path);
        });

        print("=============ImagePath==========${imaGe.path}");
      } else {
        print('no image selected');
      }
      // Either the permission was already granted before or the user just granted it.
    }

// You can request multiple permissions at once.
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    print('==PreferenceManager.getUId==${PreferenceManager.getUId()}');
    print('====phoneController===>${_model.phoneController?.text.toString()}');
    print('==uid==${FirebaseAuth.instance.currentUser?.uid}');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'PROFILE'.toUpperCase(),
              style: STextStyle.bold700White14,
            ),
            automaticallyImplyLeading: false,
            centerTitle: true,
            backgroundColor: AppColors.primaryColor,
            toolbarHeight: Get.height * 0.1,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(25),
              ),
            ),
          ),
          body: SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.sp),
              padding: EdgeInsets.symmetric(horizontal: Get.height * 0.04),
              child: SingleChildScrollView(
                child: GetBuilder<BProfileViewModel>(
                  builder: (controller) {
                    return Column(
                      children: [
                        SizedBox(height: Get.height * 0.02),
                        GestureDetector(
                          onTap: () {
                            print('it is openable image');

                            showModalBottomSheet<void>(
                              elevation: 0.5,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0))),
                              backgroundColor: Colors.white,
                              context: context,
                              builder: (context) => FractionallySizedBox(
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
                                                BorderRadius.circular(15),
                                            color: AppColors.primaryColor),
                                      ),
                                      const SizedBox(
                                        height: 0.2,
                                      ),
                                      CustomText(
                                          alignment: Alignment.topLeft,
                                          text: '    Add profile photo',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14.sp,
                                          color: AppColors.secondaryBlackColor),
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
                                                    color:
                                                        AppColors.primaryColor,
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
                                                    color:
                                                        AppColors.primaryColor,
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
                          child: Column(
                            children: [
                              Container(
                                height: 50.sp,
                                width: 50.sp,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: _image == null
                                      ? Image.network(
                                          Img == null
                                              ? 'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'
                                              : Img!,
                                          fit: BoxFit.fill, errorBuilder:
                                              (BuildContext context,
                                                  Object exception,
                                                  StackTrace? stackTrace) {
                                          return Image.asset(
                                            BImagePick.cartIcon,
                                            height: Get.height * 0.1,
                                            width: Get.width * 0.4,
                                            fit: BoxFit.cover,
                                          );
                                        })
                                      : Image.file(_image!, fit: BoxFit.fill,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace? stackTrace) {
                                          return Image.asset(
                                            BImagePick.cartIcon,
                                            height: Get.height * 0.1,
                                            width: Get.width * 0.4,
                                            fit: BoxFit.cover,
                                          );
                                        }),
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
                        SizedBox(height: Get.height * 0.01),
                        CustomText(
                          text: 'Name',
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                          color: AppColors.primaryColor,
                          alignment: Alignment.topLeft,
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        TextField(
                          controller: controller.firstnameController,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.edit),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            hintText: 'Your Name',
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        CustomText(
                          text: 'Mobile',
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                          color: AppColors.primaryColor,
                          alignment: Alignment.topLeft,
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        TextField(
                          controller: controller
                              .phoneController /* ??
                              PreferenceManager.getPhoneNumber()*/
                          ,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10)
                          ],
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.edit),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            hintText: '+91 0000000000',
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        CustomText(
                          text: 'Email',
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                          color: AppColors.primaryColor,
                          alignment: Alignment.topLeft,
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        TextField(
                          controller: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.edit),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            hintText: 'Enter Email',
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        CustomText(
                          text: 'Address',
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                          color: AppColors.primaryColor,
                          alignment: Alignment.topLeft,
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        TextField(
                          controller: controller.addressController,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.edit),
                            hintText: 'Enter Your Address',
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                          maxLines: 2,
                          keyboardType: TextInputType.multiline,
                          // minLines: 1,
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_image == null) {
                              Get.showSnackbar(
                                const GetSnackBar(
                                  snackPosition: SnackPosition.BOTTOM,
                                  duration: Duration(seconds: 5),
                                  message: 'Please update picture',
                                ),
                              );
                            }

                            if (_image != null) {
                              setState(() {
                                isLoading = true;
                              });
                              uploadImgFirebaseStorage(file: _image);
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
                                  width: Get.width,
                                  height: Get.height * 0.06,
                                  decoration: BoxDecoration(
                                    color: SColorPicker.purple,
                                    borderRadius: BorderRadius.circular(10.sp),
                                  ),
                                  child: Text(
                                    'SAVE',
                                    style: STextStyle.bold700White14,
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  uploadImgFirebaseStorage({File? file}) async {
    var snapshot = await bFirebaseStorage
        .ref()
        .child('profileImage/${DateTime.now().microsecondsSinceEpoch}')
        .putFile(file!);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    print('url=$downloadUrl');
    print('====PreferenceManager.getUId()=====>${PreferenceManager.getUId()}');
    print('B IMG>>>>-$Img');
    print('B downloadUrl>>>>-$downloadUrl');
    await profileCollection.doc(PreferenceManager.getUId()).update({
      'imageProfile': downloadUrl,
      'user_name': _model.firstnameController?.text,
      'email': _model.emailController?.text,
      'address': _model.addressController?.text,
      'phoneno': _model.phoneController?.text
    }).then((value) {
      bottomBarIndexController.setSelectedScreen(value: 'HomeScreen');
      bottomBarIndexController.bottomIndex.value = 0;
      print('success add');
      setState(() {
        isLoading = false;
      });
    }).catchError((e) => print('upload error'));
  }
}
