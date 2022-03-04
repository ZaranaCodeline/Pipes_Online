import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../app_constant/app_colors.dart';
import '../widgets/custom_widget/custom_text.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rating = 3.0;
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
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
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              SmoothStarRating(
                                  allowHalfRating: false,
                                  onRatingChanged: (v) {
                                    // rating = v;
                                    // setState(() {});
                                  },
                                  starCount: 5,
                                  // rating: rating,
                                  size: 20.0,
                                  filledIconData: Icons.blur_off,
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
                                  fontSize: 18,
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
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomText(
                          text: '14 reviews',
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: AppColors.secondaryBlackColor),
                      CustomText(
                          text: 'Review Now',
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: AppColors.primaryColor),
                    ],
                  ),
                  Divider(),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          'assets/images/pro_icon.svg',
                          width: 36,
                          height: 36,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: CustomText(
                                    text: 'Jan Doe',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18,
                                    color: AppColors.secondaryBlackColor,alignment: Alignment.topLeft,textAlign: TextAlign.start,),
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
                                        fontSize: 16,
                                        color: AppColors.secondaryBlackColor),
                                    SizedBox(width: Get.width * 0.03,),
                                    Row(
                                      children: [
                                        Container(
                                          width: 6,
                                          height: 6,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            color: AppColors.secondaryBlackColor,
                                          ),
                                        ),
                                        SizedBox(width: Get.width * 0.03,),
                                        CustomText(
                                            text: 'Coated Coil',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: AppColors.secondaryBlackColor),
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
                                      // rating = v;
                                      // setState(() {});
                                    },
                                    starCount: 5,
                                    // rating: rating,
                                    size: 20.0,
                                    filledIconData: Icons.blur_off,
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
                            fontSize: 15,
                            color: AppColors.secondaryBlackColor),
                      ],
                    ),
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
        width: Get.width * 0.05,
      ),
      CustomText(
          text: txtName,
          fontWeight: FontWeight.w600,
          fontSize: 18,
          color: AppColors.secondaryBlackColor),
      SizedBox(
        width: Get.width * 0.03,
      ),
      Container(
        height: 10,
        width: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25), color: color),
      ),
      SizedBox(
        width: Get.width * 0.03,
      ),
      CustomText(
          text: hintName,
          fontWeight: FontWeight.w400,
          fontSize: 16,
          color: AppColors.hintTextColor),
    ],
  );
}
