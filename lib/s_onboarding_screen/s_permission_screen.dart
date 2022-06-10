import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/b_image.dart';
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
                // child: SvgPicture.asset("${SImagePick.permissionScreen}")
                child: Image.network(
                  "https://firebasestorage.googleapis.com/v0/b/pipedeals-f240a.appspot.com/o/permmision.png?alt=media&token=a9a3d625-e707-43c4-a5f7-09e68cbb7550",
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return Image.asset(
                      BImagePick.permission,
                      height: Get.height * 0.1,
                      width: Get.width * 0.4,
                      fit: BoxFit.cover,
                    );
                  },
                )),
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
                    height: 15.sp,
                    width: 15.sp,
                    // color: Colors.red,
                    child: SvgPicture.asset("${SImagePick.locationIcon}"),
                  ),
                  SizedBox(width: 7.sp),
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
                    height: 15.sp,
                    width: 10.sp,
                    // color: Colors.red,
                    child: SvgPicture.asset("${SImagePick.callIcon}"),
                  ),
                  SizedBox(width: 7.sp),
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
