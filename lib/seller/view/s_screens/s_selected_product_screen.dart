import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/seller/view/s_screens/s_edit_product_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_review_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../../buyer/app_constant/app_colors.dart';
import '../../../buyer/custom_widget/selected_product_widgets/custom_carousel_slider.dart';
import '../../../buyer/custom_widget/selected_product_widgets/custom_rich_text_span_widget.dart';
import '../../../buyer/custom_widget/selected_product_widgets/custom_selected_product_build_top_widget.dart';
import '../../../buyer/custom_widget/widgets/custom_text.dart';
import '../../../buyer/screens/add_reviews_page.dart';
import '../../common/s_common_button.dart';

class SSelectedProductScreen extends StatefulWidget {
  SSelectedProductScreen({
    this.image,
    this.name,
    this.desc,
    this.price,
    Key? key,
  }) : super(key: key);
  String? image, name, desc, price;

  @override
  State<SSelectedProductScreen> createState() => _SSelectedProductScreenState();
}

class _SSelectedProductScreenState extends State<SSelectedProductScreen> {
  var rating = 3.0;
  final List<String> imageList = [
    'https://firebasestorage.googleapis.com/v0/b/pipesonline-b2a41.appspot.com/o/cart_page.png?alt=media&token=6a4d6e9a-51b3-449a-a2bd-eb54dcec0803',
    'https://firebasestorage.googleapis.com/v0/b/pipesonline-b2a41.appspot.com/o/cart_page.png?alt=media&token=6a4d6e9a-51b3-449a-a2bd-eb54dcec0803',
  ];

  // SelectedProductController controller = Get.put(SelectedProductController());
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    String name = 'sdf',
        image =
            "https://firebasestorage.googleapis.com/v0/b/pipesonline-b2a41.appspot.com/o/cart_page.png?alt=media&token=6a4d6e9a-51b3-449a-a2bd-eb54dcec0803",
        desc = "dsfs",
        price = "10000";
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CustomCarouselSliderWidget(
                      image: image,
                    ),
                    // CarouselWirhDotsWidgets(imgList: imageList,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.sp),
                      child: BackButton(
                        color: AppColors.commonWhiteTextColor,
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.sp,
                    vertical: 15.sp,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0.sp),
                          child: buildMiddleWidget(
                            name,
                            price,
                            desc,
                          ),
                        ),
                        Card(
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10.sp),
                            child: InkWell(
                              onTap: () {
                                Get.to(() => SReviewScreen());
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5.sp),
                                          child: Row(
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
                                              SmoothStarRating(
                                                  allowHalfRating: false,
                                                  onRatingChanged: (v) {
                                                    setState(() {
                                                      rating = v;
                                                    });
                                                  },
                                                  starCount: 5,
                                                  rating: rating,
                                                  size: 18.0.sp,
                                                  filledIconData: Icons.star,
                                                  halfFilledIconData:
                                                      Icons.blur_on,
                                                  color:
                                                      AppColors.starRatingColor,
                                                  borderColor:
                                                      AppColors.starRatingColor,
                                                  spacing: 0.0),
                                              CustomText(
                                                  text: '(14 reviews)',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.sp,
                                                  color: AppColors
                                                      .secondaryBlackColor),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.005.sp,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: AppColors.secondaryBlackColor,
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.005.sp,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                        Card(
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10.sp),
                            child: CustomText(
                              text:
                                  'Lorem ipsum dolor sit amet, consectetur \n adipiscing elit, sed do eiusmod tempo \n incididunt ut labore et dolore magn \n aliqua.',
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: AppColors.secondaryBlackColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 70.sp),
                          child: SCommonButton().sCommonPurpleButton(
                            name: 'Edit Product',
                            onTap: () {
                              Get.to(() => SeditProductScreen());
                              print('edit product seller side');
                              // Get.toNamed(SRoutes.SSubmitProfileScreen);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buileSecondWidget() {
  Widget buildMiddleWidget(String name, String price, String desc) {
    return Container(
      child: Column(
        children: [
          CustomText(
            text: 'Test',
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
            color: AppColors.primaryColor,
            alignment: Alignment.topLeft,
          ),
          // SizedBox(height: Get.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                  text: "Desc",
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: AppColors.secondaryBlackColor),
              Container(
                height: Get.height / 12.sp,
                decoration: BoxDecoration(
                    color: AppColors.commonWhiteTextColor,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      new BoxShadow(
                          blurRadius: 1, color: AppColors.hintTextColor),
                    ]),
                child: TextButton(
                    onPressed: () {},
                    child:
                        SvgPicture.asset('assets/images/svg/delete_icon.svg')),
              ),
            ],
          ),
          CustomText(
            text: "Price",
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            color: AppColors.secondaryBlackColor,
            alignment: Alignment.topLeft,
          ),
          const Divider(
            height: 10,
          ),
        ],
      ),
    );
  }
}
