import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_constant/app_colors.dart';
import '../custom_widget/widgets/custom_widget/custom_text.dart';
import 'help_center_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          alignment: Alignment.centerLeft,
          text: 'SETTINGS',
          fontWeight: FontWeight.w700,
          fontSize: 22,
          color: AppColors.commonWhiteTextColor,
        ),
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: Get.height * 0.1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(height: Get.height * 0.02,),
                  CustomText(
                    text: 'Account',
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: AppColors.secondaryBlackColor,
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  TextField(
                    style: TextStyle(
                      color: AppColors.secondaryBlackColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                    // controller: _controller,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      hintText: 'Jan Doe',
                    ),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.05,),
              Column(
                children: [
                  CustomText(
                    text: 'Notifications',
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: AppColors.secondaryBlackColor,
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(width: 1, color: AppColors.hintTextColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                            text: 'App',
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: AppColors.secondaryBlackColor),
                        Switch(
                          onChanged: (value) {},
                          activeColor: Theme.of(context).primaryColor,
                          value: true,
                          inactiveThumbColor: AppColors.commonWhiteTextColor,
                          inactiveTrackColor: AppColors.primaryColor,
                          // ...
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: Get.height * 0.05,),
              Column(
                children: [
                  CustomText(
                    text: 'Get Help',
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: AppColors.secondaryBlackColor,
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  InkWell(
                    onTap: (){
                      Get.to(()=> HelpCenterPage());
                    },
                    child: TextField(
                      style: TextStyle(
                        color: AppColors.secondaryBlackColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                      // controller: _controller,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.help_outline,
                          color: AppColors.secondaryBlackColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        suffixIcon: Icon(Icons.arrow_forward_ios,color: AppColors.secondaryBlackColor,size: 15,),
                        hintText: 'Help Center',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.05,),
            ],
          ),
        ),
      ),
    );
  }
}
