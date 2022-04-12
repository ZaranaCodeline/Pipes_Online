import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/screens/b_my_order_page.dart';
import 'package:pipes_online/seller/common/s_image.dart';
import 'package:sizer/sizer.dart';

import '../../seller/common/s_text_style.dart';
import '../app_constant/app_colors.dart';
import 'custom_widget/custom_button.dart';
import 'custom_widget/custom_text.dart';
import 'b_home_screen_widget.dart';

class BConfirmOrderPage extends StatelessWidget {
  BConfirmOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CONFIRM ORDER',
          style: STextStyle.bold700White14,
        ),
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: Get.height * 0.09,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
              child:SvgPicture.asset(SImagePick.confirmImg),
          //     Image.asset(
          //   'assets/images/png/confirm_img.png',
          //   fit: BoxFit.cover,
          // ),

          ),
          Center(
            child: CustomText(
              text: 'Your Order has been \n placed successfully !!',
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
              color: AppColors.secondaryBlackColor,
              textAlign: TextAlign.center,
            ),
          ),
          CustomText(
            text: 'You can check your order process in my \n orders section.',
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
            color: AppColors.hintTextColor,
            textAlign: TextAlign.center,
          ),
          GestureDetector(
            onTap: (){
              Get.to(()=>MyOrderPage());
            },
            child: CustomText(
              text: 'My Orders',
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: AppColors.primaryColor,
              textAlign: TextAlign.center,
            ),
          ),
          Custombutton(
            name: 'Continue Shopping',
            function: () => Get.to(() => CatelogeHomeWidget()),
            height: Get.height * 0.08,
            width: Get.width /1.sp,
          ),
        ],
      ),
    );
  }
}
