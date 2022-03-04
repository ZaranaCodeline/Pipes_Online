import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/screens/chat_message_page.dart';
import 'package:pipes_online/seller/common/s_text_style.dart';
import 'package:pipes_online/seller/view/s_screens/s_chat_message_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../buyer/app_constant/app_colors.dart';
import '../../../buyer/buyer_common/b_image.dart';
import '../../../buyer/custom_widget/widgets/custom_widget/custom_text.dart';

class SChatScreen extends StatelessWidget {
  const SChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'CHAT',
            style: STextStyle.bold700White14,
          ),
          centerTitle: true,
          leading: BackButton(),
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
            children: [
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                child: CustomText(
                  text: 'Messages',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                  textAlign: TextAlign.start,
                  alignment: Alignment.topLeft,
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Divider(color: AppColors.primaryColor, thickness: 1.sp),
              InkWell(
                onTap: () {
                  // Get.to(() => ChatRoom());
                  Get.to(() => SChatMessagePage(uid: 'fd',name: 'Ditya',image: 'https://firebasestorage.googleapis.com/v0/b/pipesonline-b2a41.appspot.com/o/cat_1.png?alt=media&token=a8b761df-c503-466b-baf3-d4ef73d5650d'));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.05),
                            child: Container(
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    child: Image.asset(
                                      BImagePick.chatIcon,
                                      width: 50.sp,
                                      height: 50.sp,
                                      fit: BoxFit.fill,
                                    ),
                                    backgroundColor: AppColors.offWhiteColor,
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: Container(
                                      width: 10.sp,
                                      height: 10.sp,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    text: 'Jan Doe',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.sp,
                                    color: AppColors.secondaryBlackColor),
                                CustomText(
                                  text: 'Hii',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                  color: AppColors.secondaryBlackColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: Get.width * 0.4,
                        padding: EdgeInsets.only(right: Get.width * 0.05),
                        child: Column(
                          children: [
                            CustomText(
                                text: '1 Minute ago',
                                fontWeight: FontWeight.w600,
                                fontSize: 13.sp,
                                color: AppColors.secondaryBlackColor),
                            CircleAvatar(
                              radius: 8.sp,
                              child: Center(
                                child: CustomText(
                                  text: '1',
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.commonWhiteTextColor,
                                  fontSize: 10.sp,
                                ),
                              ),
                              backgroundColor: AppColors.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: AppColors.hintTextColor,
                thickness: 1.sp,
                indent: Get.width * 0.05,
                endIndent: Get.width * 0.05,
              ),
              InkWell(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.05),
                            child: Container(
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    child: Image.asset(
                                      BImagePick.chatIcon,
                                      width: 50.sp,
                                      height: 50.sp,
                                      fit: BoxFit.fill,
                                    ),
                                    backgroundColor: AppColors.offWhiteColor,
                                  ),
                                  // Positioned(
                                  //   right: 0,
                                  //   child: Container(
                                  //     width: 10.sp,
                                  //     height: 10.sp,
                                  //     decoration: BoxDecoration(
                                  //       borderRadius: BorderRadius.circular(50),
                                  //       color: Colors.green,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    text: 'Sam John',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.sp,
                                    color: AppColors.secondaryBlackColor),
                                CustomText(
                                  text: 'Hii',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                  color: AppColors.secondaryBlackColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: Get.width * 0.4,
                        padding: EdgeInsets.only(right: Get.width * 0.05),
                        child: Column(
                          children: [
                            CustomText(
                                text: '1h ago',
                                fontWeight: FontWeight.w600,
                                fontSize: 13.sp,
                                color: AppColors.secondaryBlackColor),
                            // CircleAvatar(
                            //   radius: 8.sp,
                            //   child: Center(
                            //     child: CustomText(
                            //       text: '1',
                            //       fontWeight: FontWeight.w600,
                            //       color: AppColors.commonWhiteTextColor,
                            //       fontSize: 10.sp,
                            //     ),
                            //   ),
                            //   backgroundColor: AppColors.primaryColor,
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: AppColors.hintTextColor,
                thickness: 1.sp,
                indent: Get.width * 0.05,
                endIndent: Get.width * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
