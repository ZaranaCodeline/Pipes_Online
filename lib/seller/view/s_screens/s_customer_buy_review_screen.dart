import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/seller/view/s_screens/s_add_review_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../../../buyer/app_constant/app_colors.dart';
import '../../../buyer/screens/b_review_widgets.dart';
import '../../common/s_color_picker.dart';

class ScustomerBuyReviewScreen extends StatefulWidget {
  const ScustomerBuyReviewScreen({Key? key}) : super(key: key);

  @override
  State<ScustomerBuyReviewScreen> createState() =>
      _ScustomerBuyReviewScreenState();
}

class _ScustomerBuyReviewScreenState extends State<ScustomerBuyReviewScreen> {
  var rating = 3.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.commonWhiteTextColor,
        body: Container(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Card(
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
                                        height: 90,
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
                                  top: 43.0,
                                  child: Container(
                                    height: 80.0,
                                    width: 80.0,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Color(0xffE8E8E8),
                                            width: 1.0)),
                                    child: Image.asset(
                                      'assets/images/png/cat_1.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 15,
                                    left: 0,
                                    child: BackButton(
                                      color: AppColors.commonWhiteTextColor,
                                    )),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(
                          height: Get.height * 0.049,
                        ),
                        CustomText(
                            text: 'Jan Doe',
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                            color: AppColors.secondaryBlackColor),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: '5.0',
                                color: AppColors.secondaryBlackColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
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
                                  size: 20.0,
                                  filledIconData: Icons.star,
                                  halfFilledIconData: Icons.blur_on,
                                  color: AppColors.starRatingColor,
                                  borderColor: AppColors.starRatingColor,
                                  spacing: 0.0),
                              SizedBox(
                                width: Get.width * 0.01,
                              ),
                              CustomText(
                                  text: '(14 reviews)',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: AppColors.secondaryBlackColor),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.chat_bubble_outline,
                                    size: 12.sp,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.call,
                                    size: 12.sp,
                                  )),
                              CustomText(
                                  text: '+911122334455',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                  color: AppColors.secondaryBlackColor)
                            ],
                          ),
                        ),
                        // SizedBox(height: Get.height * 0.02,),
                        Card(
                          child: Column(
                            children: [
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.1),
                                child: CustomText(
                                  text: 'Summary',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
                                  color: AppColors.secondaryBlackColor,
                                  alignment: Alignment.topLeft,
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Container(
                                padding:
                                    EdgeInsets.only(bottom: Get.height * 0.1),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      height: Get.height * 0.1,
                                    ),
                                    Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          CustomText(
                                            text: '5.0',
                                            color:
                                                AppColors.secondaryBlackColor,
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
                                              borderColor:
                                                  AppColors.starRatingColor,
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
                                            '4',
                                            AppColors.starRatingLightColor,
                                            '0'),
                                        CustomRatingView(
                                            '3',
                                            AppColors.starRatingLightColor,
                                            '0'),
                                        CustomRatingView(
                                            '2',
                                            AppColors.starRatingLightColor,
                                            '0'),
                                        CustomRatingView(
                                            '1',
                                            AppColors.starRatingLightColor,
                                            '0'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.sp, vertical: 10.sp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                  text: '14 reviews',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                  color: AppColors.secondaryBlackColor),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => SAddReviewScreen());
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
                        Divider(
                          thickness: 1,
                          color: SColorPicker.lightGrey,
                        ),

                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                'assets/images/svg/pro_icon.svg',
                                width: 25.sp,
                                height: 25.sp,
                                color: AppColors.primaryColor,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: CustomText(
                                        text: 'Jan Doe',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.sp,
                                        color: AppColors.secondaryBlackColor,
                                        alignment: Alignment.topLeft,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          CustomText(
                                              text: 'Buyer',
                                              fontWeight: FontWeight.w400,
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
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: AppColors
                                                      .secondaryBlackColor,
                                                ),
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.03,
                                              ),
                                              CustomText(
                                                  text: 'Coated Coil',
                                                  fontWeight: FontWeight.w400,
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
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 15),
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
                                          size: 20.0,
                                          filledIconData: Icons.star,
                                          halfFilledIconData: Icons.blur_on,
                                          color: AppColors.starRatingColor,
                                          borderColor:
                                              AppColors.starRatingColor,
                                          spacing: 0.0),
                                    ),
                                  ],
                                ),
                              ),
                              CustomText(
                                  text: '3d',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                  color: AppColors.secondaryBlackColor),
                            ],
                          ),
                        ),

                        Divider(
                          thickness: 1,
                          color: SColorPicker.lightGrey,
                        ),

                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                'assets/images/svg/pro_icon.svg',
                                width: 25.sp,
                                height: 25.sp,
                                color: AppColors.primaryColor,
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: CustomText(
                                        text: 'Jan Doe',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.sp,
                                        color: AppColors.secondaryBlackColor,
                                        alignment: Alignment.topLeft,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          CustomText(
                                              text: 'Buyer',
                                              fontWeight: FontWeight.w400,
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
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: AppColors
                                                      .secondaryBlackColor,
                                                ),
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.03,
                                              ),
                                              CustomText(
                                                  text: 'Coated Coil',
                                                  fontWeight: FontWeight.w400,
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
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 15),
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
                                          size: 20.0,
                                          filledIconData: Icons.star,
                                          halfFilledIconData: Icons.blur_on,
                                          color: AppColors.starRatingColor,
                                          borderColor:
                                              AppColors.starRatingColor,
                                          spacing: 0.0),
                                    ),
                                  ],
                                ),
                              ),
                              CustomText(
                                  text: '3d',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                  color: AppColors.secondaryBlackColor),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
