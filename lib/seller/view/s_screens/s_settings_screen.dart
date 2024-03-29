import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../buyer/app_constant/app_colors.dart';
import '../../../buyer/screens/custom_widget/custom_text.dart';
import '../../../buyer/screens/help_center_page.dart';
import '../../common/s_text_style.dart';

class SSettingsScreen extends StatefulWidget {
  const SSettingsScreen({Key? key, this.name,this.img}) : super(key: key);
  final String? img,name;
  @override
  State<SSettingsScreen> createState() => _SSettingsScreenState();
}

class _SSettingsScreenState extends State<SSettingsScreen> {
  bool switchNotification = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroudColor,
      appBar: AppBar(
        title: Text(
          'SETTINGS',
          style: STextStyle.bold700White14,
        ),
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: Get.height * 0.1 ,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 15.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  CustomText(
                    text: 'Account',
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.secondaryBlackColor,
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Container(
                    height: Get.height * 0.07,
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.sp,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 1, color: AppColors.lightBlackColor),
                    ),
                    // alignment: Alignment.centerLeft,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(radius: 15.sp, child:Image.network(widget.img.toString()) ,),
                        SizedBox(width: 15.sp),
                        Flexible(
                          child: Container(
                            child: TextField(
                              style: TextStyle(
                                color: AppColors.secondaryBlackColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              // controller: _controller,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText:widget.name.toString(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              Column(
                children: [
                  CustomText(
                    text: 'Notifications',
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.secondaryBlackColor,
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Container(
                    height: Get.height * 0.07,
                    padding: EdgeInsets.symmetric(
                        horizontal: 10.sp, vertical: 10.sp),
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 1, color: AppColors.lightBlackColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            text: 'App',
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: AppColors.hintTextColor),
                        Switch(
                          onChanged: (value) {
                            setState(() {
                              switchNotification = value;
                            });
                            print('switchNotification:-$switchNotification');
                          },
                          focusColor: AppColors.primaryColor,
                          activeColor: AppColors.commonWhiteTextColor,
                          value: switchNotification,
                          activeTrackColor: AppColors.primaryColor,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              Column(
                children: [
                  CustomText(
                    text: 'Get Help',
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: AppColors.secondaryBlackColor,
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(() => HelpCenterPage());
                    },
                    child: Container(
                      height: Get.height * 0.07,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.sp, vertical: 10.sp),
                      decoration: BoxDecoration(
                        // color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 1, color: AppColors.lightBlackColor),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.help_outline,
                                  color: AppColors.secondaryBlackColor,
                                  size: 14.sp,
                                ),
                                SizedBox(width: 10.sp),
                                CustomText(
                                    text: 'Help Center',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                    color: AppColors.secondaryBlackColor),
                              ],
                            ),
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: AppColors.secondaryBlackColor,
                              size: 14.sp,
                            ),
                          ]),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Get.height * 0.05.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
