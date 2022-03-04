import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/buyer_common/b_image.dart';
import 'package:sizer/sizer.dart';

import '../../seller/common/s_text_style.dart';
import '../app_constant/app_colors.dart';
import '../custom_widget/widgets/custom_widget/custom_text.dart';
import 'confirm_order_page.dart';

class PaymentWidget extends StatelessWidget {
  const PaymentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PAYMENT',
          style: STextStyle.bold700White14,
        ),
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: Get.height * 0.1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: Get.height * 0.05),
          CustomText(
            text: 'Payment mode:',
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            color: AppColors.secondaryBlackColor,
            alignment: Alignment.center,
          ),
          CustomSocialWidget(
              icon: BImagePick.PayPalIcon,
              function: () => {Get.to(() => ConfirmOrderPage())},
              name: 'Paypal'),
          CustomSocialWidget(
              icon: BImagePick.GooglePayIcon,
              function: () => {Get.to(() => ConfirmOrderPage())},
              name: 'Google Pay'),
          CustomSocialWidget(
              icon: BImagePick.AmazonPayIcon,
              function: () => {Get.to(() => ConfirmOrderPage())},
              name: 'Amazon Pay'),
        ],
      ),
    );
  }

  Widget CustomSocialWidget({String? icon, dynamic function, String? name}) {
    return Container(
      height: Get.height * 0.06,
      decoration: BoxDecoration(
          color: Color(0xFFEBEBEB),
          borderRadius: BorderRadius.circular(Get.width)),
      margin: EdgeInsets.symmetric(
          horizontal: Get.width * 0.2, vertical: Get.height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon!,
            width: 20.sp,
            height: 20.sp,
          ),
          // Container(
          //   width: 38.sp,
          //   height: 38.sp,
          //   // decoration: BoxDecoration(
          //   //   borderRadius: BorderRadius.circular(50),
          //   //   color: AppColors.lightBlackColor,
          //   // ),
          //   child: IconButton(
          //     onPressed: function,
          //     icon: Icon(
          //       icon,
          //       color: AppColors.primaryColor,
          //       size: 18.sp,
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   width: Get.width * 0.06.sp,
          //   height: Get.height * 0.08.sp,
          // ),
          SizedBox(
            width: 15.sp,
          ),
          CustomText(
              text: name!,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: AppColors.secondaryBlackColor),
        ],
      ),
    );
  }
}
