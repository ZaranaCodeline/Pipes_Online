import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../buyer/app_constant/app_colors.dart';
import '../../../buyer/screens/b_image.dart';
import '../../../buyer/screens/custom_widget/custom_text.dart';
import '../../common/s_color_picker.dart';
import '../../common/s_text_style.dart';
import 's_insight.dart';

class SInsightScreen extends StatelessWidget {
  const SInsightScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
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
                              clipBehavior: Clip.none,
                              alignment: Alignment.bottomCenter,
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
                                    width: Get.width * 0.8,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: AppColors.commonWhiteTextColor,
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                            color: Color(0xffE8E8E8),
                                            width: 1.0)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            CustomText(
                                                text: 'Orders',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.sp,
                                                color: SColorPicker.fontGrey),
                                            CustomText(
                                                text: ' snapshot',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.sp,
                                                color: SColorPicker.black),
                                            /* StreamBuilder<QuerySnapshot>(
                                              stream: FirebaseFirestore.instance
                                                  .collection('Orders')
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                return CustomText(
                                                    text: snapshot
                                                        .data!.docs.length
                                                        .toString(),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.sp,
                                                    color: SColorPicker.black);
                                              },
                                            ),*/
                                          ],
                                        ),
                                        Container(
                                          width: 0.5,
                                          height: Get.height / 10,
                                          color: AppColors.hintTextColor,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            CustomText(
                                                text: 'Revenue',
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
                                        Container(
                                          width: 0.5,
                                          height: Get.height / 10,
                                          color: AppColors.hintTextColor,
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            CustomText(
                                                text: 'Pending',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12.sp,
                                                color: SColorPicker.fontGrey),
                                            CustomText(
                                                text: '10',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16.sp,
                                                color: SColorPicker.black),
                                          ],
                                        ),
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
                                    'INSIGHT',
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
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10.sp, vertical: 15.sp),
                                  height: Get.height / 2,
                                  width: Get.width * 1,
                                  child: LineChartPage(),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.sp, horizontal: 10.sp),
                                  child: CustomText(
                                      alignment: Alignment.topLeft,
                                      text: 'Top Selling Items',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                      color: AppColors.secondaryBlackColor),
                                ),
                                StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('Orders')
                                      .snapshots(),
                                  builder: (context, snapShot) {
                                    if (snapShot.hasData) {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapShot.data?.docs.length,
                                        itemBuilder: (context, index) {
                                          return Card(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10.sp,
                                                      horizontal: 10.sp),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    child: Image.network(
                                                        snapShot.data
                                                                ?.docs[index]
                                                            ['productImage'],
                                                        fit: BoxFit.fill,
                                                        width: Get.width * 0.2,
                                                        height: Get.height / 12,
                                                        errorBuilder: (BuildContext
                                                                context,
                                                            Object exception,
                                                            StackTrace?
                                                                stackTrace) {
                                                      return Image.asset(
                                                        BImagePick.cartIcon,
                                                        width: Get.width * 0.2,
                                                        height: Get.height / 12,
                                                        fit: BoxFit.cover,
                                                      );
                                                    }),
                                                  ),
                                                ),
                                                Container(
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: Get.height *
                                                              0.005,
                                                        ),
                                                        CustomText(
                                                          text: snapShot.data!
                                                                          .docs[
                                                                      index]
                                                                  ['prdName'] ??
                                                              'Product',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14.sp,
                                                          color: AppColors
                                                              .secondaryBlackColor,
                                                          alignment:
                                                              Alignment.topLeft,
                                                        ),
                                                        SizedBox(
                                                          height: Get.height *
                                                              0.005,
                                                        ),
                                                        CustomText(
                                                          text: snapShot.data!
                                                                          .docs[
                                                                      index][
                                                                  'category'] ??
                                                              'category',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 10.sp,
                                                          color: SColorPicker
                                                              .fontGrey,
                                                          alignment:
                                                              Alignment.topLeft,
                                                        ),
                                                        SizedBox(
                                                          height: Get.height *
                                                              0.005,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  child: RichText(
                                                    text: TextSpan(
                                                      text: 'Revenue ',
                                                      style: STextStyle
                                                          .semiBold600Grey12,
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text: '\$1k',
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
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    }
                                    if (!snapShot.hasData) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        )
                        // SizedBox(height: Get.height * 0.02,),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
