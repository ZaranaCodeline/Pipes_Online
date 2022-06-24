import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/app_constant/b_image.dart';
import 'package:pipes_online/buyer/screens/b_add_reviews_page.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../app_constant/app_colors.dart';
import 'custom_widget/custom_text.dart';

class BReviewWidget extends StatefulWidget {
  final String? id, sName, desc, sImage, sContact, category, sellerID;
  final double? ratVal;
  const BReviewWidget(
      {Key? key,
      this.id,
      this.sName,
      this.desc,
      this.ratVal,
      this.category,
      this.sImage,
      this.sContact,
      this.sellerID})
      : super(key: key);

  @override
  State<BReviewWidget> createState() => _BReviewWidgetState();
}

class _BReviewWidgetState extends State<BReviewWidget> {
  // var rating = 3.0;
  // CollectionReference ProfileCollection = bFirebaseStore.collection('SProfile');
  String? Img;
  String? firstname;
  String? formattedDateTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PreferenceManager.getFcmToken();
    print('PreferenceManager.getUId()=Review==>${PreferenceManager.getUId()}');
    print('===Review =====>${widget.category}');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 0.1,
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
                    child: CustomText(
                      text: 'Summary',
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: AppColors.secondaryBlackColor,
                      alignment: Alignment.topLeft,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: Get.height * 0.1,
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomText(
                                text: '5.0',
                                color: AppColors.secondaryBlackColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              SmoothStarRating(
                                  allowHalfRating: false,
                                  // onRatingChanged: (v) {
                                  //   setState(() {
                                  //     rating = v;
                                  //   });
                                  // },
                                  starCount: 5,
                                  // rating: rating,
                                  size: 10.sp,
                                  filledIconData: Icons.star,
                                  halfFilledIconData: Icons.blur_on,
                                  color: AppColors.starRatingColor,
                                  borderColor: AppColors.starRatingColor,
                                  spacing: 0.0),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection("Reviews")
                                    // .doc(PreferenceManager.getUId().toString())
                                    // .collection('ReviewID')
                                    .snapshots(),
                                builder: (context, snapShot) {
                                  if (snapShot.hasData) {
                                    print(
                                        'length=====${snapShot.data!.docs.length}');
                                    return CustomText(
                                        text:
                                            '${snapShot.data!.docs.length} Reviews ',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.sp,
                                        color: AppColors.hintTextColor);
                                  }
                                  return Container();
                                },
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            CustomRatingView('5', AppColors.primaryColor, '5'),
                            CustomRatingView(
                                '4', AppColors.starRatingLightColor, '0'),
                            CustomRatingView(
                                '3', AppColors.starRatingLightColor, '0'),
                            CustomRatingView(
                                '2', AppColors.starRatingLightColor, '0'),
                            CustomRatingView(
                                '1', AppColors.starRatingLightColor, '0'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('BReviews')
                  // .doc(PreferenceManager.getUId())
                  // .collection('ReviewID')
                  .snapshots(),
              builder: (context, snapShot) {
                if (snapShot.hasData) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomText(
                                text: '${snapShot.data!.docs.length} Reviews ',
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                                color: AppColors
                                    .secondaryBlackColor), // CustomText(
                            //     text: '14',
                            //     fontWeight: FontWeight.w600,
                            //     fontSize: 12.sp,
                            //     color: AppColors.secondaryBlackColor),
                            GestureDetector(
                              onTap: () {
                                print(
                                    '<<<<SELLER_ID>>>>>>123 ${widget.sellerID}');
                                Get.to(
                                    AddReviewsPage(
                                      category: widget.category,
                                      sellerID: widget.sellerID,
                                    ),
                                    arguments: widget.sellerID);
                              },
                              child: CustomText(
                                  text: 'Review Now',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                  color: AppColors.primaryColor),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: snapShot.data?.docs.length,
                        itemBuilder: (context, index) {
                          print('LENGTH--${snapShot.data!.docs.length}');
                          formattedDateTime = DateFormat.yMMMd()
                              .add_jm()
                              .format(DateTime.parse(
                                      snapShot.data?.docs[index]['time'])
                                  .toLocal());

                          print('--formattedDateTime-${formattedDateTime}');
                          print('length=====>${snapShot.data!.docs.length}');
                          return Card(
                            elevation: 0.1,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.02,
                                  ),
                                  Container(
                                    // height: 200,
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50.sp),
                                              child: snapShot.data?.docs[index]
                                                          ['imageProfile'] !=
                                                      null
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      child: Image.network(
                                                          (snapShot.data?.docs[
                                                                      index][
                                                                  'imageProfile'])
                                                              .toString(),
                                                          width: 40.sp,
                                                          height: 40.sp,
                                                          fit: BoxFit.cover,
                                                          errorBuilder: (BuildContext
                                                                  context,
                                                              Object exception,
                                                              StackTrace?
                                                                  stackTrace) {
                                                        return Image.asset(
                                                          BImagePick.proIcon,
                                                          width: 40.sp,
                                                          height: 40.sp,
                                                          fit: BoxFit.cover,
                                                        );
                                                      }),
                                                    )
                                                  : Image.asset(
                                                      BImagePick.proIcon,
                                                      width: 40.sp,
                                                      height: 40.sp,
                                                      fit: BoxFit.cover,
                                                    ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20),
                                                    child: CustomText(
                                                      text: (snapShot.data!
                                                                  .docs[index]
                                                              ['user_name']) ??
                                                          'John',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14.sp,
                                                      color: AppColors
                                                          .secondaryBlackColor,
                                                      alignment:
                                                          Alignment.topLeft,
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.01,
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        CustomText(
                                                          text: snapShot.data
                                                                          ?.docs[
                                                                      index][
                                                                  'userType'] ??
                                                              'Buyer',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12.sp,
                                                          color: AppColors
                                                              .secondaryBlackColor,
                                                          textOverflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                          max: 1,
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              Get.width * 0.03,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              width: 6,
                                                              height: 6,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                                color: AppColors
                                                                    .secondaryBlackColor,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: Get.width *
                                                                  0.03,
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
                                                                        .w400,
                                                                fontSize: 12.sp,
                                                                color: AppColors
                                                                    .secondaryBlackColor),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.01,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 12),
                                                        // width: Get.width * 0.7,
                                                        child: SmoothStarRating(
                                                            allowHalfRating:
                                                                false,
                                                            starCount: 5,
                                                            rating: snapShot
                                                                        .data!
                                                                        .docs[index]
                                                                    [
                                                                    'rating'] ??
                                                                '3',
                                                            size: 15.sp,
                                                            filledIconData:
                                                                Icons.star,
                                                            halfFilledIconData:
                                                                Icons.blur_on,
                                                            color: AppColors
                                                                .starRatingColor,
                                                            borderColor: AppColors
                                                                .starRatingColor,
                                                            spacing: 0.0),
                                                      ),
                                                      CustomText(
                                                          text:
                                                              formattedDateTime
                                                                  .toString(),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 11.sp,
                                                          color: AppColors
                                                              .secondaryBlackColor),
                                                    ],
                                                  ),
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20),
                                                    child: CustomText(
                                                      text: snapShot.data!
                                                                  .docs[index]
                                                              ['dsc'] ??
                                                          'desc',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 12.sp,
                                                      color: AppColors
                                                          .secondaryBlackColor,
                                                      alignment:
                                                          Alignment.topLeft,
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.01,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.02,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget CustomRatingView(
  String txtName,
  Color color,
  String hintName,
) {
  return Row(
    children: [
      Icon(
        Icons.star,
        color: AppColors.starRatingColor,
      ),
      SizedBox(
        width: Get.width * 0.06,
      ),
      CustomText(
          text: txtName,
          fontWeight: FontWeight.w600,
          fontSize: 12.sp,
          color: AppColors.secondaryBlackColor),
      SizedBox(
        width: Get.width * 0.03,
      ),
      Container(
        height: 10,
        width: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: color),
      ),
      SizedBox(
        width: Get.width * 0.03,
      ),
      CustomText(
          text: hintName,
          fontWeight: FontWeight.w400,
          fontSize: 12.sp,
          color: AppColors.hintTextColor),
    ],
  );
}
