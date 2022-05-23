import 'package:flutter/material.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:sizer/sizer.dart';

import '../../app_constant/app_colors.dart';
import '../../app_constant/app_colors.dart';
import 'custom_text.dart';

class CommonCategoryCard extends StatefulWidget {
  CommonCategoryCard({Key? key, required this.image, required this.name})
      : super(key: key);

  String name;
  String image;

  @override
  State<CommonCategoryCard> createState() => _CommonCategoryCardState();
}

class _CommonCategoryCardState extends State<CommonCategoryCard> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('PRODUCT_NAME--${widget.name}');
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.sp),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(5.sp),
            // width: 130,
            decoration: BoxDecoration(
                color: AppColors.commonWhiteTextColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 1,
                    color: AppColors.hintTextColor,
                  )
                ]),
            child: Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.network(
                      '${widget.image}',
                      fit: BoxFit.fill,width: 30.sp,height: 30.sp,
                    ),
                    SizedBox(width: 10.sp),
                    CustomText(
                      text: widget.name,
                      color: SColorPicker.black,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      alignment: Alignment.centerRight,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
