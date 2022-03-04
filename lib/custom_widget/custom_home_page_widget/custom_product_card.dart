import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/custom_widget/widgets/custom_widget/custom_text.dart';

import '../../app_constant/app_colors.dart';

class CustomProductCard extends StatelessWidget {
  CustomProductCard(
      {Key? key,
      required this.title,
      required this.desc,
      required this.img,
      required this.price})
      : super(key: key);
  String title;
  String price;
  String desc;
  Image img;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        width: 160,
        height: 450,
        decoration: BoxDecoration(
            color: AppColors.commonWhiteTextColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                color: AppColors.hintTextColor,
              )
            ]),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                img,
                SizedBox( height: Get.height * 0.01,),
                CustomText(text: title, fontWeight: FontWeight.w700, fontSize: 16, color: AppColors.primaryColor,alignment: Alignment.centerLeft,),
               SizedBox( height: Get.height * 0.01,),
                CustomText(text: desc, fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.secondaryBlackColor,alignment: Alignment.centerLeft,),
                SizedBox( height: Get.height * 0.01,),
                CustomText(text: price, fontWeight: FontWeight.w700, fontSize: 18, color: AppColors.secondaryBlackColor,alignment: Alignment.centerLeft,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
