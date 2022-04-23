import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/screens/b_add_reviews_page.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../app_constant/app_colors.dart';
import 'custom_widget/custom_text.dart';

class BReviewWidget extends StatefulWidget {
  const BReviewWidget({Key? key}) : super(key: key);

  @override
  State<BReviewWidget> createState() => _BReviewWidgetState();
}

class _BReviewWidgetState extends State<BReviewWidget> {
  var rating = 3.0;
  CollectionReference ProfileCollection = bFirebaseStore.collection('BProfile');
  String? Img;
  String? firstname;

  Future<void> getData() async {
    print('demo.....');
    final user =
    await ProfileCollection.doc('${PreferenceManager.getUId()}')
        .get();
    Map<String, dynamic>? getUserData = user.data() as Map<String, dynamic>?;
    firstname = getUserData!['firstname'];
    print('=========SellerReviewWidget===============${getUserData}');
    setState(() {
      Img = getUserData['imageProfile'];
    });
    print('============================${user.get('imageProfile')}');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
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
                                  onRatingChanged: (v) {
                                    setState(() {
                                      rating = v;
                                    });
                                  },
                                  starCount: 5,
                                  rating: rating,
                                  size: 10.sp,
                                  filledIconData: Icons.star,
                                  halfFilledIconData: Icons.blur_on,
                                  color: AppColors.starRatingColor,
                                  borderColor: AppColors.starRatingColor,
                                  spacing: 0.0),
                              SizedBox(
                                height: Get.height * 0.01,
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
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomText(
                          text: '14 reviews',
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                          color: AppColors.secondaryBlackColor),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => AddReviewsPage());
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
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50.sp),
                          child: Image.network(
                            Img == null
                                ? 'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'
                                : Img!,
                            fit: BoxFit.cover,
                            width: 30.sp,
                            height:30.sp,
                          ),
                        ),
                        Flexible(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: CustomText(
                                  text: firstname.toString(),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: AppColors.secondaryBlackColor,
                                  alignment: Alignment.topLeft,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomText(
                                        text: 'Buyer',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.sp,
                                        color: AppColors.secondaryBlackColor),
                                    SizedBox(
                                      width: Get.width * 0.03,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 6,
                                          height: 6,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color:
                                                AppColors.secondaryBlackColor,
                                          ),
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.03,
                                        ),
                                        CustomText(
                                            text: 'Coated Coil',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.sp,
                                            color:
                                                AppColors.secondaryBlackColor),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                width: Get.width * 0.7,
                                child: SmoothStarRating(
                                    allowHalfRating: false,
                                    onRatingChanged: (v) {
                                      setState(() {
                                        rating = v;
                                      });
                                    },
                                    starCount: 5,
                                    rating: rating,
                                    size: 15.sp,
                                    filledIconData: Icons.star,
                                    halfFilledIconData: Icons.blur_on,
                                    color: AppColors.starRatingColor,
                                    borderColor: AppColors.starRatingColor,
                                    spacing: 0.0),
                              ),
                            ],
                          ),
                        ),
                        CustomText(
                            text: '3d',
                            fontWeight: FontWeight.w400,
                            fontSize: 12.sp,
                            color: AppColors.secondaryBlackColor),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                ],
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
