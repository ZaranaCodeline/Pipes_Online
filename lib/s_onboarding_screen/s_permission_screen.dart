import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:pipes_online/seller/common/s_common_button.dart';
import 'package:pipes_online/seller/common/s_image.dart';
import 'package:pipes_online/seller/common/s_text_style.dart';
import 'package:sizer/sizer.dart';

import '../routes/app_routes.dart';

class SPermissionScreen extends StatefulWidget {
  @override
  _SPermissionScreenState createState() => _SPermissionScreenState();
}

class _SPermissionScreenState extends State<SPermissionScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: SColorPicker.white,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Container(
                height: 195.sp,
                width: 250.sp,
                // padding: EdgeInsets.symmetric(
                //   horizontal: 15.sp,
                // ),
                //
                // decoration: BoxDecoration(
                //     color: SColorPicker.white,
                //     boxShadow: [
                //       BoxShadow(
                //           color: Colors.black12,
                //           spreadRadius: 0.5,
                //           blurRadius: 1),
                //     ],
                //     borderRadius: BorderRadius.circular(10.sp)),
                child: SvgPicture.asset("${SImagePick.permissionScreen}")),
            Padding(
              padding: EdgeInsets.only(
                left: 30.sp,
                right: 30.sp,
              ),
              child: Text(
                'To have a comfortable experience with us, please allow us the following permissions.',
                textAlign: TextAlign.center,
                style: STextStyle.regular400Black13,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.sp),
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 16.sp,
                    width: 16.sp,
                    // color: Colors.red,
                    child: SvgPicture.asset("${SImagePick.locationIcon}"),
                  ),
                  SizedBox(width: 10.sp),
                  Text(
                    'Location: To locate you easily',
                    style: STextStyle.regular400Black11,
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.sp),
              width: Get.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 16.sp,
                    width: 16.sp,
                    // color: Colors.red,
                    child: SvgPicture.asset("${SImagePick.callIcon}"),
                  ),
                  SizedBox(width: 10.sp),
                  Text(
                    'Phone: To verify your account and secure it',
                    style: STextStyle.regular400Black11,
                  ),
                ],
              ),
            ),
            SizedBox(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.sp),
              child: SCommonButton().sCommonPurpleButton(
                name: 'Allow Permissions',
                onTap: () {
                  Get.offNamed(SRoutes.SBuyerSellerScreen);
                  // Get.off('SPermissionScreen');
                  print('hello');
                },
              ),
            ),
            SizedBox(
              height: 10.h,
            )
          ],
        ),
      ),
    );
  }
}
