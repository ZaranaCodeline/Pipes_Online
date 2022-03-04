import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../../buyer/app_constant/app_colors.dart';
import '../../../buyer/custom_widget/widgets/custom_widget/custom_button.dart';
import '../../../buyer/custom_widget/widgets/custom_widget/custom_text.dart';
import '../../common/s_color_picker.dart';
import '../../common/s_text_style.dart';

class SReviewFeedBackScreen extends StatelessWidget {
  const SReviewFeedBackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.commonWhiteTextColor,
        body: Container(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: Card(
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
                                        height: Get.height/7,
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
                                  top: 50.0.sp,
                                  child: Container(
                                    height: Get.height / 9,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: Color(0xffE8E8E8), )),
                                    child: Image.asset(
                                      'assets/images/png/cat_1.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 20.sp,
                                    left: 0,
                                    child: BackButton(
                                      color: AppColors.commonWhiteTextColor,
                                    )),
                                Positioned(
                                  top: 20.sp,
                                  child: Text(
                                    'ADD REVIEW',
                                    style: STextStyle.bold700White14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding:   EdgeInsets.only(
                                    top: 45.sp,
                                  ),
                                  child: CustomText(
                                      text: 'Jan Doe',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18.sp,
                                      color: AppColors.secondaryBlackColor),
                                ),
                                Padding(
                                  padding:   EdgeInsets.symmetric(
                                      vertical: 15.sp, horizontal: 0),
                                  child: CustomText(
                                      text: 'How was your experience?',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18.sp,
                                      color: AppColors.secondaryBlackColor),
                                ),
                                SmoothStarRating(
                                    allowHalfRating: false,
                                    onRatingChanged: (v) {
                                      // rating = v;
                                      // setState(() {});
                                    },
                                    starCount: 5,
                                    // rating: rating,
                                    size: 22.sp,
                                    filledIconData: Icons.blur_off,
                                    halfFilledIconData: Icons.blur_on,
                                    color: AppColors.hintTextColor,
                                    borderColor: AppColors.hintTextColor,
                                    spacing: 0.0),
                                SizedBox(
                                  height: Get.height * 0.02.sp,
                                ),
                                Divider(
                                    thickness: 1
                                ),
                                SizedBox(
                                  height: Get.height * 0.02.sp,
                                ),
                                CustomText(
                                    text: 'Write your feedback (optional)',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                    color: AppColors.secondaryBlackColor),
                                SizedBox(
                                    height: Get.height * 0.01.sp
                                ),
                                Card(
                                  elevation: 1,
                                  child: Padding(
                                    padding:   EdgeInsets.all(10.0.sp),
                                    child: Container(
                                      child:   TextField(
                                        decoration: InputDecoration(
                                          fillColor: SColorPicker.fontGrey,
                                          hintText: 'Enter your review',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10.0),
                                            ),
                                          ),
                                        ),
                                        maxLines: 5,
                                        keyboardType: TextInputType.multiline,
                                        // minLines: 1,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: Get.height * 0.02.sp
                                ),
                                Custombutton(
                                  name: 'Label',
                                  function: () {},
                                  // Get.to(() => HomePage()),
                                  height: Get.height * 0.06.sp,
                                  width: Get.width / 1.2.sp,
                                ),
                              ],
                            ),
                          ),
                        )
                        // SizedBox(height: Get.height * 0.02,),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
