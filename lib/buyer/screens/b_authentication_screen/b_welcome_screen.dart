import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/b_phone_otp_screen.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/b_ragistraion_screen.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:pipes_online/seller/common/s_common_button.dart';
import 'package:pipes_online/seller/common/s_image.dart';
import 'package:pipes_online/routes/app_routes.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';

import 'b_login_screen.dart';

class BWelcomeScreen extends StatefulWidget {
  @override
  _BWelcomeScreenState createState() => _BWelcomeScreenState();
}

class _BWelcomeScreenState extends State<BWelcomeScreen> {
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
                        Get.to(BSignUpRagistraionScreen());
                      },
                    ),
                  ),
                  Container(
                    width: Get.width * 0.4,
                    child: SCommonButton().sCommonPurpleButton(
                      name: 'Login',
                      onTap: () {
                        Get.to(BLoginScreen());
                        PreferenceManager.setUId('uid');
                        PreferenceManager.setEmail('email');
                        PreferenceManager.setUserType('Buyer');
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
