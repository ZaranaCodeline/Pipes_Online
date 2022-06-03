import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/screens/b_add_reviews_page.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../app_constant/app_colors.dart';
import 'custom_widget/custom_text.dart';

class BReviewWidget extends StatefulWidget {
  final String? id, SName, desc, sImage, sContact, category;
  final double? ratVal;
  const BReviewWidget(
      {Key? key,
      this.id,
      this.SName,
      this.desc,
      this.ratVal,
      this.category,
      this.sImage,
      this.sContact})
      : super(key: key);

  @override
  State<BReviewWidget> createState() => _BReviewWidgetState();
}

class _BReviewWidgetState extends State<BReviewWidget> {
  // var rating = 3.0;
  CollectionReference ProfileCollection = bFirebaseStore.collection('BProfile');
  String? Img;
  String? firstname;
  String? formattedDateTime;

  // Future<void> getData() async {
  //   print('demo.....');
  //   final user =
  //       await ProfileCollection.doc('${PreferenceManager.getUId()}').get();
  //   Map<String, dynamic>? getUserData = user.data() as Map<String, dynamic>?;
  //   print('=========SellerReviewWidget===============${getUserData}');
  //   setState(() {
  //     firstname = getUserData?['user_name'];
  //     Img = getUserData?['imageProfile'];
  //   });
  //   print('imageProfile==BReviewWidget======${user.get('imageProfile')}');
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getData();
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
                                    .doc(PreferenceManager.getUId().toString())
                                    .collection('ReviewID')
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
            Card(
              elevation: 0.1,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Reviews')
                              .doc(PreferenceManager.getUId())
                              .collection('ReviewID')
                              .snapshots(),
                          builder: (context, snapShot) {
                            if (snapShot.hasData) {
                              print('length=====${snapShot.data!.docs.length}');
                              print(
                                  'PreferenceManager.getUId()=====${PreferenceManager.getUId()}');
                              return CustomText(
                                  text:
                                      '${snapShot.data!.docs.length} Reviews ',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                  color: AppColors.secondaryBlackColor);
                            }
                            return Container();
                          },
                        ),
                        // CustomText(
                        //     text: '14',
                        //     fontWeight: FontWeight.w600,
                        //     fontSize: 12.sp,
                        //     color: AppColors.secondaryBlackColor),
                        GestureDetector(
                          onTap: () {
                            Get.to(AddReviewsPage(
                              category: widget.category,
                            ));
                          },
                          child: CustomText(
                              text: 'Review Now',
                              fontWeight: FontWeight.w600,
                              fontSize: 12.sp,
                              color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('Reviews')
                                  .doc(PreferenceManager.getUId())
                                  .collection('ReviewID')
                                  .snapshots(),
                              builder: (context, snapShot) {
                                print('PID-${PreferenceManager.getUId()}');
                                if (snapShot.hasData) {
                                  if (snapShot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (snapShot.connectionState ==
                                      ConnectionState.done) {}
                                  return ListView.builder(
                                    itemCount: snapShot.data!.docs.length,
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      print(
                                          'LENGTH--${snapShot.data!.docs.length}');
                                      formattedDateTime =
                                          DateFormat('yyyy-MM-dd').format(
                                              DateTime.parse(snapShot.data
                                                      ?.docs[index]['time'])
                                                  .toLocal());

                                      print(
                                          '--formattedDateTime-${formattedDateTime}');
                                      print(
                                          'length=====>${snapShot.data!.docs.length}');
                                      return Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                // ClipRRect(
                                                //   borderRadius:
                                                //       BorderRadius.circular(50.sp),
                                                //   child: snapShot.data?.docs[index][
                                                //                   'imageProfile'] ==
                                                //               null ||
                                                //           snapShot.data?.docs[index]
                                                //                   [
                                                //                   'imageProfile'] ==
                                                //               ''
                                                //       ? Center(
                                                //           child: Image.network(
                                                //           (snapShot.data
                                                //                       ?.docs[index]
                                                //                   ['imageProfile'])
                                                //               .toString(),
                                                //           width: 30.sp,
                                                //           height: 30.sp,
                                                //         ))
                                                //       : Image.network(
                                                //           /*  snapShot.data?.docs[index]
                                                //               ['imageProfile']*/
                                                //           Img == null
                                                //               ? snapShot.data
                                                //                       ?.docs[index]
                                                //                   ['imageProfile']
                                                //               : Img!,
                                                //           fit: BoxFit.cover,
                                                //           width: 30.sp,
                                                //           height: 30.sp,
                                                //         ),
                                                // ),
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 20),
                                                        child: CustomText(
                                                          text: (snapShot.data!
                                                                          .docs[
                                                                      index]
                                                                  ['user_name'])
                                                              .toString(),
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
                                                        height:
                                                            Get.height * 0.01,
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 20),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            CustomText(
                                                              text: snapShot
                                                                          .data
                                                                          ?.docs[
                                                                      index]
                                                                  ['userType'],
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 12.sp,
                                                              color: AppColors
                                                                  .secondaryBlackColor,
                                                              textOverflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              max: 1,
                                                            ),
                                                            SizedBox(
                                                              width: Get.width *
                                                                  0.03,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  width: 6,
                                                                  height: 6,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50),
                                                                    color: AppColors
                                                                        .secondaryBlackColor,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width:
                                                                      Get.width *
                                                                          0.03,
                                                                ),
                                                                CustomText(
                                                                    text: (snapShot.data?.docs[index]
                                                                            [
                                                                            'category'])
                                                                        .toString(),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        12.sp,
                                                                    color: AppColors
                                                                        .secondaryBlackColor),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            Get.height * 0.01,
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 15),
                                                        width: Get.width * 0.7,
                                                        child: SmoothStarRating(
                                                            allowHalfRating:
                                                                false,
                                                            starCount: 5,
                                                            rating: snapShot
                                                                    .data
                                                                    ?.docs[index]
                                                                ['rating'],
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
                                                    ],
                                                  ),
                                                ),
                                                CustomText(
                                                    text: formattedDateTime
                                                        .toString(),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.sp,
                                                    color: AppColors
                                                        .secondaryBlackColor),
                                              ],
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.01,
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              child: CustomText(
                                                text: (snapShot.data!
                                                        .docs[index]['dsc'])
                                                    .toString(),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 12.sp,
                                                color: AppColors
                                                    .secondaryBlackColor,
                                                alignment: Alignment.topLeft,
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.03,
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
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                  ],
                ),
              ),
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
