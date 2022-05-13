import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/seller/view/s_screens/s_common_button.dart';
import 'package:pipes_online/seller/view/s_screens/s_text_style.dart';
import 'package:pipes_online/seller/view_model/s_add_product_controller.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';

import '../../bottombar/widget/category_bottom_bar_route.dart';

class SShowSubcriptionValueScreen extends StatefulWidget {
  const SShowSubcriptionValueScreen({Key? key}) : super(key: key);

  @override
  State<SShowSubcriptionValueScreen> createState() =>
      _SShowSubcriptionValueScreenState();
}

class _SShowSubcriptionValueScreenState
    extends State<SShowSubcriptionValueScreen> {
  AddProductController addProductController = Get.put(AddProductController());

  String? formattedDateTime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PreferenceManager.getSubscribeTime();
    PreferenceManager.getSubscribeVal();
    print('-Stored-time-${PreferenceManager.getSubscribeTime()}');
    print('-Stored val--${PreferenceManager.getSubscribeVal()}');

    if (PreferenceManager.getSubscribeTime().toString().contains('1')) {
      print('year');
      formattedDateTime = DateFormat('yyyy-MM-dd')
          .format(DateTime.now().add(Duration(days: 365)));
    } else if (PreferenceManager.getSubscribeTime().toString().contains('6')) {
      print('month');
      formattedDateTime = DateFormat('yyyy-MM-dd')
          .format(DateTime.now().add(Duration(days: 180)));
    } else {
      formattedDateTime = DateFormat('yyyy-MM-dd')
          .format(DateTime.now().add(Duration(days: 30)));
      print('days');
    }
    ;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'subscribe'.toUpperCase(),
          style: STextStyle.bold700White14,
        ),
        leading: IconButton(
          onPressed: () {
            setState(() {
              homeController.bottomIndex.value = 0;
              homeController.selectedScreen('NavigationBarScreen');
            });
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: Get.height * 0.1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CustomText(
                  text: 'Current Subscription:',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: AppColors.secondaryBlackColor),
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
              margin: EdgeInsets.symmetric(horizontal: 15.sp),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.sp),
                  border: Border.all(
                      color: AppColors.hintTextColor.withOpacity(0.2))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomText(
                          text: PreferenceManager.getSubscribeCategory()
                              .toString(),
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          color: AppColors.secondaryBlackColor),
                      /* CustomText(
                          text: addProductController.selectedSubscribeTime,
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          color: AppColors.secondaryBlackColor),*/
                      CustomText(
                          text: PreferenceManager.getSubscribeTime().toString(),
                          fontWeight: FontWeight.w700,
                          fontSize: 14.sp,
                          color: AppColors.secondaryBlackColor),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.05,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomText(
                        text: 'Active',
                        fontWeight: FontWeight.w700,
                        fontSize: 12.sp,
                        color: Color(0xff0AA906),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 4.sp,
                            height: 4.sp,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.sp),
                              color: AppColors.secondaryBlackColor,
                            ),
                          ),
                          SizedBox(
                            width: Get.width * 0.05,
                          ),
                          CustomText(
                              text: 'Expires on ${formattedDateTime}',
                              fontWeight: FontWeight.w700,
                              fontSize: 14.sp,
                              color: AppColors.secondaryBlackColor),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Get.height * 0.01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30.sp, horizontal: 30.sp),
              child: SCommonButton().sCommonPurpleButton(
                name: 'Subscribe Now',
                onTap: () {
                  homeController.bottomIndex.value = 0;
                  homeController.selectedScreen('SAddProductScreen');
                  //Get.to(() => SAddProductScreen(selectedPrice:selected,));
                  print('SAddProductScreen');
                  // Get.toNamed(SRoutes.SSubmitProfileScreen);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
