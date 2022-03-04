import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../app_constant/app_colors.dart';
import '../custom_widget/selected_product_widgets/listing_review_tab_bar.dart';
import '../custom_widget/widgets/custom_app_bar_widget.dart';
import '../custom_widget/widgets/custom_widget/custom_navigationbar_items.dart';
import '../custom_widget/widgets/custom_widget/custom_text.dart';

class SellerReviewWidget extends StatelessWidget {
  const SellerReviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
          Expanded(
            flex: 4,
            child: Card(
              margin: EdgeInsets.only(top: 0,bottom: 15),
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
                                  height: 90,
                                  decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: const BorderRadius.vertical(
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
                            top: 50.0,
                            child: Container(
                              height: 80.0,
                              width: 80.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Color(0xffE8E8E8), width: 1.0)),
                              child: Image.asset(
                                'assets/images/cat_1.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          Positioned(
                              top: 0,
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
                      fontWeight: FontWeight.w700,
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

                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.hintTextColor,
                        width: 0.8,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 80,vertical:5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            child: Icon(
                              Icons.folder,
                              color: AppColors.primaryColor,
                            )
                          // SvgPicture.asset('assets/images/folder_icon.svg'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText(
                            text: 'Get contact details',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: AppColors.secondaryBlackColor),

                      ],
                    ),
                  ),
                  // SizedBox(height: Get.height * 0.02,),
                ],
              ),
            ),
          ),

            Expanded(
                flex:5,child: ListingReviewTabBarWidget()),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationbarItems(),
    );
  }
}
