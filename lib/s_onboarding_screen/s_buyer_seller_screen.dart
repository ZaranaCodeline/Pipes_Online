import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/b_welcome_screen.dart';
import 'package:pipes_online/buyer/screens/b_home_screen_widget.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:pipes_online/seller/common/s_common_button.dart';
import 'package:pipes_online/seller/common/s_image.dart';
import 'package:pipes_online/seller/common/s_text_style.dart';
import 'package:pipes_online/s_onboarding_screen/s_buyer_seller_contoller.dart';
import 'package:pipes_online/seller/view/s_authentication_screen/s_welcome_screen.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';

import '../routes/app_routes.dart';

class SBuyerSellerScreen extends StatefulWidget {
  @override
  _SBuyerSellerScreenState createState() => _SBuyerSellerScreenState();
}

class _SBuyerSellerScreenState extends State<SBuyerSellerScreen> {
  BuyerSellerController buyerSellerController =
      Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                height: 140.sp,
                width: 208.sp,
                // color: Colors.green,
                child: SvgPicture.asset(
                  "${SImagePick.roundDesign}",
                  // height: 100,
                  // width: 200,
                ),
              ),
            ),
            GetBuilder<BuyerSellerController>(
              builder: (controller) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Are you Seller or Buyer?',
                      style: STextStyle.bold700Purple16,
                    ),
                    SizedBox(height: 20.sp),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.sp),
                      child: Row(
                        children: [
                          Flexible(
                            child: RadioListTile(
                              value: 'Buyer',
                              groupValue: controller.radioValue,
                              onChanged: (value) {
                                controller.setRadioValue(value);
                              },
                              title: Text(
                                'Buyer',
                                style: STextStyle.semiBold600Purple16,
                              ),
                              activeColor: SColorPicker.purple,
                            ),
                          ),
                          Flexible(
                            child: RadioListTile(
                              value: 'Seller',
                              groupValue: controller.radioValue,
                              onChanged: (value) {
                                controller.setRadioValue(value);
                              },
                              title: Text(
                                'Seller',
                                style: STextStyle.semiBold600Purple16,
                              ),
                              activeColor: SColorPicker.purple,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.sp),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 70.sp),
                      child: SCommonButton().sCommonPurpleButton(
                        name: 'Continue',
                        onTap: () {
                          if (controller.radioValue != null) {
                            if (controller.radioValue == 'Seller') {
                              print('Seller');
                              PreferenceManager.setUId('id');
                              PreferenceManager.setUserType('Seller');
                              PreferenceManager.setTime('time');
                              Get.offAll(()=>SWelcomeScreen());
                            } else {
                              print('Buyer');
                              PreferenceManager.setUId('id');
                              PreferenceManager.setUserType('Buyer');
                              PreferenceManager.setTime('time');
                              Get.offAll(()=>BWelcomeScreen());
                            }
                          } else {
                            Get.showSnackbar(GetSnackBar(
                              backgroundColor: SColorPicker.red,
                              duration: Duration(seconds: 2),
                              message: 'Please select the Buyer or Seller!',
                            ));
                          }
                          // Get.off('SPermissionScreen');
                          // print('hello');
                        },
                      ),
                    ),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
