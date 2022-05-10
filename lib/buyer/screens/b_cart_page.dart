import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/seller/Authentication/s_function.dart';
import 'package:pipes_online/seller/view/s_screens/s_add_product_screen.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';

import '../../seller/common/s_text_style.dart';
import '../app_constant/app_colors.dart';
import '../app_constant/b_image.dart';
import 'custom_widget/custom_text.dart';
import 'bottom_bar_screen_page/widget/b_home_bottom_bar_route.dart';
import 'b_payment_page.dart';

class CartPage extends StatefulWidget {
  final String? name, image, desc, price, category, productID;

  const CartPage(
      {Key? key,
      this.price,
      this.desc,
      this.name,
      this.image,
      this.category,
      this.productID})
      : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String? dropdownValueSize;
  String? dropdownValueLength;
  String? dropdownValueWeight;
  String? dropdownValueOil;
  String? dropdownValueFootage;
  String? dropdownValueOD;
  String? dropdownValueWall;
  String? dropdownValueWTperft;
  String? dropdownValuePipeTagColor;

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
    print('widget.category================>${widget.category}');
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
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
                                  child: Image.network(
                                    widget.image.toString(),
                                    // BImagePick.cartIcon,
                                    fit: BoxFit.cover,
                                    height: Get.height / 5.sp,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 20.sp),
                                  child: Column(
                                    children: [
                                      CustomText(
                                        text: widget.name.toString(),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.sp,
                                        color: AppColors.primaryColor,
                                        alignment: Alignment.topLeft,
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.01.sp,
                                      ),
                                      CustomText(
                                        text: widget.desc.toString(),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.sp,
                                        color: AppColors.secondaryBlackColor,
                                        alignment: Alignment.centerLeft,
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.01.sp,
                                      ),
                                      CustomText(
                                        text: widget.price.toString(),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.sp,
                                        color: AppColors.secondaryBlackColor,
                                        alignment: Alignment.centerLeft,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
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
                        CustomDropDownWidget(
                          keyName: 'Footage:      ',
                          dropDownValue: dropdownValueFootage,
                          onChange: (String? newValue) {
                            dropdownValueFootage = newValue!;
                            print('dropdownValueSize:-$dropdownValueFootage');
                            setState(() {});
                          },
                        ),
                        CustomDropDownWidget(
                          keyName: 'O.D.:      ',
                          dropDownValue: dropdownValueOD,
                          onChange: (String? newValue) {
                            dropdownValueOD = newValue!;
                            print('dropdownValueSize:-$dropdownValueOD');
                            setState(() {});
                          },
                        ),
                        CustomDropDownWidget(
                          keyName: 'Wall:      ',
                          dropDownValue: dropdownValueWall,
                          onChange: (String? newValue) {
                            dropdownValueWall = newValue!;
                            print('dropdownValueSize:-$dropdownValueWall');
                            setState(() {});
                          },
                        ),
                        CustomDropDownWidget(
                          keyName: 'WT. per ft:      ',
                          dropDownValue: dropdownValueWTperft,
                          onChange: (String? newValue) {
                            dropdownValueWTperft = newValue!;
                            print('dropdownValueSize:-$dropdownValueWTperft');
                            setState(() {});
                          },
                        ),
                        widget.category == 'Gas' || widget.category == 'Oil'
                            ? CustomDropDownWidget(
                                keyName: 'Pipe Tag Color:      ',
                                dropDownValue: dropdownValuePipeTagColor,
                                onChange: (String? newValue) {
                                  dropdownValuePipeTagColor = newValue!;
                                  print(
                                      'dropdownValueSize:-$dropdownValuePipeTagColor');
                                  setState(() {});
                                },
                              )
                            : Container(),
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
                                elevation: 1,
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
                                              text: 'Cart total :',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.sp,
                                              color: AppColors
                                                  .secondaryBlackColor),
                                          CustomText(
                                              text: widget.price.toString(),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14.sp,
                                              color: AppColors
                                                  .secondaryBlackColor),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.to(() => Screen(
                                              price: widget.price,
                                            ));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColors.primaryColor,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            CustomText(
                                                text: 'Checkout Now : ',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14.sp,
                                                color: AppColors
                                                    .commonWhiteTextColor),
                                            CustomText(
                                                text: widget.price.toString(),
                                                fontWeight: FontWeight.w600,
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
