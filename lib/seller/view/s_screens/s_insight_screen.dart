import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/seller/view_model/time_filter_dropdown.dart';
import 'package:sizer/sizer.dart';
import '../../../buyer/app_constant/app_colors.dart';
import '../../../buyer/screens/b_image.dart';
import '../../../buyer/screens/custom_widget/custom_text.dart';
import '../../common/s_color_picker.dart';
import '../../common/s_text_style.dart';
import 's_insight.dart';

class SInsightScreen extends StatefulWidget {
  const SInsightScreen({Key? key}) : super(key: key);

  @override
  State<SInsightScreen> createState() => _SInsightScreenState();
}

class _SInsightScreenState extends State<SInsightScreen> {
  var date = DateTime.now();
  DateTime? startDate;
  DateTime? endDate;
  String? timeFileter;
  DateTime? yesterDay;

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
                        FutureBuilder<QuerySnapshot>(
                          future: FirebaseFirestore.instance
                              .collection('Orders')
                              .get(),
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.hasData) {
                              var output = snapshot.data;
                              print(
                                  'SNAPSHOT SETTING===${snapshot.data?.docs.length}');

                              // var total=0.0;
                              // order.forEach((item){
                              //   pizzaPrices.forEach((name,price){
                              //     if(name==item){
                              //       total=total+price;
                              //     }
                              //   });
                              // });
                              return Container(
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
                                                ),
                                              ),
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
                                              color: AppColors
                                                  .commonWhiteTextColor,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                  color: Color(0xffE8E8E8),
                                                  width: 1.0)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  CustomText(
                                                      text: 'Orders',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14.sp,
                                                      color: SColorPicker
                                                          .fontGrey),
                                                  CustomText(
                                                      text:
                                                          '${snapshot.data?.docs.length}',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12.sp,
                                                      color:
                                                          SColorPicker.black),
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
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  CustomText(
                                                      text: 'Revenue',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14.sp,
                                                      color: SColorPicker
                                                          .fontGrey),
                                                  CustomText(
                                                      text: '\$5.9k',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 12.sp,
                                                      color:
                                                          SColorPicker.black),
                                                ],
                                              ),
                                              Container(
                                                width: 0.5,
                                                height: Get.height / 10,
                                                color: AppColors.hintTextColor,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  CustomText(
                                                      text: 'Pending',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14.sp,
                                                      color: SColorPicker
                                                          .fontGrey),
                                                  CustomText(
                                                      text: '0',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 16.sp,
                                                      color:
                                                          SColorPicker.black),
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
                                            color:
                                                AppColors.commonWhiteTextColor,
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
                              );
                            }
                            return Container();
                          },
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
                                GetBuilder<TimeFilterController>(
                                  builder: (controller) {
                                    print(
                                        'controller----${controller.dropDownValue}');

                                    var timeFill = controller.dropDownValue;

                                    if (timeFill == 'Yesterday') {
                                      yesterDay = DateTime(
                                          now.year, now.month, now.day - 1);

                                      print('yesterday......>$yesterDay');
                                    } else if (timeFill == 'Last Week') {
                                      DateTime date = DateTime.now();
                                      print('DaTE>>>U**(   ${date.weekday}');
                                      final lastWeek = DateTime(now.year,
                                          now.month, now.day - date.weekday);
                                      print('Date: $lastWeek');
                                      final date1 = lastWeek;
                                      final Timestamp yesterday =
                                          Timestamp.fromDate(DateTime.now()
                                              .subtract(
                                                  const Duration(days: 1)));

                                      startDate = date1.subtract(
                                          Duration(days: date1.weekday - 1));
                                      endDate = date1.add(Duration(
                                          days: DateTime.daysPerWeek -
                                              date1.weekday));

                                      print('Start of week: $startDate');
                                      print('End of week: $endDate');
                                    } else if (timeFill == 'This Week') {
                                      DateTime date = DateTime.now();
                                      final lastWeek = DateTime(
                                          now.year, now.month, now.day);
                                      print('Date: $lastWeek');
                                      final date1 = lastWeek;
                                      startDate = date1.subtract(
                                          Duration(days: date1.weekday - 1));
                                      endDate = date1.add(Duration(
                                          days: DateTime.daysPerWeek -
                                              date1.weekday));
                                      print('Start of week: $startDate');
                                      print('End of week: $endDate');
                                    } else if (timeFill == 'This Month') {
                                      DateTime now = DateTime.now();
                                      DateTime lastDayOfMonth =
                                          DateTime(now.year, now.month + 1, 0);
                                      DateTime startDayOfMonth =
                                          DateTime(now.year, now.month, 0);
                                      print(
                                          "s>>>>>>>>${startDayOfMonth.add(Duration(days: 1))}"
                                          "d>>>>>>>> ${lastDayOfMonth}");
                                      startDate = startDayOfMonth
                                          .add(Duration(days: 1));
                                      endDate = lastDayOfMonth;
                                      // print('End of week: $endDate');
                                    }
                                    return FutureBuilder<QuerySnapshot>(
                                      future: timeFill == 'Yesterday'
                                          ? FirebaseFirestore.instance
                                              .collection('Orders')
                                              .orderBy('createdOn',
                                                  descending: false)
                                              .where('createdOn',
                                                  isGreaterThan: yesterDay)
                                              .get()
                                          : FirebaseFirestore.instance
                                              .collection('Orders')
                                              .orderBy('createdOn',
                                                  descending: false)
                                              .where('createdOn',
                                                  isGreaterThan: startDate,
                                                  isLessThan: endDate)
                                              .get(),
                                      builder: (context, snapShot) {
                                        print('TIME FILTER>>> $timeFileter');

                                        if (snapShot.hasData) {
                                          return ListView.builder(
                                            shrinkWrap: true,
                                            physics: BouncingScrollPhysics(),
                                            itemCount:
                                                snapShot.data?.docs.length,
                                            itemBuilder: (context, index) {
                                              Timestamp? formattedDateTime;
                                              formattedDateTime = snapShot.data
                                                  ?.docs[index]['createdOn'];
                                              print(
                                                  '--formattedDateTime-${formattedDateTime}');

                                              return Card(
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 10.sp,
                                                              horizontal:
                                                                  10.sp),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        child: Image.network(
                                                            snapShot.data
                                                                    ?.docs[index]
                                                                [
                                                                'productImage'],
                                                            fit: BoxFit.fill,
                                                            width:
                                                                Get.width * 0.2,
                                                            height:
                                                                Get.height / 12,
                                                            errorBuilder: (BuildContext
                                                                    context,
                                                                Object exception,
                                                                StackTrace? stackTrace) {
                                                          return Image.asset(
                                                            BImagePick.cartIcon,
                                                            width:
                                                                Get.width * 0.2,
                                                            height:
                                                                Get.height / 12,
                                                            fit: BoxFit.cover,
                                                          );
                                                        }),
                                                      ),
                                                    ),
                                                    Container(
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height:
                                                                  Get.height *
                                                                      0.01,
                                                            ),
                                                            CustomText(
                                                              text:
                                                                  'Ordered on: \n${formattedDateTime?.toDate().toString()}',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 10.sp,
                                                              color:
                                                                  SColorPicker
                                                                      .fontGrey,
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  Get.height *
                                                                      0.01,
                                                            ),
                                                            CustomText(
                                                              text: snapShot
                                                                          .data!
                                                                          .docs[index]
                                                                      [
                                                                      'prdName'] ??
                                                                  'Product',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14.sp,
                                                              color: AppColors
                                                                  .secondaryBlackColor,
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  Get.height *
                                                                      0.01,
                                                            ),
                                                            CustomText(
                                                              text: snapShot
                                                                          .data!
                                                                          .docs[index]
                                                                      [
                                                                      'category'] ??
                                                                  'category',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 10.sp,
                                                              color:
                                                                  SColorPicker
                                                                      .fontGrey,
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  Get.height *
                                                                      0.005,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * 0.01,
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
                                            child: SizedBox(),
                                          );
                                        }
                                        return Center(
                                          child: SizedBox(),
                                        );
                                      },
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
