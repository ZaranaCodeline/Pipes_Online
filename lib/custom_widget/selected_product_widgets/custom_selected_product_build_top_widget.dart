import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app_constant/app_colors.dart';
import '../widgets/custom_widget/custom_text.dart';

class CustomSelectedProductBuildTopWidget extends StatelessWidget {
    CustomSelectedProductBuildTopWidget(
      {Key? key,
      required this.price,
      required this.desc,
      required this.name,
      required this.image})
      : super(key: key);
  String name, image, desc, price;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CustomText(
            text: name,
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: AppColors.primaryColor,
            alignment: Alignment.topLeft,
          ),
          SizedBox(height: Get.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                  text: desc,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: AppColors.secondaryBlackColor),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: Get.width * 0.5,
                    height: Get.height * 0.08,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          color: AppColors.commonWhiteTextColor,
                        ),
                        CustomText(
                          text: 'ADD TO CART',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: AppColors.commonWhiteTextColor,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          CustomText(
            text: price,
            fontWeight: FontWeight.w600,
            fontSize: 20,
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
