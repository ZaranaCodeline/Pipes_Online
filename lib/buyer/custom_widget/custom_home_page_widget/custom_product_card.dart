import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:sizer/sizer.dart';

import '../../app_constant/app_colors.dart';
import '../widgets/custom_widget/custom_text.dart';

class CustomProductCard extends StatelessWidget {
  CustomProductCard(
      {Key? key,
      required this.name,
      required this.desc,
      required this.image,
      required this.price})
      : super(key: key);
  String name;
  String price;
  String desc;
  String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5.sp),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 2.sp),
        width: Get.width / 5,
        height: Get.height / 5,
        decoration: BoxDecoration(
            color: AppColors.commonWhiteTextColor,
            borderRadius: BorderRadius.circular(Get.width * 0.05),
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
                color: SColorPicker.fontGrey,
              )
            ]),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 8.sp),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(Get.width * 0.02),
                child: Image.network(
                  '$image',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              CustomText(
                text: name,
                fontWeight: FontWeight.w700,
                fontSize: 14.sp,
                color: SColorPicker.purple,
                alignment: Alignment.centerLeft,
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              CustomText(
                text: desc,
                fontWeight: FontWeight.w700,
                fontSize: 12.sp,
                color: SColorPicker.black,
                alignment: Alignment.centerLeft,
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              CustomText(
                text: price,
                fontWeight: FontWeight.w700,
                fontSize: 12.sp,
                color: SColorPicker.black,
                alignment: Alignment.centerLeft,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
