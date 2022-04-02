import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/buyer_common/b_image.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:pipes_online/seller/view/s_screens/s_customer_review.dart';
import 'package:pipes_online/seller/view/s_screens/s_edit_product_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../../buyer/custom_widget/selected_product_widgets/custom_carousel_slider.dart';
import '../../../buyer/custom_widget/widgets/custom_text.dart';
import '../../../buyer/screens/add_reviews_page.dart';
import '../../common/s_common_button.dart';
import '../../common/s_text_style.dart';

class SorderReviewScreen extends StatefulWidget {
  const SorderReviewScreen({Key? key}) : super(key: key);

  @override
  State<SorderReviewScreen> createState() => _SorderReviewScreenState();
}

class _SorderReviewScreenState extends State<SorderReviewScreen> {
  var rating = 3.0;
  @override
  Widget build(BuildContext context) {
    final List<String> imageList = [
      'https://firebasestorage.googleapis.com/v0/b/pipesonline-b2a41.appspot.com/o/cart_page.png?alt=media&token=6a4d6e9a-51b3-449a-a2bd-eb54dcec0803',
      'https://firebasestorage.googleapis.com/v0/b/pipesonline-b2a41.appspot.com/o/cart_page.png?alt=media&token=6a4d6e9a-51b3-449a-a2bd-eb54dcec0803',
    ];
    String name = 'sdf',
        image =
            "https://firebasestorage.googleapis.com/v0/b/pipesonline-b2a41.appspot.com/o/cart_page.png?alt=media&token=6a4d6e9a-51b3-449a-a2bd-eb54dcec0803",
        desc = "dsfs",
        price = "10000";
    return SafeArea(
      child: Scaffold(
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
                          Card(
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomText(
                                        text: 'Ordered on 24 Dec 12:20',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                        color: AppColors.secondaryBlackColor),
                                    CustomText(
                                        text: 'Order ID 000001',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.sp,
                                        color:SColorPicker.fontGrey),
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.05,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            text: 'Round',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp,
                                            color: AppColors.primaryColor),
                                        CustomText(
                                            text: 'Product ID 09456789',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.sp,
                                            color:SColorPicker.fontGrey),
                                      ],
                                    ),
                                    CustomText(
                                        text: '\$20',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                        color: AppColors.secondaryBlackColor),
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.03,
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 10.sp),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          CustomText(
                                            text: 'Size',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp,
                                            color: SColorPicker.fontGrey,
                                            alignment: Alignment.centerLeft,
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.008,
                                          ),
                                          CustomText(
                                            text: '2 ft',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp,
                                            color:
                                                AppColors.secondaryBlackColor,
                                            alignment: Alignment.centerLeft,
                                          ),
                                        ],
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            CustomText(
                                              text: 'Length',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.sp,
                                              color: SColorPicker.fontGrey,
                                              alignment: Alignment.topLeft,
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.008,
                                            ),
                                            CustomText(
                                              text: '2 kg',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.sp,
                                              color:
                                                  AppColors.secondaryBlackColor,
                                              alignment: Alignment.centerLeft,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          CustomText(
                                            text: 'Weight',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp,
                                            color:SColorPicker.fontGrey,
                                            alignment: Alignment.centerLeft,
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.008,
                                          ),
                                          CustomText(
                                            text: 'Pending',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp,
                                            color:
                                                AppColors.secondaryBlackColor,
                                            alignment: Alignment.centerLeft,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          CustomText(
                                            text: 'Oil',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp,
                                            color:SColorPicker.fontGrey,
                                            alignment: Alignment.centerLeft,
                                          ),
                                          CustomText(
                                            text: '--',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp,
                                            color:
                                                AppColors.secondaryBlackColor,
                                            alignment: Alignment.centerLeft,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          GestureDetector(
                            onTap: (){
                              Get.to(()=>ScustomerReviewScreen());
                            },
                            child: Card(
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(10.sp),
                                    child: CustomText(
                                      text: 'Customer Details',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp,
                                      color: AppColors.secondaryBlackColor,
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        CustomText(
                                            text: 'Jan Doe',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.sp,
                                            color: AppColors.secondaryBlackColor),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5.sp),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                width: Get.width * 0.005.sp,
                                              ),
                                              CustomText(
                                                text: '5.0',
                                                color:
                                                    AppColors.secondaryBlackColor,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.005.sp,
                                              ),
                                              SmoothStarRating(
                                                  allowHalfRating: false,
                                                  onRatingChanged: (v) {
                                                    rating = v;
                                                    setState(() {});
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
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.sp),
                                    child: CustomText(
                                        text:
                                            ' A-00, Abc Soc, Abc \n Road, Area,City, State, \n country -pincode',
                                        alignment: Alignment.topLeft,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: AppColors.secondaryBlackColor),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.03,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          InkWell(
                            onTap: () {
                              print('Get Contatc Detail');
                            },
                            child: FittedBox(
                              child: Container(
                                padding: EdgeInsets.all(8.sp),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.10,
                                      color: SColorPicker.fontGrey),
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 1,
                                        color: AppColors.offWhiteColor)
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: 27,
                                      height: 27,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: AppColors.starRatingColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: SvgPicture.asset(
                                          BImagePick.ReviewsIcon,color: SColorPicker.purple,),
                                      // SvgPicture.asset('assets/images/folder_icon.svg'),
                                    ),
                                    const SizedBox(
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
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 70.sp),
                            child: SCommonButton().sCommonPurpleButton(
                              name: 'Continue',
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
      ),
    );
  }

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
