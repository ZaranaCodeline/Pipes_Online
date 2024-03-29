import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:pipes_online/seller/view/s_screens/s_insight.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../../buyer/app_constant/app_colors.dart';
import '../../../buyer/screens/custom_widget/custom_button.dart';
import '../../../buyer/screens/custom_widget/custom_text.dart';
import '../../common/s_text_style.dart';


class SEarningsScreen extends StatelessWidget {
  const SEarningsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: AppColors.commonWhiteTextColor,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Card(
                  margin: EdgeInsets.only(top: 0, bottom: 15),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: SingleChildScrollView(
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      height: 110,
                                      decoration: BoxDecoration(
                                          color: AppColors.primaryColor,
                                          borderRadius:
                                              const BorderRadius.vertical(
                                            bottom: Radius.circular(25),
                                          )),
                                    ),
                                  )
                                ],
                              ),
                              Positioned(
                                top: 0.0,
                                child: Container(
                                  width: 200,
                                  height: 52,
                                ),
                              ),
                              Positioned(
                                top: 65.0,
                                child: Container(
                                  height: Get.height / 8,
                                  width: Get.width * 0.4,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      color: AppColors.commonWhiteTextColor,
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: Color(0xffE8E8E8),
                                          width: 1.0)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CustomText(
                                          text: 'Earnings',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.sp,
                                          color: SColorPicker.fontGrey),
                                      CustomText(
                                          text: '\$5.9k',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.sp,
                                          color: SColorPicker.black),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                  top: 15,
                                  left: 0,
                                  child: BackButton(
                                    color: AppColors.commonWhiteTextColor,
                                  )),
                              Positioned(
                                top: 20.sp,
                                child: Text(
                                  'EARNINGS'.toUpperCase(),
                                  style: STextStyle.bold700White14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: Get.height / 18),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.sp,vertical: 15.sp),
                                height: Get.height / 2,
                                width: Get.width * 1,
                                child: LineChartPage(),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 10.sp,horizontal: 10.sp
                                ),
                                child: CustomText(
                                    text: 'Recent Transactions',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp,
                                    color: AppColors.secondaryBlackColor,
                                alignment: Alignment.topLeft,),
                              ),
                              Card(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.sp, horizontal: 10.sp),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: Image.asset(
                                          'assets/images/png/cart_page.png',
                                          fit: BoxFit.fill,
                                          width: Get.width * 0.2,
                                          height: Get.height / 12,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: Get.height * 0.005,
                                            ),
                                            CustomText(
                                              text: 'Round',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.sp,
                                              color:
                                                  AppColors.secondaryBlackColor,
                                              alignment: Alignment.topLeft,
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.005,
                                            ),
                                            CustomText(
                                              text: 'Ordered on 24 Dec 12:20',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 10.sp,
                                              color: SColorPicker.fontGrey,
                                              alignment: Alignment.topLeft,
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.005,
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                text: 'Order ID ',
                                                style: STextStyle
                                                    .semiBold600Grey12,
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: '000001',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColors
                                                              .secondaryBlackColor)),
                                                  // TextSpan(text: ' world!'),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.005,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: Get.width * 0.1,
                                          ),
                                          SvgPicture.asset(
                                              'assets/images/svg/paypal_icon.svg'),
                                          SizedBox(
                                            width: Get.width * 0.02,
                                          ),
                                          CustomText(
                                              text: '\$ 20',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.sp,
                                              color: Colors.green),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
