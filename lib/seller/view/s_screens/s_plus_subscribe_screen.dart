import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/routes/bottom_controller.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:pipes_online/seller/view_model/s_add_product_controller.dart';
import 'package:pipes_online/seller/view_model/s_subscribe_controller.dart';
import 'package:sizer/sizer.dart';
import '../../../buyer/app_constant/app_colors.dart';
import '../../../buyer/screens/custom_widget/custom_text.dart';
import '../../../shared_prefarence/shared_prefarance.dart';
import '../../common/s_common_button.dart';

class SPlusSubscribeScreen extends StatefulWidget {
  SPlusSubscribeScreen({Key? key}) : super(key: key);

  @override
  State<SPlusSubscribeScreen> createState() => _SPlusSubscribeScreenState();
}

class _SPlusSubscribeScreenState extends State<SPlusSubscribeScreen> {
  String? radioValue;
  int? selectedRadioTile;
  String? selected;
  BottomController homeController = Get.find();
  AddProductController addProductController = Get.put(AddProductController());

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile;
      selectedRadioTile = val;
      print('VALUE  ${val}');
    });
  }

  void setRadioValue(val) {
    radioValue = val;
    print('radioValue---: $radioValue');
    // update();
  }

  List<dynamic> list_name = ['\$ 100/yr', '\$ 75/6/Mo', '\$15/30/d'];
  List<dynamic> list_time = ['1 year', '6 monthes', '30 Days'];
  SSubScribeController controller = Get.put(SSubScribeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
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
                      text: '${list_time[0]}',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: selectedRadioTile == 0
                          ? AppColors.commonWhiteTextColor
                          : AppColors.primaryColor,
                    ),
                    secondary: CustomText(
                      text: '${list_name[0]}',
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
                        value = list_name[0] + ' ' + list_time[0];
                        ;
                        selected = value as String;
                        print('Radio tile pressed $selected');
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
                  color: selectedRadioTile == 1
                      ? AppColors.primaryColor
                      : AppColors.commonWhiteTextColor,
                ),
                child: RadioListTile(
                    selectedTileColor: AppColors.commonWhiteTextColor,
                    value: 1,
                    activeColor: selectedRadioTile == 1
                        ? AppColors.commonWhiteTextColor
                        : AppColors.primaryColor,
                    groupValue: selectedRadioTile,
                    title: CustomText(
                      text: '${list_time[1]}',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: selectedRadioTile == 1
                          ? AppColors.commonWhiteTextColor
                          : AppColors.primaryColor,
                    ),
                    secondary: CustomText(
                      text: '${list_name[1]}',
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
                        value = list_name[1] + ' ' + list_time[1];
                        selected = value as String;
                        print('Radio tile pressed $selected');
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
                      text: '${list_time[2]}',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: selectedRadioTile == 2
                          ? AppColors.commonWhiteTextColor
                          : AppColors.primaryColor,
                    ),
                    secondary: CustomText(
                      text: '${list_name[2]}',
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
                        value = list_name[2] + ' ' + list_time[2];
                        ;
                        selected = value as String;
                        print('Radio tile pressed $selected');
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
                print('edit product seller side');
                if (selected != null) {
                  PreferenceManager.setSubscribeCategory('plus');
                  print(
                      '===PLUS=selectedPrice==${addProductController.selectedPrice}');
                  print(
                      '===PLUS=selectedSubscribe==${addProductController.selectedSubscribe}');
                  PreferenceManager.setSubscribeTime(
                      '${addProductController.selectedSubscribe}');
                  addProductController.selectedPrice = selected!;
                  homeController.bottomIndex.value = 0;
                  homeController.selectedScreen('SAddProductScreen');
                } else {
                  Get.showSnackbar(GetSnackBar(
                    backgroundColor: SColorPicker.red,
                    duration: Duration(seconds: 2),
                    message: 'Please select one of above category!',
                  ));
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
