import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/bottom_bar_screen_page.dart';
import 'package:sizer/sizer.dart';

import '../../seller/common/s_text_style.dart';
import '../app_constant/app_colors.dart';
import '../custom_widget/widgets/custom_widget/custom_button.dart';
import '../custom_widget/widgets/custom_widget/custom_cupertino_feild_text.dart';
import '../custom_widget/widgets/custom_widget/custom_text.dart';
import 'bottom_bar_screen_page/widget/cart_bottom_bar_route.dart';
import 'get_started_page.dart';

class DrawerProfilePage extends StatelessWidget {
  const DrawerProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                bottomBarIndexController.setSelectedScreen(value: 'HomeScreen');
                bottomBarIndexController.bottomIndex.value = 0;
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
                      SvgPicture.asset(
                        'assets/images/svg/pro_icon.svg',
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      CustomText(
                          text: 'Change profile picture',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: AppColors.primaryColor),
                    ],
                  ),
                  SizedBox(height: Get.height * 0.01),
                  CustomText(
                    text: 'Name',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: AppColors.primaryColor,
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
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
                    height: Get.height * 0.01,
                  ),
                  CustomText(
                    text: 'Mobile',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: AppColors.primaryColor,
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
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
                    height: Get.height * 0.01,
                  ),
                  CustomText(
                    text: 'Address',
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: AppColors.primaryColor,
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  const TextField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.edit),
                      hintText: 'Enter Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      ),
                    ),
                    maxLines: 3,
                    keyboardType: TextInputType.multiline,
                    // minLines: 1,
                  ),
                  // SizedBox(
                  //   height: Get.height * 0.02,
                  // ),
                  // Custombutton(
                  //   name: 'Continue',
                  //   function: () {
                  //     Get.to(()=>GetStartedPage());
                  //   },
                  //   height: Get.height * 0.07,
                  //   width: Get.width / 3,),
                  // SizedBox(
                  //   height: Get.height * 0.05,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
