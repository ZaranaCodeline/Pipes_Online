import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';

import '../app_constant/app_colors.dart';
import 'custom_widget/custom_text.dart';
import 'bottom_bar_screen_page/widget/b_cart_bottom_bar_route.dart';

class BMyOrderPage extends StatelessWidget {
  BMyOrderPage({Key? key}) : super(key: key);
  String? formattedDateTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          alignment: Alignment.centerLeft,
          text: 'MY ORDERS',
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
          color: AppColors.commonWhiteTextColor,
        ),
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: Get.height * 0.1,
        leading: IconButton(
            onPressed: () {
              if (bottomBarIndexController.bottomIndex.value == 1) {
                bottomBarIndexController.setSelectedScreen(value: 'HomeScreen');
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Orders')
            .orderBy('createdOn', descending: true)
            .snapshots(),
        builder: (context, snapShot) {
          if (!snapShot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapShot.data!.docs.isEmpty) {
              print('has not  data');
              return Center(
                child: Container(
                  width: Get.width * 0.6,
                  height: Get.height / 11,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.sp),
                      color: AppColors.primaryColor),
                  child: Center(
                      child: CustomText(
                    text: 'No Orders',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.commonWhiteTextColor,
                  )),
                ),
              );
            } else {
              if (snapShot.hasData) {
                print('OrderID==${PreferenceManager.getUId()}');
                return ListView.builder(
                  itemCount: snapShot.data?.docs.length,
                  itemBuilder: (context, index) {
                    formattedDateTime = DateFormat('yyyy-MM-dd hh:mm').format(
                        DateTime.parse(
                            snapShot.data?.docs[index]['createdOn']));
                    print('--formattedDateTime-${formattedDateTime}');

                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
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
                                    text: 'Ordered on $formattedDateTime',
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.sp,
                                                vertical: 10.sp),
                                            child: Image.network(
                                              snapShot.data?.docs[index]
                                                  ['productImage'],
                                              fit: BoxFit.fill,
                                              width: 92,
                                              height: 65,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 2.sp, vertical: 5.sp),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                text: snapShot.data?.docs[index]
                                                    ['prdName'],
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14.sp,
                                                color: AppColors.primaryColor,
                                                alignment: Alignment.topLeft,
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.01,
                                              ),
                                              CustomText(
                                                text: snapShot.data?.docs[index]
                                                    ['category'],
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.sp,
                                                color: AppColors
                                                    .secondaryBlackColor,
                                                alignment: Alignment.centerLeft,
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.01,
                                              ),
                                              CustomText(
                                                text:
                                                    'Order ID:\n ${snapShot.data?.docs[index]['orderID']}',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 10.sp,
                                                color: AppColors.hintTextColor,
                                                alignment: Alignment.topRight,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            CustomText(
                                              text: 'Payment',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.sp,
                                              color: AppColors.hintTextColor,
                                              alignment: Alignment.centerLeft,
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.01,
                                            ),
                                            CustomText(
                                              text: snapShot.data?.docs[index]
                                                  ['price'],
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.sp,
                                              color:
                                                  AppColors.secondaryBlackColor,
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
                                                text: snapShot.data?.docs[index]
                                                    ['paymentMode'],
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                                color: AppColors
                                                    .secondaryBlackColor,
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
                                              text: snapShot.data?.docs[index]
                                                  ['orderStatus'],
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              color:
                                                  AppColors.secondaryBlackColor,
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
                            CustomText(
                                text: 'Review Now',
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: AppColors.primaryColor)
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
