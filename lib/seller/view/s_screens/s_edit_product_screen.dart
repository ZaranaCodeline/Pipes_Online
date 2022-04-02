import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/custom_widget/widgets/custom_text.dart';
import 'package:pipes_online/seller/view/s_screens/s_add_product_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../buyer/app_constant/app_colors.dart';
import '../../common/s_common_button.dart';
import '../../common/s_text_style.dart';

class SeditProductScreen extends StatelessWidget {
  SeditProductScreen({Key? key}) : super(key: key);
  String dropdownvalue = 'Plastic';
  var items = [
    'Plastic',
    'Coper 1',
    'Coper 2',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'EDIT PRODUCT',
          style: STextStyle.bold700White14,
        ),
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: Get.height * 0.1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
      ),
      backgroundColor: AppColors.backGroudColor,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 5.sp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.sp),
                margin:
                    EdgeInsets.symmetric(vertical: 5.sp),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColors.primaryColor.withOpacity(0.3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: SvgPicture.asset('assets/images/svg/camera.svg',color: AppColors.primaryColor,),
                      alignment: Alignment.center,
                    ),
                    Container(
                        alignment: Alignment.topLeft,
                        child: Image.asset('assets/images/png/pro_1.png')),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: 'Product Info',
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: AppColors.hintTextColor,
                        alignment: Alignment.topLeft,
                      ),
                      Container(
                        height: Get.height / 11.sp,
                        decoration: BoxDecoration(
                            color: AppColors.commonWhiteTextColor,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: [
                              new BoxShadow(
                                  blurRadius: 1,
                                  color: AppColors.hintTextColor),
                            ]),
                        child: TextButton(
                            onPressed: () {},
                            child: SvgPicture.asset(
                                'assets/images/svg/delete_icon.svg')),

                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                 Row(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     CustomText(
                         text: 'Category',
                         fontWeight: FontWeight.w600,
                         fontSize: 12.sp,
                         color: AppColors.secondaryBlackColor,
                         alignment: Alignment.topLeft),
                     SizedBox(
                       width: Get.width * 0.001,
                     ),
                     Container(
                       alignment: Alignment.topLeft,
                       child: SCustomDropDownWidget(),
                     ),
                   ],
                 ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  CustomText(
                    text: 'Product Name',
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AppColors.secondaryBlackColor,
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.sp, vertical: 0.sp),
                    alignment: Alignment.topLeft,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.commonWhiteTextColor),
                    child:  TextFormField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText:  ('ABX'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  CustomText(
                    text: 'Price (\$)/ Feet',
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AppColors.secondaryBlackColor,
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                 Container(
                   alignment: Alignment.center,
                   width: Get.width * 0.15,
                   padding: EdgeInsets.symmetric(
                       horizontal: 10.sp, vertical: 0.sp),
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       color: AppColors.commonWhiteTextColor),
                   child: TextFormField(
                     decoration: InputDecoration(
                       border: InputBorder.none,
                       focusedBorder: InputBorder.none,
                       enabledBorder: InputBorder.none,
                       errorBorder: InputBorder.none,
                       disabledBorder: InputBorder.none,
                       hintText:  ('100'),
                     ),
                   ),
                 ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  CustomText(
                    text: 'Description',
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AppColors.secondaryBlackColor,
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    width: Get.width * 5,
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.sp, vertical: 10.sp),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: AppColors.commonWhiteTextColor),
                    child: Container(
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter Address',
                        ),
                        maxLines: 5,
                        keyboardType: TextInputType.multiline,
                        // minLines: 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                ],
              ),
              Padding(
                padding:   EdgeInsets.symmetric(vertical: 15.sp,horizontal:  30.sp),
                child: SCommonButton().sCommonPurpleButton(
                  name: 'Edit Product',
                  onTap: () {
                    Get.to(() => SAddProductScreen());
                    print('edit product seller side');
                    // Get.toNamed(SRoutes.SSubmitProfileScreen);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget SCustomDropDownWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.sp),
      child: Row(
        children: [
          SizedBox(
            width: Get.width * .1,
          ),
          Card(
            elevation: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 5.sp,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(blurRadius: 1, color: AppColors.offWhiteColor),
                  ]),
              child: DropdownButton(
                value: dropdownvalue,
                icon: Icon(
                  Icons.arrow_drop_down_outlined,
                  color: AppColors.primaryColor,
                  size: 18.sp,
                ),
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: CustomText(
                      text: items,
                      color: AppColors.secondaryBlackColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      textDecoration: TextDecoration.none,
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  // setState(() {
                  //   dropdownvalue = newValue!;
                  // });
                },
              ),
            ),
          ),
          // CustomDropDownWidget(),
        ],
      ),
    );
  }
}
