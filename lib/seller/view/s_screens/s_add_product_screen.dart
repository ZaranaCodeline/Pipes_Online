import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pipes_online/seller/view/s_screens/s_edit_product_screen.dart';
import 'package:pipes_online/seller/view_model/add_product_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../buyer/app_constant/app_colors.dart';
import '../../../buyer/custom_widget/widgets/custom_text.dart';
import '../../common/s_common_button.dart';
import '../../common/s_text_style.dart';
import 's_subscribe_screen.dart';

class SAddProductScreen extends StatefulWidget {
    SAddProductScreen({Key? key}) : super(key: key);

  @override
  State<SAddProductScreen> createState() => _SAddProductScreenState();
}

class _SAddProductScreenState extends State<SAddProductScreen> {

  AddProductController addProductController = Get.put(AddProductController());

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
          'ADD PRODUCT',
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
                child: GetBuilder<AddProductController>(builder: (controller){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: (){
                          print('it is openable image');
                          showDialog(
                            context: context,
                            builder: (context) => SimpleDialog(
                              children: [
                                Container(
                                  height: 105.sp,
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      Container(
                                        child: MaterialButton(
                                          child: Text(
                                            'GALLERY',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.sp),
                                          ),
                                          onPressed: () {
                                            controller.getGalleryImage();
                                            Get.back();
                                          },
                                        ),
                                        width: 220,
                                        height: 50.sp,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                colors: [
                                                  AppColors.primaryColor,
                                                  AppColors.offLightPurpalColor,
                                                  AppColors.primaryColor,
                                                ]),
                                            borderRadius: BorderRadius.circular(25)),

                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        child: MaterialButton(
                                          child: Text(
                                            'camera',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                          onPressed: () {
                                            controller.getCamaroImage();
                                            Get.back();
                                          },
                                        ),
                                        width: 220,
                                        height: 50.sp,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                begin: Alignment.topLeft,
                                                colors: [
                                                  AppColors.primaryColor,
                                                  AppColors.offLightPurpalColor,
                                                  AppColors.primaryColor,
                                                ]),
                                            borderRadius: BorderRadius.circular(25)),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        child: Container(
                          child: SvgPicture.asset('assets/images/svg/camera.svg',color: AppColors.primaryColor,),
                          alignment: Alignment.center,
                        ),
                      ),
                      Container(
                          alignment: Alignment.topLeft,
                          child: addProductController.image != null
                              ? Container(
                            height: 100.sp,
                            width: 100.sp,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(10)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                controller.image!,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ):Image.asset('assets/images/png/pro_1.png')),
                    ],
                  );
                },),
              ),
              SizedBox(
                height: Get.height * 0.01,
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
                        // child: TextButton(
                        //     onPressed: () {},
                        //     child: SvgPicture.asset(
                        //         'assets/images/svg/delete_icon.svg')),

                      ),
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                          text: 'Category',
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
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
                    height: Get.height * 0.01,
                  ),
                  CustomText(
                    text: 'Product Name',
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AppColors.secondaryBlackColor,
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.sp, vertical: 0.sp),
                    alignment: Alignment.topLeft,
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
                        hintText:  ('ABX'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  CustomText(
                    text: 'Price (\$)/ Feet',
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AppColors.secondaryBlackColor,
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: Get.width * 0.15,
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.sp, vertical: 0.sp),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.commonWhiteTextColor),
                    child:TextFormField(
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
                    height: Get.height * 0.01,
                  ),
                  CustomText(
                    text: 'Description',
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AppColors.secondaryBlackColor,
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
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
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        // minLines: 1,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                ],
              ),
              Padding(
                padding:   EdgeInsets.symmetric(vertical: 15.sp,horizontal:  30.sp),
                child: SCommonButton().sCommonPurpleButton(
                  name: 'Add Product',
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
                  setState(() {
                    dropdownvalue = newValue!;
                  });
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
