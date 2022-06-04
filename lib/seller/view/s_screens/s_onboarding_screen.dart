import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/s_onboarding_screen/s_onboarding_controller.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:pipes_online/seller/common/s_common_button.dart';
import 'package:pipes_online/seller/common/s_image.dart';
import 'package:pipes_online/seller/common/s_text_style.dart';
import 'package:sizer/sizer.dart';

import '../../../routes/app_routes.dart';

class SOnBoardingScreen extends StatefulWidget {
  @override
  _SOnBoardingScreenState createState() => _SOnBoardingScreenState();
}

class _SOnBoardingScreenState extends State<SOnBoardingScreen> {
  PageController _pageController = PageController(initialPage: 0);
  OnBoardingController _onBoardingController = Get.put(OnBoardingController());

  int nextPage = 0;
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => _animateSlider());
  }

  void _animateSlider() {
    Future.delayed(Duration(seconds: 5)).then((_) {
      if (nextPage < 1) {
        print('if===nextPage: $nextPage');
        nextPage = _pageController.page!.round() + 1;
        _pageController
            .animateToPage(nextPage,
                duration: Duration(seconds: 1), curve: Curves.linear)
            .then((_) => _animateSlider());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: SColorPicker.white,
        child: SafeArea(
          child: Container(
            child: GetBuilder<OnBoardingController>(
              builder: (controller) {
                return Column(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: _pageController,
                        physics: BouncingScrollPhysics(),
                        onPageChanged: (value) {
                          controller.setOnBoarding(value);
                        },
                        children: [
                          SafeArea(
                            child: Container(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 50.sp,
                                    ),
                                    Container(
                                        height: 190.sp,
                                        width: 250.sp,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 15.sp,
                                        ),
                                        decoration: BoxDecoration(
                                            color: SColorPicker.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black12,
                                                  spreadRadius: 0.5,
                                                  blurRadius: 1),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10.sp)),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.sp),
                                          child: SvgPicture.asset(
                                              "${SImagePick.onBoarding1}"),
                                        )),
                                    SizedBox(
                                      height: 20.sp,
                                    ),
                                    Text(
                                      "Add products in cart\nand shop now",
                                      textAlign: TextAlign.center,
                                      style: STextStyle.semiBold600Purple16,
                                    ),
                                    SizedBox(
                                      height: 20.sp,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 30.sp, right: 30.sp),
                                      child: Text(
                                        "You can buy pipes from this App in different categories such as plastic, copper, iron and steel.",
                                        textAlign: TextAlign.center,
                                        style: STextStyle.semiBold600Grey12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 50.sp,
                                ),
                                Container(
                                    height: 195.sp,
                                    width: 250.sp,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 15.sp,
                                    ),
                                    decoration: BoxDecoration(
                                        color: SColorPicker.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black12,
                                              spreadRadius: 0.5,
                                              blurRadius: 1),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(10.sp)),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(10.sp),
                                      child: SvgPicture.asset(
                                          "${SImagePick.onBoarding2}"),
                                    )),
                                SizedBox(
                                  height: 30.sp,
                                ),
                                Text(
                                  "List products and sell now",
                                  textAlign: TextAlign.center,
                                  style: STextStyle.semiBold600Purple16,
                                ),
                                SizedBox(
                                  height: 20.sp,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 30.sp, right: 30.sp),
                                  child: Text(
                                    "You can sell pipes by this App in different categories such as plastic, copper, iron and steel.",
                                    textAlign: TextAlign.center,
                                    style: STextStyle.semiBold600Grey12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        2,
                        (index) => Padding(
                          padding: EdgeInsets.all(6.sp),
                          child: Container(
                              width: 10.sp,
                              height: 10.sp,
                              decoration: BoxDecoration(
                                color: controller.onBoardSwipe == index
                                    ? SColorPicker.black
                                    : SColorPicker.white,
                                border: Border.all(
                                  color: SColorPicker.black,
                                  width: 1.5.sp,
                                ),
                                shape: BoxShape.circle,
                              )),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.sp),
                      child: SCommonButton().sCommonPurpleButton(
                          name: 'Skip and Get Started',
                          onTap: () {
                            Get.offNamed(SRoutes.SPermissionScreen);
                            // Get.off('SPermissionScreen');
                            print('hello');
                          }),
                    ),
                    SizedBox(height: 10.h),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
