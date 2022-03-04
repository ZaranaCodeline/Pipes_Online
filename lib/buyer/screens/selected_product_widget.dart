import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app_constant/app_colors.dart';
import '../controller/selected_product_controller.dart';
import '../custom_widget/selected_product_widgets/custom_carousel_slider.dart';
import '../custom_widget/selected_product_widgets/custom_selected_product_build_top_widget.dart';
import '../custom_widget/widgets/custom_widget/custom_navigationbar_items.dart';
import '../custom_widget/selected_product_widgets/custom_rich_text_span_widget.dart';
import '../custom_widget/widgets/custom_widget/custom_button.dart';
import '../custom_widget/widgets/custom_widget/custom_text.dart';

class SelectedProductWidget extends StatelessWidget {
  SelectedProductWidget(
      {Key? key,
      required this.name,
      required this.price,
      required this.image,
      required this.desc})
      : super(key: key);
  String name, image, desc, price;

  final List<String> imageList = [
    'https://firebasestorage.googleapis.com/v0/b/pipesonline-b2a41.appspot.com/o/cart_page.png?alt=media&token=6a4d6e9a-51b3-449a-a2bd-eb54dcec0803',
    'https://firebasestorage.googleapis.com/v0/b/pipesonline-b2a41.appspot.com/o/cart_page.png?alt=media&token=6a4d6e9a-51b3-449a-a2bd-eb54dcec0803',
  ];

  SelectedProductController controller = Get.put(SelectedProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CustomCarouselSliderWidget(
                          image: image,
                        ),
                        // CarouselWirhDotsWidgets(imgList: imageList,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: BackButton(
                            color: AppColors.commonWhiteTextColor,
                          ),
                        )
                      ],
                    ),
                    _buileSecondWidget(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationbarItems(),
    );
  }

  Widget _buileSecondWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          CustomSelectedProductBuildTopWidget(
            name: name,
            price: price,
            desc: desc,
            image: image,
          ),
          Card(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.person_outline,
                      size: 30,
                      color: AppColors.secondaryBlackColor,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        CustomRichTextSpanWidget(
                          color1: AppColors.secondaryBlackColor,
                          name1: 'Jan Doe',
                          name2: '(6 listings)',
                          color2: AppColors.hintTextColor,
                          fontsize: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CustomText(
                                text: '5.0',
                                color: AppColors.secondaryBlackColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
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
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: AppColors.secondaryBlackColor,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: CustomText(
                text:
                    'Lorem ipsum dolor sit amet, consectetur \n adipiscing elit, sed do eiusmod tempo \n incididunt ut labore et dolore magn \n aliqua.',
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: AppColors.secondaryBlackColor,
              ),
            ),
          ),
          Card(
            child: TextButton(
              onPressed: () {},
              child: CustomRichTextSpanWidget(
                name1: 'Status :',
                color1: AppColors.secondaryBlackColor,
                name2: ' For Sale',
                color2: AppColors.secondaryBlackColor,
                fontsize: 16,
              ),
            ),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: CustomText(
                      text: ' Share This Listing',
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: AppColors.secondaryBlackColor,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // controller.openWhatApp();
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: SvgPicture.asset(
                                  'assets/images/what_up_icon.svg')),
                        ),
                        SizedBox(width: 10,),
                        Icon(Icons.share_outlined),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
