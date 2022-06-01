import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/seller/view/s_screens/s_add_review_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_order_review_info_screen.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';

import '../../../buyer/app_constant/app_colors.dart';
import '../../bottombar/widget/category_bottom_bar_route.dart';
import '../../common/s_text_style.dart';

class SOrdersScreen extends StatelessWidget {
  SOrdersScreen({Key? key}) : super(key: key);
  String? formattedDateTime;

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
                print('back to home screen');
                Get.back();
                // homeController.bottomIndex.value = 0;
                // homeController.selectedScreen('SCatelogeHomeScreen');
              },
              icon: Icon(Icons.arrow_back_rounded)),
          toolbarHeight: Get.height * 0.1,
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
            }
            if (snapShot.hasData) {
              print('========OrderID==========${PreferenceManager.getUId()}');
              return ListView.builder(
                itemCount: snapShot.data?.docs.length,
                itemBuilder: (context, index) {
                  formattedDateTime = DateFormat('yyyy-MM-dd hh:mm').format(
                      DateTime.parse(snapShot.data?.docs[index]['createdOn']));
                  print('--formattedDateTime-${formattedDateTime}');
                  return Container(
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
                                  text: 'Ordered on $formattedDateTime',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: AppColors.secondaryBlackColor),
                            ),
                          ),
                          Card(
                            child: Container(
                              decoration: BoxDecoration(
                                  /*border: Border.all(
                                      width: 1,
                                      color: AppColors.offLightPurpalColor)*/
                                  ),
                              padding: EdgeInsets.zero,
                              child: GestureDetector(
                                onTap: () {
                                  Get.to(SorderReviewInfoScreen(),
                                      arguments: snapShot.data?.docs[index].id);
                                  // arguments: [
                                  //   snapShot.data?.docs[index].id
                                  // ]);
                                },
                                child: Card(
                                  elevation: 0,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.sp,
                                                horizontal: 10.sp),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: snapShot.data?.docs[index]
                                                          ['productImage'] !=
                                                      null
                                                  ? Image.network(
                                                      snapShot.data?.docs[index]
                                                          ['productImage'],
                                                      fit: BoxFit.fill,
                                                      width: Get.width * 0.25,
                                                      height: Get.height / 8,
                                                    )
                                                  : Image.asset(
                                                      'assets/images/png/cart_page.png',
                                                      fit: BoxFit.fill,
                                                      width: Get.width * 0.25,
                                                      height: Get.height / 8,
                                                    ),
                                            ),
                                          ),
                                          Container(
                                            height: Get.height / 6,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        height:
                                                            Get.height * 0.02,
                                                      ),
                                                      CustomText(
                                                        textOverflow:
                                                            TextOverflow.fade,
                                                        max: 1,
                                                        text: 'Product Name:- ',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12.sp,
                                                        color: AppColors
                                                            .hintTextColor,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                      ),
                                                      CustomText(
                                                        textOverflow:
                                                            TextOverflow.fade,
                                                        max: 1,
                                                        text: snapShot.data
                                                                ?.docs[index]
                                                            ['prdName'],
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12.sp,
                                                        color: AppColors
                                                            .secondaryBlackColor,
                                                        alignment:
                                                            Alignment.topLeft,
                                                      ),
                                                      SizedBox(
                                                        width: Get.width * 0.01,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.02,
                                                  ),
                                                  CustomText(
                                                    textOverflow:
                                                        TextOverflow.ellipsis,
                                                    max: 1,
                                                    text: 'Order ID :- ',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12.sp,
                                                    color:
                                                        AppColors.hintTextColor,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.005,
                                                  ),
                                                  CustomText(
                                                    textOverflow:
                                                        TextOverflow.ellipsis,
                                                    max: 1,
                                                    text:
                                                        '${snapShot.data?.docs[index]['orderID']}',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 10.sp,
                                                    color: AppColors
                                                        .secondaryBlackColor,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.02,
                                                  ),
                                                  RichText(
                                                    text: TextSpan(
                                                      text: 'Customer : ',
                                                      style: STextStyle
                                                          .semiBold600Grey12,
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: snapShot.data
                                                                    ?.docs[index]
                                                                ['buyerName'],
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              CustomText(
                                                text: 'price',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.sp,
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
                                                fontSize: 12.sp,
                                                color: AppColors
                                                    .secondaryBlackColor,
                                                alignment: Alignment.centerLeft,
                                              ),
                                            ],
                                          ),
                                          Container(
                                            child: Column(
                                              children: [
                                                CustomText(
                                                  text: 'paymentMode',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.sp,
                                                  color:
                                                      AppColors.hintTextColor,
                                                  alignment: Alignment.topLeft,
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.01,
                                                ),
                                                CustomText(
                                                  text:
                                                      snapShot.data?.docs[index]
                                                          ['paymentMode'],
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.sp,
                                                  color: AppColors
                                                      .secondaryBlackColor,
                                                  alignment:
                                                      Alignment.centerLeft,
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
                                                text: snapShot.data?.docs[index]
                                                    ['orderStatus'],
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.sp,
                                                color: AppColors
                                                    .secondaryBlackColor,
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
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5.sp),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                CustomText(
                                                  text: 'Size',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.sp,
                                                  color:
                                                      AppColors.hintTextColor,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.008,
                                                ),
                                                CustomText(
                                                  text: snapShot.data
                                                      ?.docs[index]['size'],
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.sp,
                                                  color: AppColors
                                                      .secondaryBlackColor,
                                                  alignment:
                                                      Alignment.centerLeft,
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
                                                    color:
                                                        AppColors.hintTextColor,
                                                    alignment:
                                                        Alignment.topLeft,
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.008,
                                                  ),
                                                  CustomText(
                                                    text: snapShot.data
                                                        ?.docs[index]['length'],
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12.sp,
                                                    color: AppColors
                                                        .secondaryBlackColor,
                                                    alignment:
                                                        Alignment.centerLeft,
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
                                                  color:
                                                      AppColors.hintTextColor,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.008,
                                                ),
                                                CustomText(
                                                  text: snapShot.data
                                                      ?.docs[index]['weight'],
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.sp,
                                                  color: AppColors
                                                      .secondaryBlackColor,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                CustomText(
                                                  text: 'Oil',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.sp,
                                                  color:
                                                      AppColors.hintTextColor,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                ),
                                                CustomText(
                                                  text: snapShot
                                                      .data?.docs[index]['oil'],
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.sp,
                                                  color: AppColors
                                                      .secondaryBlackColor,
                                                  alignment:
                                                      Alignment.centerLeft,
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
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.to(() => SAddReviewScreen());
                            },
                            child: CustomText(
                                text: 'Review Now',
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
