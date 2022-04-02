import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../buyer/app_constant/app_colors.dart';
import '../../../buyer/custom_widget/widgets/custom_text.dart';
import '../../common/s_common_button.dart';
import '../../controller/s_subscribe_controller.dart';
import 's_add_product_screen.dart';

class SPlusSubscribeScreen extends StatefulWidget {
    SPlusSubscribeScreen({Key? key}) : super(key: key);

  @override
  State<SPlusSubscribeScreen> createState() => _SPlusSubscribeScreenState();
}

class _SPlusSubscribeScreenState extends State<SPlusSubscribeScreen> {
  String? radioValue;

  int? selectedRadioTile;

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile;
      selectedRadioTile = val;
    });
  }

  void setRadioValue(val) {
    radioValue = val;
    print('radioValue---: $radioValue');
    // update();
  }

  SSubScribeController controller = Get.put(SSubScribeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: Get.height * 0.05,
          ),
          CustomText(
              text: 'List your products and Get \n  contact details of buyer',
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
              color: AppColors.secondaryBlackColor),
          SizedBox(
            height: Get.height * 0.05,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: Get.width / 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: selectedRadioTile == 0
                      ? AppColors.primaryColor
                      : AppColors.commonWhiteTextColor,
                ),
                child: RadioListTile(
                    selectedTileColor: AppColors.commonWhiteTextColor,
                    value: 0,
                    activeColor: selectedRadioTile == 0
                        ? AppColors.commonWhiteTextColor
                        : AppColors.primaryColor,
                    groupValue: selectedRadioTile,
                    title: CustomText(
                      text: '1 year',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: selectedRadioTile == 0
                          ? AppColors.commonWhiteTextColor
                          : AppColors.primaryColor,
                    ),
                    secondary: CustomText(
                      text: '\$ 100/Yr',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: selectedRadioTile == 0
                          ? AppColors.commonWhiteTextColor
                          : AppColors.primaryColor,
                    ),
                    onChanged: (value) {
                      print('Radio tile pressed $value');
                      setState(() {
                        selectedRadioTile = value as int?;
                      });
                    }),
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              Container(
                width: Get.width / 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: selectedRadioTile == 1  ? AppColors.primaryColor
                      : AppColors.commonWhiteTextColor
                  ,
                ),
                child: RadioListTile(
                    selectedTileColor: AppColors.commonWhiteTextColor,
                    value: 1,
                    activeColor: selectedRadioTile == 1 ? AppColors.commonWhiteTextColor
                        : AppColors.primaryColor,
                    groupValue: selectedRadioTile,
                    title: CustomText(
                      text: '1 year',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: selectedRadioTile == 1
                          ? AppColors.commonWhiteTextColor
                          : AppColors.primaryColor,
                    ),
                    secondary: CustomText(
                      text: '\$ 100/Yr',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: selectedRadioTile == 1
                          ? AppColors.commonWhiteTextColor
                          : AppColors.primaryColor,
                    ),
                    onChanged: (value) {
                      print('Radio tile pressed $value');
                      setState(() {
                        selectedRadioTile = value as int?;
                      });
                    }),
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              Container(
                width: Get.width / 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: selectedRadioTile == 2
                      ? AppColors.primaryColor
                      : AppColors.commonWhiteTextColor,
                ),
                child: RadioListTile(
                    selectedTileColor: AppColors.commonWhiteTextColor,
                    value: 2,
                    activeColor: selectedRadioTile == 2
                        ? AppColors.commonWhiteTextColor
                        : AppColors.primaryColor,
                    groupValue: selectedRadioTile,
                    title: CustomText(
                      text: '1 year',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: selectedRadioTile == 2
                          ? AppColors.commonWhiteTextColor
                          : AppColors.primaryColor,
                    ),
                    secondary: CustomText(
                      text: '\$ 100/Yr',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: selectedRadioTile == 2
                          ? AppColors.commonWhiteTextColor
                          : AppColors.primaryColor,
                    ),
                    onChanged: (value) {
                      print('Radio tile pressed $value');
                      setState(() {
                        selectedRadioTile = value as int?;
                      });
                    }),
              ),
            ],
          ),
          SizedBox(
            height: Get.height * 0.1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.sp, horizontal: 40.sp),
            child: SCommonButton().sCommonPurpleButton(
              name: 'Subscribe Now',
              onTap: () {
                Get.to(() => SAddProductScreen());
                print('edit product seller side');
                // Get.toNamed(SRoutes.SSubmitProfileScreen);
              },
            ),
          )
        ],
      ),);
  }
}
