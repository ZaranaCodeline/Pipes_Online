import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../app_constant/app_colors.dart';
import 'custom_widget/custom_text.dart';
import 'bottom_bar_screen_page/widget/b_cart_bottom_bar_route.dart';

class BMyOrderPage extends StatelessWidget {
  const BMyOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          alignment: Alignment.centerLeft,
          text: 'MY ORDERS',
          fontWeight: FontWeight.w600,
          fontSize: 22,
          color: AppColors.commonWhiteTextColor,
        ),
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: Get.height * 0.1,
        leading: IconButton(
            onPressed: () {
              if (bottomBarIndexController.bottomIndex.value == 1) {
                bottomBarIndexController.setSelectedScreen(
                    value: 'HomeScreen');
                bottomBarIndexController.bottomIndex.value = 0;
              } else {
                Get.back();
              }
            },
            icon: Icon(Icons.arrow_back_rounded)),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.05,
              ),

              Card(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.sp),
                  child: CustomText(
                      text: 'Ordered on 24 Dec 12:20',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.secondaryBlackColor),
                ),
              ),
              Container(
                child: Card(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.sp, vertical: 10.sp),
                              child: Image.asset(
                                'assets/images/png/cart_page.png',
                                fit: BoxFit.fill,
                                width: 92,
                                height: 65,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5.sp, vertical: 5.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: 'Round',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  color: AppColors.primaryColor,
                                  alignment: Alignment.topLeft,
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                CustomText(
                                  text: 'ABC Pipe',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                  color: AppColors.secondaryBlackColor,
                                  alignment: Alignment.centerLeft,
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                              ],
                            ),
                          ),
                          CustomText(
                            text: 'Order ID 000001',
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                            color: AppColors.hintTextColor,
                            alignment: Alignment.topRight,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              CustomText(
                                text: 'Payment',
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: AppColors.hintTextColor,
                                alignment: Alignment.centerLeft,
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              CustomText(
                                text: '\$10',
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: AppColors.secondaryBlackColor,
                                alignment: Alignment.centerLeft,
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                              children: [
                                CustomText(
                                  text: 'Payment mode',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: AppColors.hintTextColor,
                                  alignment: Alignment.topLeft,
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                CustomText(
                                  text: 'Google pay',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: AppColors.secondaryBlackColor,
                                  alignment: Alignment.centerLeft,
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              CustomText(
                                text: 'Order Status',
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: AppColors.hintTextColor,
                                alignment: Alignment.centerLeft,
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              CustomText(
                                text: 'Pending',
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: AppColors.secondaryBlackColor,
                                alignment: Alignment.centerLeft,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              //second

              SizedBox(
                height: Get.height * 0.05,
              ),
              Card(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.sp),
                  child: CustomText(
                      text: 'Ordered on 24 Dec 12:20',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: AppColors.secondaryBlackColor),
                ),
              ),
              Container(
                child: Card(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.sp, vertical: 10.sp),
                              child: Image.asset(
                                'assets/images/png/cart_page.png',
                                fit: BoxFit.fill,
                                width: 92,
                                height: 65,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 5.sp, vertical: 5.sp),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: 'Round',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  color: AppColors.primaryColor,
                                  alignment: Alignment.topLeft,
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                CustomText(
                                  text: 'ABC Pipe',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                  color: AppColors.secondaryBlackColor,
                                  alignment: Alignment.centerLeft,
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                              ],
                            ),
                          ),
                          CustomText(
                            text: 'Order ID 000001',
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                            color: AppColors.hintTextColor,
                            alignment: Alignment.topRight,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              CustomText(
                                text: 'Payment',
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: AppColors.hintTextColor,
                                alignment: Alignment.centerLeft,
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              CustomText(
                                text: '\$10',
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: AppColors.secondaryBlackColor,
                                alignment: Alignment.centerLeft,
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                              children: [
                                CustomText(
                                  text: 'Payment mode',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: AppColors.hintTextColor,
                                  alignment: Alignment.topLeft,
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                CustomText(
                                  text: 'Google pay',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: AppColors.secondaryBlackColor,
                                  alignment: Alignment.centerLeft,
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              CustomText(
                                text: 'Order Status',
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: AppColors.hintTextColor,
                                alignment: Alignment.centerLeft,
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              CustomText(
                                text: 'Pending',
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: AppColors.secondaryBlackColor,
                                alignment: Alignment.centerLeft,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              CustomText(
                  text: 'Review Now',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: AppColors.primaryColor)
            ],
          ),
        ),
      ),
    );
  }
}
