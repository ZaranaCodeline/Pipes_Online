import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/seller/view_model/s_subscribe_controller.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';
import '../../../buyer/app_constant/app_colors.dart';
import '../../../buyer/screens/custom_widget/custom_text.dart';
import '../../../routes/bottom_controller.dart';
import '../../common/s_color_picker.dart';
import '../../common/s_common_button.dart';
import '../../view_model/s_add_product_controller.dart';

class SSimpleSubScribeScreen extends StatefulWidget {
  SSimpleSubScribeScreen({Key? key}) : super(key: key);

  @override
  State<SSimpleSubScribeScreen> createState() => _SSimpleSubScribeScreenState();
}

class _SSimpleSubScribeScreenState extends State<SSimpleSubScribeScreen> {
  String? radioValue;
  int? selectedRadioTile;
  String? selected;
  String? selectedTime;
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: Get.height * 0.05,
        ),
        CustomText(
            text: 'List your products',
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
                    text: list_time[0],
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
                      value = list_time[0] + ' ' + list_name[0];
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
                    text: list_time[1],
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
                      value = list_time[1] + ' ' + list_name[1];
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
                    text: list_time[2],
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
                      value = list_time[2] + ' ' + list_name[2];
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
              if (selected != null) {
                PreferenceManager.setSubscribeCategory('simple');
                PreferenceManager.setSubscribeTime(
                    '${addProductController.selectedSubscribe}');
                addProductController.selectedSubscribe = selected!;
                homeController.bottomIndex.value = 0;
                homeController.selectedScreen('SAddProductScreen');
              } else {
                Get.showSnackbar(GetSnackBar(
                  backgroundColor: SColorPicker.red,
                  duration: Duration(seconds: 2),
                  message: 'Please select one of above category!',
                ));
              }
              //Get.to(() => SAddProductScreen(selectedPrice:selected,));
              print('edit product seller side');
              // Get.toNamed(SRoutes.SSubmitProfileScreen);
            },
          ),
        )
      ],
    );
  }
}
