import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/screens/cart_page.dart';
import 'package:sizer/sizer.dart';

import '../../app_constant/app_colors.dart';
import '../../screens/seller_review_widget.dart';
import '../widgets/custom_text.dart';

class CustomSelectedProductBuildTopWidget extends StatefulWidget {
  CustomSelectedProductBuildTopWidget(
      {Key? key,
      this.price,
      this.desc,
      this.name,
        this.category,
      this.image})
      : super(key: key);
  final String? name, image, desc, price,category;

  @override
  State<CustomSelectedProductBuildTopWidget> createState() => _CustomSelectedProductBuildTopWidgetState();
}

class _CustomSelectedProductBuildTopWidgetState extends State<CustomSelectedProductBuildTopWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CustomText(
            text: widget.name.toString(),
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
                  text: 'ABC',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  max: 1,
                  textOverflow: TextOverflow.ellipsis,
                  color: AppColors.secondaryBlackColor),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                    // width: Get.width * 0.5,
                    height: Get.height * 0.06,
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
                        SizedBox(width: Get.width * 0.01),
                        GestureDetector(
                          onTap: () {
                            print('CATEGORY${widget.category}');
                            Get.to(() => CartPage(category: widget.category,));
                          },
                          child: CustomText(
                            text: 'ADD TO CART',
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                            color: AppColors.commonWhiteTextColor,
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          CustomText(
            text: widget.price.toString(),
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
