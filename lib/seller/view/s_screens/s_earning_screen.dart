import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pipes_online/buyer/app_constant/b_image.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:pipes_online/seller/view/s_screens/s_insight.dart';
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

  @override
  Widget build(BuildContext context) {
    List months = [
      'jan',
      'feb',
      'mar',
      'apr',
      'may',
      'jun',
      'jul',
      'aug',
      'sep',
      'oct',
      'nov',
      'dec'
    ];
    var now = new DateTime.now();
    var current_mon = now.month;
    print(months[current_mon - 1]);

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
                                          color: Color(0xffE8E8E8),
                                          width: 1.0)),
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
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Orders')
                              .orderBy('createdOn', descending: true)
                              .snapshots(),
                          builder: (context, snapShot) {
                            if (snapShot.hasData) {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapShot.data?.docs.length,
                                itemBuilder: (context, index) {
                                  String? formattedDateTime;
                                  print(
                                      'LENGTH--${snapShot.data!.docs.length}');
                                  formattedDateTime = DateFormat.yMMMd().format(
                                      DateTime.parse(snapShot.data?.docs[index]
                                              ['createdOn'])
                                          .toLocal());

                                  print(
                                      '--formattedDateTime-${formattedDateTime}');
                                  print(
                                      'length=====>${snapShot.data!.docs.length}');
                                  print('Data---${snapShot.data}');
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
                                                errorBuilder: (BuildContext
                                                        context,
                                                    Object exception,
                                                    StackTrace? stackTrace) {
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
                                                  height: Get.height * 0.005,
                                                ),
                                                CustomText(
                                                  text: snapShot.data
                                                      ?.docs[index]['prdName'],
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.sp,
                                                  color: AppColors
                                                      .secondaryBlackColor,
                                                  alignment: Alignment.topLeft,
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.005,
                                                ),
                                                CustomText(
                                                  text:
                                                      'Ordered on $formattedDateTime',
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
                                                    text: 'Order ID \n',
                                                    style: STextStyle
                                                        .semiBold600Grey12,
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: snapShot
                                                                  .data
                                                                  ?.docs[index]
                                                                  .id ??
                                                              '01',
                                                          style: TextStyle(
                                                              fontSize: 9.sp,
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
                                                  height: Get.height * 0.005,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
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
                                                  text:
                                                      snapShot.data?.docs[index]
                                                              ['price'] ??
                                                          '1000',
                                                  fontWeight: FontWeight.w600,
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
                        ),
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
