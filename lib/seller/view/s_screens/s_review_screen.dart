import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/app_constant/b_image.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:pipes_online/seller/view/s_screens/s_add_review_screen.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../../buyer/app_constant/app_colors.dart';
import '../../../buyer/screens/b_review_widgets.dart';
import '../../../buyer/screens/custom_widget/custom_text.dart';
import '../../common/s_text_style.dart';

class SReviewScreen extends StatefulWidget {
  const SReviewScreen({Key? key}) : super(key: key);

  @override
  State<SReviewScreen> createState() => _SReviewScreenState();
}

class _SReviewScreenState extends State<SReviewScreen> {
  DocumentReference profileCollection =
      bFirebaseStore.collection('Orders').doc();
  String? buyerID;
  double? ratingVal;

  Future<void> getData() async {
    print('demo.....');
    print('profileCollection.....${profileCollection}');
    final user = await profileCollection.get();

    var m = user.data();
    print('--SelectedProductWidget----m----$m');
    dynamic getUserData = m;
    setState(() {
      print('======ID=====${PreferenceManager.getUId()}');
      print('buyer_deatils_seller_review_screen=====${getUserData}');
      buyerID = getUserData?['buyerID'];
      // Img = getUserData?['imageProfile'];
    });
    print('rating:---${getUserData?['rating']}');
  }

  var rating = 3.0;
  String? formattedDateTime;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    print('BID-----${buyerID}');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'REVIEWS',
            style: STextStyle.bold700White14,
          ),
          backgroundColor: AppColors.primaryColor,
          toolbarHeight: Get.height * 0.1,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * 0.1),
                      child: CustomText(
                        text: 'Summary',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: AppColors.secondaryBlackColor,
                        alignment: Alignment.topLeft,
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: Get.height * 0.1),
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
                                  height: Get.height * 0.02,
                                ),
                                SmoothStarRating(
                                    allowHalfRating: false,
                                    onRatingChanged: (v) {
                                      setState(() {
                                        rating = v;
                                      });
                                    },
                                    starCount: 5,
                                    rating: rating,
                                    size: 20.0.sp,
                                    filledIconData: Icons.star,
                                    halfFilledIconData: Icons.blur_on,
                                    color: AppColors.starRatingColor,
                                    borderColor: AppColors.starRatingColor,
                                    spacing: 0.0),
                                SizedBox(
                                  height: Get.height * 0.02,
                                ),
                                CustomText(
                                    text: '(14 reviews)',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: AppColors.hintTextColor),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              CustomRatingView(
                                  '5', AppColors.primaryColor, '5'),
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
              FutureBuilder<QuerySnapshot>(
                future: /*FirebaseFirestore.instance
                    .collection('Orders')
                    .get() */
                    FirebaseFirestore.instance
                        .collection('BReviews')
                        // .doc('ECLSpOEIW2aY3nofS9IAem22Eo52')
                        // .collection('ReviewID')
                        .get(),
                builder: (BuildContext context, snapShot) {
                  if (!snapShot.hasData) {
                    Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapShot.hasData) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.sp, vertical: 10.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                  text: '${snapShot.data?.docs.length} reviews',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  color: AppColors.secondaryBlackColor),
                              GestureDetector(
                                onTap: () {
                                  Get.to(SAddReviewScreen());
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
                        Divider(
                          thickness: 1,
                          color: SColorPicker.lightGrey,
                        ),
                        ListView.builder(
                          itemCount: snapShot.data?.docs.length,
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            formattedDateTime = DateFormat.yMMMd()
                                .add_jm()
                                .format(DateTime.parse(
                                    snapShot.data?.docs[index]['time']));
                            print('--formattedDateTime-${formattedDateTime}');

                            return Container(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          snapShot.data?.docs[index]
                                                      ['imageProfile'] !=
                                                  null
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  child: Image.network(
                                                      snapShot.data?.docs[index]
                                                          ['imageProfile'],
                                                      width: 30.sp,
                                                      height: 30.sp,
                                                      fit: BoxFit.cover,
                                                      errorBuilder:
                                                          (BuildContext context,
                                                              Object exception,
                                                              StackTrace?
                                                                  stackTrace) {
                                                    return Image.asset(
                                                      BImagePick.cartIcon,
                                                      width: 30.sp,
                                                      height: 30.sp,
                                                      fit: BoxFit.cover,
                                                    );
                                                  }),
                                                )
                                              : SvgPicture.asset(
                                                  'assets/images/svg/pro_icon.svg',
                                                  width: 25.sp,
                                                  height: 25.sp,
                                                  color: AppColors.primaryColor,
                                                ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20),
                                                  child: CustomText(
                                                    text: snapShot.data
                                                                ?.docs[index]
                                                            ['user_name'] ??
                                                        'john',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12.sp,
                                                    color: AppColors
                                                        .secondaryBlackColor,
                                                    alignment:
                                                        Alignment.topLeft,
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.01,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 20),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      CustomText(
                                                          text: 'Buyer',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12.sp,
                                                          color: AppColors
                                                              .secondaryBlackColor),
                                                      SizedBox(
                                                        width: Get.width * 0.03,
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
                                                              text: snapShot.data
                                                                              ?.docs[
                                                                          index]
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
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 15),
                                                      // width: Get.width * 0.7,
                                                      child: SmoothStarRating(
                                                          allowHalfRating:
                                                              false,
                                                          // onRatingChanged: (v) {
                                                          //   rating = v;
                                                          //   setState(() {});
                                                          // },
                                                          starCount: 5,
                                                          rating: snapShot.data!
                                                                          .docs[
                                                                      index]
                                                                  ['rating'] ??
                                                              'rating',
                                                          size: 20.0,
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
                                                        text: formattedDateTime
                                                            .toString(),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 11.sp,
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
                                                      alignment:
                                                          Alignment.topLeft,
                                                      text: snapShot.data!
                                                                  .docs[index]
                                                              ['dsc'] ??
                                                          'Description',
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 10.sp,
                                                      max: 1,
                                                      textOverflow:
                                                          TextOverflow.ellipsis,
                                                      color: AppColors
                                                          .hintTextColor),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1,
                                      color: SColorPicker.lightGrey,
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
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
