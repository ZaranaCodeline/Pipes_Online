import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:pipes_online/seller/common/s_common_button.dart';
import 'package:pipes_online/seller/common/s_image.dart';
import 'package:pipes_online/seller/view/s_authentication_screen/s_login_creen.dart';
import 'package:pipes_online/seller/view/s_authentication_screen/s_sign_up_ragistraion_screen.dart';
import 'package:sizer/sizer.dart';

class SWelcomeScreen extends StatefulWidget {
  @override
  _SWelcomeScreenState createState() => _SWelcomeScreenState();
}

class _SWelcomeScreenState extends State<SWelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 20.sp),
            Container(
              height: 195.sp,
              width: 250.sp,
              child: SvgPicture.asset(
                "${SImagePick.welcome}",
              ),
            ),
            Text(
              'WELCOME!',
              style: TextStyle(
                fontSize: 25.sp,
                color: SColorPicker.purple,
                fontWeight: FontWeight.w600,
                fontFamily: 'Ubuntu-Bold',
              ),
            ),
            SizedBox(height: 10.sp),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: Get.width * 0.4,
                    child: SCommonButton().sCommonPurpleButton(
                      name: 'Sign up',
                      onTap: () {
                        Get.off(()=>SSignUpRagistraionScreen());
                      },
                    ),
                  ),
                  Container(
                    width: Get.width * 0.4,
                    child: SCommonButton().sCommonPurpleButton(
                      name: 'Login',
                      onTap: () {
                        Get.off(()=>SLoginScreen());
                        // Get.toNamed(SRoutes.SLoginScreen);
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.18),
          ],
        ),
      ),
    );
  }
}
