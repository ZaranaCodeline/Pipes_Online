import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_constant/app_colors.dart';
import '../custom_widget/widgets/custom_widget/custom_text.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          alignment: Alignment.centerLeft,
          text: 'Help Center ',
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
            Divider(thickness: 2,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomText(
                text: 'How can i cancel order?',
                fontWeight: FontWeight.w600,
                fontSize: 25,
                color: AppColors.secondaryBlackColor,
                textAlign: TextAlign.start,
                alignment: Alignment.topLeft,
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomText(
                  text:
                  'Sofkkoog dkj fdjj fjf djijidf ijifjdi fijidj vfggf gfff ffgfg \nfdfd fidfji dfiif fdfh wiquiu aooiqw qkjq dfgfgf ffg gfg\nasaga ayha quidehgk fifjc ujyt.',
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: AppColors.secondaryBlackColor),
            ),
            SizedBox(
              height: Get.height * 0.05,
            ),
            Divider(thickness: 2,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomText(
                text: 'How can i cancel order?',
                fontWeight: FontWeight.w400,
                fontSize: 20,
                color: AppColors.secondaryBlackColor,
                textAlign: TextAlign.start,
                alignment: Alignment.topLeft,
              ),
            ),
            Divider(thickness: 2,),
            SizedBox(
              height: Get.height * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}
