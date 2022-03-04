import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../seller/common/s_text_style.dart';
import '../app_constant/app_colors.dart';
import '../buyer_common/b_image.dart';
import '../custom_widget/widgets/custom_widget/custom_text.dart';
import 'bottom_bar_screen_page/widget/home_bottom_bar_route.dart';
import 'payment_page.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String? dropdownValueSize;
  String? dropdownValueLength;
  String? dropdownValueWeight;
  String? dropdownValueOil;

  var items = [
    'select',
    '1 mm',
    '2 mm',
    '3 mm',
    '4 mm',
    '5 mm',
    '6 mm',
    '7 mm',
    '8 mm',
    '9 mm',
    '10 mm',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                if (bottomBarIndexController.bottomIndex.value == 1) {
                  bottomBarIndexController.setSelectedScreen(
                      value: 'HomeScreen');
                  bottomBarIndexController.bottomIndex.value = 0;
                } else {
                  Get.back();
                }
              },
              icon: Icon(Icons.arrow_back_rounded)),
          title: Text(
            'YOUR CART',
            style: STextStyle.bold700White14,
          ),
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          toolbarHeight: Get.height * 0.1,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25),
            ),
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15.0.sp),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.asset(
                                  BImagePick.cartIcon,
                                  fit: BoxFit.cover,
                                  height: Get.height / 5.sp,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 20.sp),
                                child: Column(
                                  children: [
                                    CustomText(
                                      text: 'Round',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.sp,
                                      color: AppColors.primaryColor,
                                      alignment: Alignment.topLeft,
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01.sp,
                                    ),
                                    CustomText(
                                      text: 'ABC Pipe',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12.sp,
                                      color: AppColors.secondaryBlackColor,
                                      alignment: Alignment.centerLeft,
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01.sp,
                                    ),
                                    CustomText(
                                      text: '\$10/ Feet',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12.sp,
                                      color: AppColors.secondaryBlackColor,
                                      alignment: Alignment.centerLeft,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                                child: Container(
                                  height: Get.height / 12.sp,
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
                                          BImagePick.deleteIcon
                                      ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                      CustomDropDownWidget(
                        keyName: 'Size :      ',
                        dropDownValue: dropdownValueSize,
                        onChange: (String? newValue) {
                          dropdownValueSize = newValue!;
                          print('dropdownValueSize:-$dropdownValueSize');
                          setState(() {});
                        },
                      ),
                      CustomDropDownWidget(
                        keyName: 'Length : ',
                        dropDownValue: dropdownValueLength,
                        onChange: (String? newValue) {
                          dropdownValueLength = newValue!;
                          print('dropdownValueLength:-$dropdownValueLength');
                          setState(() {});
                        },
                      ),
                      CustomDropDownWidget(
                        keyName: 'Weight :',
                        dropDownValue: dropdownValueWeight,
                        onChange: (String? newValue) {
                          dropdownValueWeight = newValue!;
                          print('dropdownValueWeight:-$dropdownValueWeight');
                          setState(() {});
                        },
                      ),
                      CustomDropDownWidget(
                        keyName: 'Oil :        ',
                        dropDownValue: dropdownValueOil,
                        onChange: (String? newValue) {
                          dropdownValueOil = newValue!;
                          print('dropdownValueOil:-$dropdownValueOil');
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15.sp),
                        child: Column(
                          children: [
                            CustomText(
                              text: 'Address : ',
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: AppColors.secondaryBlackColor,
                              alignment: Alignment.topLeft,
                            ),
                            SizedBox(
                              height: Get.height * 0.01.sp,
                            ),
                            const Card(
                              elevation: 4,
                              borderOnForeground: true,
                              child: TextField(
                                maxLines: 3,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  border: InputBorder.none,
                                ),
                                // minLines: 1,
                              ),
                            ),
                            Card(
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        CustomText(
                                            text: 'Cart total',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14.sp,
                                            color:
                                            AppColors.secondaryBlackColor),
                                        CustomText(
                                            text: '\$10',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14.sp,
                                            color:
                                            AppColors.secondaryBlackColor),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => PaymentWidget());
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: AppColors.primaryColor,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                        children: [
                                          CustomText(
                                              text: 'Checkout Now',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14.sp,
                                              color: AppColors
                                                  .commonWhiteTextColor),
                                          CustomText(
                                              text: 'Total: \$10',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14.sp,
                                              color: AppColors
                                                  .commonWhiteTextColor),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget CustomDropDownWidget(
      {String? keyName, dynamic onChange, String? dropDownValue}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.sp),
      child: Row(
        children: [
          CustomText(
              text: keyName!,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: AppColors.secondaryBlackColor),
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
                  hint: Text('Select'),
                  value: dropDownValue,
                  icon: Icon(
                    Icons.arrow_drop_down_outlined,
                    color: AppColors.secondaryBlackColor,
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
                  onChanged: onChange),
            ),
          ),
          // CustomDropDownWidget(),
        ],
      ),
    );
  }
}
