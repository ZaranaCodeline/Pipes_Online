import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_constant/app_colors.dart';
import '../custom_widget/widgets/custom_widget/custom_navigationbar_items.dart';
import '../custom_widget/widgets/custom_widget/custom_text.dart';
import 'chat_message_page.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          alignment: Alignment.centerLeft,
          text: 'CHAT',
          fontWeight: FontWeight.w700,
          fontSize: 22,
          color: AppColors.commonWhiteTextColor,
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
          children: [
            SizedBox(
              height: Get.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                text: 'Messages',
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
                textAlign: TextAlign.start,
                alignment: Alignment.topLeft,
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: AppColors.primaryColor,
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            InkWell(
              onTap: (){
                Get.to(()=> ChatMessagePage());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            child: Image.asset(
                              'assets/images/cat_1.png',
                              width: 50,
                              height: 50,
                              fit: BoxFit.fill,
                            ),
                            backgroundColor: AppColors.offWhiteColor,
                          ),
                          Positioned(
                            right: 0,
                            child: Container(
                              width: 15,
                              height: 15,
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
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Column(
                        children: [
                          CustomText(
                              text: 'Jan Doe',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: AppColors.secondaryBlackColor),
                          CustomText(
                            text: 'Hii',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: AppColors.secondaryBlackColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Column(
                        children: [
                          CustomText(
                              text: '1 Minute ago',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: AppColors.secondaryBlackColor),
                          Stack(
                            children: [
                              Positioned(
                                right: 10,
                                top: 10,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                child: CustomText(
                                  text: '1',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.secondaryBlackColor,
                                ),
                                backgroundColor: AppColors.offWhiteColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: Get.width * 0.9,
              height: 1,
              color: AppColors.hintTextColor,
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          child: Image.asset(
                            'assets/images/cat_1.png',
                            width: 50,
                            height: 50,
                            fit: BoxFit.fill,
                          ),
                          backgroundColor: AppColors.offWhiteColor,
                        ),
                        Positioned(
                          right: 0,
                          child: Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        CustomText(
                            text: 'Jan Doe',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: AppColors.secondaryBlackColor),
                        CustomText(
                            text: 'Hii',
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            color: AppColors.secondaryBlackColor),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        CustomText(
                            text: '1 Minute ago',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: AppColors.secondaryBlackColor),
                        Stack(
                          children: [
                            Positioned(
                              right: 10,
                              top: 10,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                            CircleAvatar(
                              child: CustomText(
                                text: '1',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.secondaryBlackColor,
                              ),
                              backgroundColor: AppColors.offWhiteColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: Get.width * 0.9,
              height: 1,
              color: AppColors.hintTextColor,
            ),
          ],
        ),
      ),
    );
  }
}
