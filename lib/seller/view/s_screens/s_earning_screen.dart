import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pipes_online/buyer/app_constant/b_image.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:pipes_online/seller/view/s_screens/s_insight.dart';
import 'package:pipes_online/seller/view_model/time_filter_dropdown.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';
import '../../../buyer/app_constant/app_colors.dart';
import '../../../buyer/screens/custom_widget/custom_text.dart';
import '../../common/s_text_style.dart';

class SEarningsScreen extends StatefulWidget {
  const SEarningsScreen({Key? key}) : super(key: key);

  @override
  State<SEarningsScreen> createState() => _SEarningsScreenState();
}

class _SEarningsScreenState extends State<SEarningsScreen> {
  var date = DateTime.now();
  DateTime? startDate;
  DateTime? endDate;
  String? timeFileter;
  DateTime? yesterDay;
  DateTime? yesterDay1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Card(
                  margin: EdgeInsets.only(top: 0, bottom: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
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
                                  height: Get.height / 9,
                                  width: Get.width * 0.4,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    color: AppColors.commonWhiteTextColor,
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: Color(0xffE8E8E8), width: 1.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CustomText(
                                          text: 'Earnings',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.sp,
                                          color: SColorPicker.fontGrey),
                                      CustomText(
                                          text: '\$5.9k',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.sp,
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
                                ),
                              ),
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
                            text: 'Recent Transactions',
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: AppColors.secondaryBlackColor,
                            alignment: Alignment.topLeft,
                          ),
                        ),
                        GetBuilder<TimeFilterController>(
                          builder: (controller) {
                            print('controller----${controller.dropDownValue}');

                            var timeFill = controller.dropDownValue;

                            if (timeFill == 'Yesterday') {
                              yesterDay =
                                  DateTime(now.year, now.month, now.day - 1);
                              yesterDay1 = DateTime.now()
                                  .subtract(const Duration(days: 1));
                              DateTime date = DateTime.now();

                              print('yesterday......>$yesterDay');
                            } else if (timeFill == 'Last Week') {
                              DateTime date = DateTime.now();
                              print('DaTE>>>U**(   ${date.weekday}');
                              final lastWeek = DateTime(
                                  now.year, now.month, now.day - date.weekday);
                              print('Date: $lastWeek');
                              final date1 = lastWeek;
                              // final Timestamp yesterday = Timestamp.fromDate(
                              //     DateTime.now()
                              //         .subtract(const Duration(days: 1)));

                              startDate = date1
                                  .subtract(Duration(days: date1.weekday - 1));
                              endDate = date1.add(Duration(
                                  days: DateTime.daysPerWeek - date1.weekday));

                              print('Start of week: $startDate');
                              print('End of week: $endDate');
                            } else if (timeFill == 'This Week') {
                              DateTime date = DateTime.now();
                              final lastWeek =
                                  DateTime(now.year, now.month, now.day);
                              print('Date: $lastWeek');
                              final date1 = lastWeek;
                              startDate = date1
                                  .subtract(Duration(days: date1.weekday - 1));
                              endDate = date1.add(Duration(
                                  days: DateTime.daysPerWeek - date1.weekday));
                              print('Start of week: $startDate');
                              print('End of week: $endDate');
                            } else if (timeFill == 'This Month') {
                              DateTime now = new DateTime.now();
                              DateTime lastDayOfMonth =
                                  new DateTime(now.year, now.month + 1, 0);
                              DateTime startDayOfMonth =
                                  new DateTime(now.year, now.month, 0);
                              print(
                                  "s>>>>>>>>${startDayOfMonth.add(Duration(days: 1))}  d>>>>>> ${lastDayOfMonth}");
                              startDate =
                                  startDayOfMonth.add(Duration(days: 1));
                              endDate = lastDayOfMonth;
                              // print('End of week: $endDate');
                            }
                            return FutureBuilder<QuerySnapshot>(
                              future: timeFill == 'Yesterday'
                                  ? FirebaseFirestore.instance
                                      .collection('Orders')
                                      .orderBy('createdOn', descending: false)
                                      .where('createdOn',
                                          isGreaterThan: yesterDay)
                                      .get()
                                  : FirebaseFirestore.instance
                                      .collection('Orders')
                                      .orderBy('createdOn', descending: false)
                                      .where('createdOn',
                                          isGreaterThan: startDate,
                                          isLessThan: endDate)
                                      .get(),
                              builder: (context, snapShot) {
                                print('t>>>>>>>>>>>${timeFill.isDateTime}');
                                print('t>>dsd>>>>>>>>>${timeFill}');
                                print('TIME FILTER>>> $timeFileter');
                                if (snapShot.hasData) {
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    reverse: true,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: snapShot.data?.docs.length,
                                    itemBuilder: (context, index) {
                                      Timestamp? formattedDateTime;
                                      print(
                                          'controller---${controller.dropDownValue}');
                                      print(
                                          'LENGTH--${snapShot.data!.docs.length}');
                                      print('hiiiiii');
                                      // formattedDateTime = DateFormat.yMMMd()
                                      //     .add_jm()
                                      //     .format(DateTime.parse(snapShot
                                      //         .data?.docs[index]['createdOn']));
                                      formattedDateTime = snapShot
                                          .data?.docs[index]['createdOn'];
                                      print(
                                          '--formattedDateTime-${formattedDateTime?.toDate().toString()}');
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          // crossAxisAlignment:
                                          //     CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 10.sp,
                                                  horizontal: 8.sp),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                child: Image.network(
                                                    snapShot.data?.docs[index]
                                                        ['productImage'],
                                                    fit: BoxFit.fill,
                                                    width: Get.width * 0.2,
                                                    height: Get.height / 12,
                                                    errorBuilder:
                                                        (BuildContext context,
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
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height:
                                                          Get.height * 0.005,
                                                    ),
                                                    CustomText(
                                                      text: snapShot
                                                              .data?.docs[index]
                                                          ['prdName'],
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14.sp,
                                                      color: AppColors
                                                          .secondaryBlackColor,
                                                      alignment:
                                                          Alignment.topLeft,
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          Get.height * 0.005,
                                                    ),
                                                    CustomText(
                                                      text:
                                                          'Ordered on\n ${formattedDateTime?.toDate().toString()}',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 10.sp,
                                                      color:
                                                          SColorPicker.fontGrey,
                                                      alignment:
                                                          Alignment.topLeft,
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          Get.height * 0.005,
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                        text: 'Order ID \n',
                                                        style: STextStyle
                                                            .semiBold600Grey12,
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                              text: snapShot
                                                                      .data
                                                                      ?.docs[
                                                                          index]
                                                                      .id ??
                                                                  '01',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      9.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: AppColors
                                                                      .secondaryBlackColor)),
                                                          // TextSpan(text: ' world!'),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          Get.height * 0.005,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  snapShot.data?.docs[index]
                                                              ['paymentMode'] ==
                                                          'paypal'
                                                      ? SvgPicture.asset(
                                                          BImagePick.PayPalIcon,
                                                          width: 15.sp,
                                                          height: 15.sp,
                                                        )
                                                      : Image.asset(
                                                          BImagePick.stripeIcon,
                                                          width: 15.sp,
                                                          height: 15.sp,
                                                        ),
                                                  SizedBox(
                                                    width: Get.width * 0.01,
                                                  ),
                                                  CustomText(
                                                      text: snapShot.data
                                                                  ?.docs[index]
                                                              ['price'] ??
                                                          '1000',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 10.sp,
                                                      color: Colors.green),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                }
                                return SizedBox();
                              },
                            );
                          },
                        )
                        // },
                      ],
                    ),
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
