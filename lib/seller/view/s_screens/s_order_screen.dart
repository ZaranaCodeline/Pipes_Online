import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/seller/view/s_screens/s_add_review_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_color_picker.dart';
import 'package:pipes_online/seller/view/s_screens/s_order_review_info_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import '../../../buyer/app_constant/app_colors.dart';
import '../../../buyer/screens/b_image.dart';
import '../../common/s_text_style.dart';

class SOrdersScreen extends StatefulWidget {
  final bool? isBottomBarVisible;

  const SOrdersScreen({Key? key, this.isBottomBarVisible}) : super(key: key);

  @override
  State<SOrdersScreen> createState() => _SOrdersScreenState();
}

class _SOrdersScreenState extends State<SOrdersScreen> {
  Timestamp? formattedDateTime;

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
          toolbarHeight: Get.height * 0.1,
          automaticallyImplyLeading: false,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25),
            ),
          ),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Orders').snapshots(),
          builder: (BuildContext context, snapShot) {
            if (!snapShot.hasData) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade200,
                highlightColor: Colors.grey.shade300,
                child: Container(
                  height: 100.h,
                  width: 150.w,
                  child: ListView.builder(
                    itemCount: snapShot.data?.docs.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.05,
                            vertical: Get.height * 0.02),
                        child: Column(
                          children: [
                            SizedBox(height: 2.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: Get.width * 0.35,
                                  height: Get.height / 7,
                                  // flex: 3,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                SizedBox(width: 5.w),
                                Column(
                                  children: [
                                    SizedBox(height: 2.h),
                                    Container(
                                      height: 1.0.h,
                                      width: Get.width * 0.5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.grey.shade100,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Container(
                                      height: 1.0.h,
                                      width: Get.width * 0.5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.grey.shade100,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Container(
                                      height: 1.0.h,
                                      width: Get.width * 0.5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.grey.shade100,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: 2.h),
                            Container(
                              height: 1.0.h,
                              width: Get.width * 1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey.shade100,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Container(
                              height: 1.0.h,
                              width: Get.width * 1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey.shade100,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Container(
                              height: 1.0.h,
                              width: Get.width * 1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey.shade100,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Container(
                              height: 1.0.h,
                              width: Get.width * 1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey.shade100,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
              // const Center(
              //   child: CircularProgressIndicator(),
              // );
            }
            if (snapShot.hasData) {
              return ListView.builder(
                itemCount: snapShot.data?.docs.length,
                itemBuilder: (context, index) {
                  formattedDateTime = snapShot.data?.docs[index]['createdOn'];
                  print('--formattedDateTime-$formattedDateTime');
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.sp),
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
                                text:
                                    'Ordered on ${formattedDateTime?.toDate().toString()}',
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: AppColors.secondaryBlackColor),
                          ),
                        ),
                        Card(
                          child: Container(
                            decoration: const BoxDecoration(
                                /*border: Border.all(
                                  width: 1,
                                  color: AppColors.offLightPurpalColor)*/
                                ),
                            padding: EdgeInsets.zero,
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => SOrderReviewInfoScreen(),
                                    arguments: snapShot.data?.docs[index].id);
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
                                                    errorBuilder:
                                                        (BuildContext context,
                                                            Object exception,
                                                            StackTrace?
                                                                stackTrace) {
                                                    return Image.asset(
                                                      BImagePick.cartIcon,
                                                      width: Get.width * 0.25,
                                                      height: Get.height / 8,
                                                      fit: BoxFit.cover,
                                                    );
                                                  })
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
                                                      height: Get.height * 0.02,
                                                    ),
                                                    CustomText(
                                                      textOverflow:
                                                          TextOverflow.fade,
                                                      max: 1,
                                                      text: 'Product :- ',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12.sp,
                                                      color: AppColors
                                                          .hintTextColor,
                                                      alignment:
                                                          Alignment.centerLeft,
                                                    ),
                                                    CustomText(
                                                      textOverflow:
                                                          TextOverflow.fade,
                                                      // max: 1,
                                                      text: snapShot.data
                                                                  ?.docs[index]
                                                              ['prdName'] ??
                                                          'name',
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
                                                      TextOverflow.clip,
                                                  max: 1,
                                                  text: snapShot
                                                      .data!.docs[index].id,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 9.sp,
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
                                                          text: snapShot.data!
                                                                          .docs[
                                                                      index][
                                                                  'buyerName'] ??
                                                              'buyerName',
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
                                    const Divider(
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
                                              text: snapShot.data!.docs[index]
                                                      ['price'] ??
                                                  'price',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.sp,
                                              color:
                                                  AppColors.secondaryBlackColor,
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
                                                color: AppColors.hintTextColor,
                                                alignment: Alignment.topLeft,
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.01,
                                              ),
                                              CustomText(
                                                text: snapShot.data!.docs[index]
                                                        ['paymentMode'] ??
                                                    'paymentMode',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.sp,
                                                color: AppColors
                                                    .secondaryBlackColor,
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
                                              text: snapShot.data?.docs[index]
                                                      ['orderStatus'] ??
                                                  'orderStatus',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.sp,
                                              color:
                                                  AppColors.secondaryBlackColor,
                                              alignment: Alignment.centerLeft,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 2,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5.sp),
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
                                                color: AppColors.hintTextColor,
                                                alignment: Alignment.centerLeft,
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.008,
                                              ),
                                              CustomText(
                                                text: snapShot.data?.docs[index]
                                                        ['size'] ??
                                                    'orderStatus',
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
                                                  text: 'Length',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.sp,
                                                  color:
                                                      AppColors.hintTextColor,
                                                  alignment: Alignment.topLeft,
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.008,
                                                ),
                                                CustomText(
                                                  text:
                                                      snapShot.data?.docs[index]
                                                              ['length'] ??
                                                          'length',
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
                                                color: AppColors.hintTextColor,
                                                alignment: Alignment.centerLeft,
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.008,
                                              ),
                                              CustomText(
                                                text: snapShot.data?.docs[index]
                                                        ['weight'] ??
                                                    'weight',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.sp,
                                                color: AppColors
                                                    .secondaryBlackColor,
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
                                                text: /*snapShot.data
                                            ?.docs[index]['oil']*/
                                                    'oil',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.sp,
                                                color: AppColors
                                                    .secondaryBlackColor,
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
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(
                              SAddReviewScreen(
                                buyerID: snapShot.data?.docs[index]['buyerID'],

                                /*category: snapShot.data?.docs[index]
                        ['category']*/
                              ),
                            );
                          },
                          child: CustomText(
                              text: 'Review Now',
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
