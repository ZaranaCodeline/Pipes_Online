import 'package:flutter/material.dart';

import '../../app_constant/app_colors.dart';
import '../widgets/custom_widget/custom_text.dart';

class CommonCategoryCard extends StatelessWidget {
  CommonCategoryCard({Key? key, required this.image, required this.name})
      : super(key: key);

  String name;
  String image;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            width: 130,
            decoration: BoxDecoration(
                color: AppColors.commonWhiteTextColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    color: AppColors.hintTextColor,
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(
                    '$image',
                    fit: BoxFit.fill,
                  ),
                  CustomText(
                    text: name,
                    color: AppColors.secondaryBlackColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    alignment: Alignment.centerRight,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
