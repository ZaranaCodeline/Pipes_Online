import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/seller/common/s_text_style.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:sizer/sizer.dart';

class SCommonButton {
  GestureDetector sCommonPurpleButton({String? name, dynamic onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          alignment: Alignment.center,
          width: Get.width,
          height: Get.height * 0.06,
          decoration: BoxDecoration(
            color: SColorPicker.purple,
            borderRadius: BorderRadius.circular(10.sp),
          ),
          child: Text(
            name!,
            style: STextStyle.bold700White14,
          )),
    );
  }
}
