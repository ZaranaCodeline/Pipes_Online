import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/custom_widget/widgets/custom_text.dart';
import 'package:pipes_online/seller/bottombar/s_navigation_bar.dart';
import 'package:pipes_online/seller/view/s_screens/s_order_review_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../buyer/app_constant/app_colors.dart';
import '../../bottombar/widget/order_bottom_bar_route.dart';
import '../../common/s_text_style.dart';

class SOrdersScreen extends StatelessWidget {
  const SOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'ORDER',
            style: STextStyle.bold700White14,
          ),
          backgroundColor: AppColors.primaryColor,
          leading: IconButton(
              onPressed: () {
                if (homeController.bottomIndex.value  == 1) {
                  homeController.setSelectedScreen(value: 'Order Screen');
                  homeController.bottomIndex.value = 0;
                } else {
                  Get.back();
                }
              },
              icon: Icon(Icons.arrow_back_rounded)),
          toolbarHeight: Get.height * 0.1,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25),
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.05,
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 10.sp, horizontal: 10.sp),
                    child: CustomText(
                        text: 'Ordered on 24 Dec 12:20',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.secondaryBlackColor),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 1, color: AppColors.offLightPurpalColor)),
                  padding: EdgeInsets.zero,
                  child: Card(
                    elevation: 0,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.sp, horizontal: 15.sp),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.asset(
                                  'assets/images/png/cart_page.png',
                                  fit: BoxFit.fill,
                                  width: Get.width * 0.3,
                                  height: Get.height / 8,
                                ),
                              ),
                            ),
                            Container(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text: 'Round',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.sp,
                                          color: AppColors.secondaryBlackColor,
                                          alignment: Alignment.topLeft,
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.05,
                                        ),
                                        CustomText(
                                          textOverflow: TextOverflow.clip,
                                          text: 'Order ID 000001',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.sp,
                                          color: AppColors.hintTextColor,
                                          alignment: Alignment.centerLeft,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.005,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Customer : ',
                                        style: STextStyle.semiBold600Grey12,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: ' Jan Doe',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: AppColors
                                                      .secondaryBlackColor)),
                                          // TextSpan(text: ' world!'),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                CustomText(
                                  text: 'Payment',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                  color: AppColors.hintTextColor,
                                  alignment: Alignment.centerLeft,
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                CustomText(
                                  text: '\$10',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                  color: AppColors.secondaryBlackColor,
                                  alignment: Alignment.centerLeft,
                                ),
                              ],
                            ),
                            Container(
                              child: Column(
                                children: [
                                  CustomText(
                                    text: 'Payment mode',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: AppColors.hintTextColor,
                                    alignment: Alignment.topLeft,
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  CustomText(
                                    text: 'Google pay',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: AppColors.secondaryBlackColor,
                                    alignment: Alignment.centerLeft,
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                CustomText(
                                  text: 'Order Status',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                  color: AppColors.hintTextColor,
                                  alignment: Alignment.centerLeft,
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                CustomText(
                                  text: 'Pending',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                  color: AppColors.secondaryBlackColor,
                                  alignment: Alignment.centerLeft,
                                ),
                              ],
                            )
                          ],
                        ),
                        Divider(
                          thickness: 2,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 5.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  CustomText(
                                    text: 'Size',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: AppColors.hintTextColor,
                                    alignment: Alignment.centerLeft,
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.008,
                                  ),
                                  CustomText(
                                    text: '2 ft',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: AppColors.secondaryBlackColor,
                                    alignment: Alignment.centerLeft,
                                  ),
                                ],
                              ),
                              Container(
                                child: Column(
                                  children: [
                                    CustomText(
                                      text: 'Length',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
                                      color: AppColors.hintTextColor,
                                      alignment: Alignment.topLeft,
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.008,
                                    ),
                                    CustomText(
                                      text: '2 kg',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
                                      color: AppColors.secondaryBlackColor,
                                      alignment: Alignment.centerLeft,
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: [
                                  CustomText(
                                    text: 'Weight',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: AppColors.hintTextColor,
                                    alignment: Alignment.centerLeft,
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.008,
                                  ),
                                  CustomText(
                                    text: 'Pending',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: AppColors.secondaryBlackColor,
                                    alignment: Alignment.centerLeft,
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  CustomText(
                                    text: 'Oil',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: AppColors.hintTextColor,
                                    alignment: Alignment.centerLeft,
                                  ),
                                  CustomText(
                                    text: '--',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: AppColors.secondaryBlackColor,
                                    alignment: Alignment.centerLeft,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Get.height * 0.01,),
                TextButton(onPressed: (){
                  Get.to(()=>SorderReviewScreen());
                }, child: CustomText(
                    text: 'Review Now',
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AppColors.primaryColor),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
