import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/b_navigationbar.dart';
import 'package:sizer/sizer.dart';

import '../../seller/common/s_text_style.dart';
import '../app_constant/app_colors.dart';
import '../custom_widget/widgets/custom_text.dart';
import '../view_model/b_bottom_bar_controller.dart';

class DrawerProfilePage extends StatefulWidget {
  const DrawerProfilePage({Key? key}) : super(key: key);

  @override
  State<DrawerProfilePage> createState() => _DrawerProfilePageState();
}

class _DrawerProfilePageState extends State<DrawerProfilePage> {

  File? _image;

  final picker = ImagePicker();

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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                BBottomBarIndexController bottomBarIndexController =
                Get.put(BBottomBarIndexController());
                // bottomBarIndexController.setSelectedScreen(value: 'HomeScreen');
                // bottomBarIndexController.bottomIndex.value = 0;

                if (bottomBarIndexController.bottomIndex.value == 3) {
                  bottomBarIndexController.setSelectedScreen(
                      value: 'ProfileScreen');
                  bottomBarIndexController.bottomIndex.value = 0;
                } else {
                  Get.back();
                }

              },
              icon: Icon(Icons.arrow_back_rounded)),
          title: Text(
            'PROFILE',
            style: STextStyle.bold700White14,
          ),
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
              child: Column(
                children: [
                  SizedBox(height: Get.height * 0.04),
                  Column(
                    children: [
                      //assets/images/profile.png
                      GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => SimpleDialog(
                                children: [
                                  Container(
                                    height: 125.sp,
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        Container(
                                          child: MaterialButton(
                                            child: Text(
                                              'GALLERY',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.sp),
                                            ),
                                            onPressed: () {
                                              getGalleryImage();
                                              Get.back();
                                            },
                                          ),
                                          width: 220,
                                          height: 60.sp,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  colors: [
                                                    AppColors.primaryColor,
                                                    AppColors
                                                        .offLightPurpalColor,
                                                  ]),
                                              borderRadius:
                                              BorderRadius.circular(25)),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          child: MaterialButton(
                                            child: Text(
                                              'camera',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            onPressed: () {
                                              getCamaroImage();
                                              Get.back();
                                            },
                                          ),
                                          width: 220,
                                          height: 60.sp,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.centerLeft,
                                                  colors: [
                                                    AppColors.primaryColor,
                                                    AppColors
                                                        .offLightPurpalColor,
                                                  ]),
                                              borderRadius:
                                              BorderRadius.circular(25)),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          child: _image != null
                              ? Container(
                            height: 35.sp,
                            width: 35.sp,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.file(
                                _image!,
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                              : Container(
                            child: SvgPicture.asset(
                              'assets/images/svg/pro_icon.svg',
                              color: AppColors.primaryColor,
                            ),
                          )),
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
                  SizedBox(height: Get.height * 0.03),
                  CustomText(
                    text: 'Name',
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    color: AppColors.primaryColor,
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  const TextField(
                    // controller: _controller,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.edit),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      hintText: 'Jan Doe',
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  CustomText(
                    text: 'Mobile',
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    color: AppColors.primaryColor,
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  const TextField(
                    // controller: _controller,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.edit),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      hintText: '+91 0000000000',
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  CustomText(
                    text: 'Address',
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    color: AppColors.primaryColor,
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.edit),
                      hintText: 'Enter Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    // minLines: 1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
