import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../app_constant/app_colors.dart';
import '../custom_widget/selected_product_widgets/listing_review_tab_bar.dart';
import '../custom_widget/widgets/custom_widget/custom_button.dart';
import '../custom_widget/widgets/custom_widget/custom_text.dart';

class AddReviewsPage extends StatelessWidget {
  const AddReviewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                                    height: 110,
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
                              top: 70.0,
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
                                top: 15,
                                left: 0,
                                child: BackButton(
                                  color: AppColors.commonWhiteTextColor,
                                )),
                            Positioned(
                              top: 20,
                              child: CustomText(
                                  text: 'Add Review',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: AppColors.commonWhiteTextColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 50,
                            ),
                            child: CustomText(
                                text: 'Jan Doe',
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
                                color: AppColors.secondaryBlackColor),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 50, horizontal: 0),
                            child: CustomText(
                                text: 'How was your experience?',
                                fontWeight: FontWeight.w700,
                                fontSize: 24,
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
                              size: 40.0,
                              filledIconData: Icons.blur_off,
                              halfFilledIconData: Icons.blur_on,
                              color: AppColors.hintTextColor,
                              borderColor: AppColors.hintTextColor,
                              spacing: 0.0),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          CustomText(
                              text: 'Write your feedback (optional)',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: AppColors.secondaryBlackColor),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                child: const TextField(
                                  decoration: InputDecoration(
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
                          Custombutton(
                            name: 'Label',
                            function: () {},
                            // Get.to(() => HomePage()),
                            height: Get.height * 0.07,
                            width: Get.width / 2,
                          ),
                        ],
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
    );
  }
}
