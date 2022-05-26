import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/seller/view/s_screens/s_customer_buy_review_screen.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../../../buyer/app_constant/app_colors.dart';
import '../../../buyer/app_constant/b_image.dart';
import '../../../buyer/screens/b_review_widgets.dart';
import '../../common/s_color_picker.dart';
import 's_add_review_screen.dart';

class SSellerReviewScreen extends StatefulWidget {
  const SSellerReviewScreen({Key? key}) : super(key: key);

  @override
  State<SSellerReviewScreen> createState() => _SSellerReviewScreenState();
}

class _SSellerReviewScreenState extends State<SSellerReviewScreen> {
  var rating = 3.0;

  @override
  Widget build(BuildContext context) {
    _showPopupMenu() {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      final offset = renderBox.localToGlobal(Offset.zero);
      //*calculate the start point in this case, below the button
      final left = offset.dx;
      final top = offset.dy + renderBox.size.height;
      //*The right does not indicates the width
      final right = left + renderBox.size.width;
      final bottom = offset.dx;
      showMenu<String>(
        context: context,
        color: AppColors.primaryColor,
        position: RelativeRect.fromLTRB(25, 0, 25, 25),
        //position where you want to show the menu on screen
        items: [
          PopupMenuItem<String>(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  CustomText(
                    text: 'Contact to Buyer',
                    color: AppColors.commonWhiteTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                  ),
                ],
              ),
            ),
            value: '1',
          ),
          PopupMenuItem<String>(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.008,
                ),
                Center(
                  child: CustomText(
                    text: '\$5',
                    color: AppColors.commonWhiteTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 35,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.008,
                ),
              ],
            ),
            value: '2',
          ),
          PopupMenuItem<String>(
            child: GestureDetector(
              onTap: () {
                Get.to(ScustomerBuyReviewScreen());
              },
              child: Container(
                height: Get.height * 0.08,
                width: Get.width * 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.commonWhiteTextColor,
                  ),
                  child: CustomText(
                    textAlign: TextAlign.center,
                    text: 'Get Contact details',
                    alignment: Alignment.center,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: AppColors.secondaryBlackColor,
                  ),
                ),
              ),
            ),
            value: '3',
          ),
          PopupMenuItem<String>(
            child: Center(
                child: SizedBox(
              height: Get.height * 0.008,
            )),
            value: '4',
          ),
          PopupMenuItem<String>(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.commonWhiteTextColor,
                    ),
                  ),
                  CustomText(
                    text:
                        ' By this subscription\n you can call and chat\n with seller at any time.',
                    color: AppColors.commonWhiteTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
              value: '5'),
          PopupMenuItem<String>(
            child: Center(
                child: SizedBox(
              height: Get.height * 0.01,
            )),
            value: '6',
          ),
        ],
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );
    }

    return SafeArea(
      child: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('SProfile')
            .doc(PreferenceManager.getUId())
            .get(),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var output = snapshot.data;
            print('==========BUYER ID======== ${PreferenceManager.getUId()}');
            print('SELLER REVIEW SNAPSHOT IMAGE=== ${output!['imageProfile']}');
            return Container(
              color: AppColors.commonWhiteTextColor,
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
                                  alignment: Alignment.bottomCenter,
                                  overflow: Overflow.visible,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            height: 70,
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
                                      top: 20.0,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Container(
                                          height: 80.0,
                                          width: 80.0,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Color(0xffE8E8E8),
                                                width: 1.0),
                                          ),
                                          child: output['imageProfile'] != null
                                              ? Image.network(
                                                  output['imageProfile'],
                                                  width: 35.sp,
                                                  height: 35.sp,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  'assets/images/png/cat_1.png',
                                                  fit: BoxFit.contain,
                                                ),
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
                                text: output['user_name'] ?? 'john dem',
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
                              height: Get.height / 13,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: SColorPicker.lightGrey,
                                  width: 0.8,
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 80, vertical: 4),
                              child: InkWell(
                                onTap: () {
                                  print('Get Contatc Detail');
                                  _showPopupMenu();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        width: 25.sp,
                                        height: 25.sp,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                              color: AppColors.starRatingColor),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: SvgPicture.asset(
                                            BImagePick.ReviewsIcon,
                                            color: SColorPicker.purple)
                                        // SvgPicture.asset('assets/images/folder_icon.svg'),
                                        ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    CustomText(
                                        text: 'Get contact details',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                        color: AppColors.secondaryBlackColor),
                                  ],
                                ),
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
                                    padding: EdgeInsets.only(
                                        bottom: Get.height * 0.1),
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
                                                color: AppColors
                                                    .secondaryBlackColor,
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
                                                  halfFilledIconData:
                                                      Icons.blur_on,
                                                  color:
                                                      AppColors.starRatingColor,
                                                  borderColor:
                                                      AppColors.starRatingColor,
                                                  spacing: 0.0),
                                              SizedBox(
                                                height: Get.height * 0.01,
                                              ),
                                              CustomText(
                                                  text: '(14 reviews)',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.sp,
                                                  color:
                                                      AppColors.hintTextColor),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            CustomRatingView('5',
                                                AppColors.primaryColor, '5'),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                      text: '14 reviews',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
                                      color: AppColors.secondaryBlackColor),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(SAddReviewScreen());
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
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: CustomText(
                                            text: 'Jan Doe...',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp,
                                            color:
                                                AppColors.secondaryBlackColor,
                                            alignment: Alignment.topLeft,
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
                                                          BorderRadius.circular(
                                                              50),
                                                      color: AppColors
                                                          .secondaryBlackColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: Get.width * 0.03,
                                                  ),
                                                  CustomText(
                                                      text: 'Coated Coil',
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 15),
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
                                      text: '3d1111',
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
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: CustomText(
                                            text: 'Jan Doe',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp,
                                            color:
                                                AppColors.secondaryBlackColor,
                                            alignment: Alignment.topLeft,
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
                                                          BorderRadius.circular(
                                                              50),
                                                      color: AppColors
                                                          .secondaryBlackColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: Get.width * 0.03,
                                                  ),
                                                  CustomText(
                                                      text: 'Coated Coil',
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 15),
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
            );
          }
        },
      ),
    );
  }
}
