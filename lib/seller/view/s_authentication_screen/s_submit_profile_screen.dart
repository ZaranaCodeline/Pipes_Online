import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:pipes_online/seller/common/s_common_button.dart';
import 'package:pipes_online/seller/common/s_image.dart';
import 'package:pipes_online/seller/common/s_text_style.dart';
import 'package:pipes_online/routes/app_routes.dart';
import 'package:pipes_online/seller/view/s_screens/s_home_screen.dart';
import 'package:sizer/sizer.dart';

class SSubmitProfileScreen extends StatefulWidget {
  @override
  _SSubmitProfileScreenState createState() => _SSubmitProfileScreenState();
}

class _SSubmitProfileScreenState extends State<SSubmitProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      'PROFILE',
                      style: STextStyle.bold700White14,
                    ),
                    SizedBox(width: 20.sp),
                  ],
                ),
              ),
              // SizedBox(height: 20.sp),
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
                    SvgPicture.asset(
                      "${SImagePick.uploadImageIcon}",
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
                    style: STextStyle.semiBold600Black15,
                  ),
                  SizedBox(height: 5.sp),
                  Container(
                    //  height: Get.height * 0.06,
                    width: Get.width * 0.75,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        border: Border.all(color: Colors.grey)),
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                      // controller: controller.mobileNumber,
                      decoration: InputDecoration(
                          hintText: 'Enter Name',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.sp),
                              borderSide: BorderSide.none),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.sp),
                              borderSide: BorderSide.none),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.sp),
                              borderSide: BorderSide.none)),
                    ),
                  ),
                  SizedBox(height: 10.sp),
                  Text(
                    'Address',
                    style: STextStyle.semiBold600Black15,
                  ),
                  SizedBox(height: 5.sp),
                  Container(
                    //  height: Get.height * 0.06,
                    width: Get.width * 0.75,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        border: Border.all(color: Colors.grey)),
                    alignment: Alignment.centerLeft,
                    child: TextFormField(
                      maxLines: 4,
                      // controller: controller.mobileNumber,
                      decoration: InputDecoration(
                          hintText: 'Enter Address',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.sp),
                              borderSide: BorderSide.none),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.sp),
                              borderSide: BorderSide.none),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.sp),
                              borderSide: BorderSide.none)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15.sp),
              Text(
                'Add location using google map',
                style: STextStyle.semiBold600Black13,
              ),
              SizedBox(height: 15.sp),
              Container(
                padding: EdgeInsets.all(12.sp),
                height: Get.height * 0.075,
                width: Get.height * 0.075,
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
                child: SvgPicture.asset(
                  "${SImagePick.locationColorIcon}",
                ),
              ),
              SizedBox(height: 25.sp),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.sp),
                child: SCommonButton().sCommonPurpleButton(
                  name: 'Continue',
                  onTap: () {
                    Get.to(()=>SHomeScreen());
                    print('this is a seller side');
                    // Get.toNamed(SRoutes.SSubmitProfileScreen);
                  },
                ),
              ),
              SizedBox(height: Get.height * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}
