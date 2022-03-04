import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../app_constant/app_colors.dart';
import '../custom_widget/widgets/custom_widget/custom_button.dart';
import '../custom_widget/widgets/custom_widget/custom_text.dart';
import 'get_started_page.dart';

class PersonalInfoPage extends StatelessWidget {
  const PersonalInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          alignment: Alignment.centerLeft,
          text: 'PERSONAL INFORMATION',
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: AppColors.commonWhiteTextColor,
        ),
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
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.symmetric(  horizontal:  Get.height * 0.04),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Get.height * 0.05),
                Row(
                  children: [
                    SvgPicture.asset('assets/images/pro_icon.svg'),
                    SizedBox(
                      width: Get.width * 0.05,
                    ),
                    CustomText(
                        text: 'Capture or select \n your image',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: AppColors.hintTextColor),
                    SizedBox(
                      width: Get.width * 0.05,
                    ),
                    Container(
                      width: 54,
                      height: 54,
                      // color: AppColors.primaryColor,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.primaryColor,
                      ),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        size: 35,
                        color: AppColors.commonWhiteTextColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Get.height * 0.05),
                CustomText(
                  text: 'Name',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: AppColors.primaryColor,
                  alignment: Alignment.topLeft,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                const TextField(
                  // controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    hintText: 'Enter Name',
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                CustomText(
                  text: 'Email/Mobile',
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: AppColors.primaryColor,
                  alignment: Alignment.topLeft,
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                const TextField(
                  // controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    hintText: 'Enter Email/Mobile',
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
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
                    hintText: 'Enter Address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                  ),
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  // minLines: 1,
                ),
                SizedBox(
                  height: Get.height * 0.03,
                ),
                Custombutton(
                    name: 'Continue',
                    function: () {
                      Get.to(()=>GetStartedPage());
                    },
                    height: Get.height * 0.07,
                width: Get.width / 3,),
                SizedBox(
                  height: Get.height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
