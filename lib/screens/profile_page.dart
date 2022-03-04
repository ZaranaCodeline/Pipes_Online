import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../app_constant/app_colors.dart';
import '../custom_widget/widgets/custom_widget/custom_button.dart';
import '../custom_widget/widgets/custom_widget/custom_text.dart';
import 'get_started_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          alignment: Alignment.centerLeft,
          text: 'PROFILE',
          fontWeight: FontWeight.w700,
          fontSize: 18,
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
      body: SafeArea(
        child: CupertinoTextField(
          keyboardType: TextInputType.text,
          placeholder: 'Filtrar por nombre o nombre corto',
          placeholderStyle: const TextStyle(
            color: Color(0xffC4C6CC),
            fontSize: 14.0,
            fontFamily: 'Brutal',
          ),
          prefix: const Padding(
            padding:
            EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
            child: Icon(
              Icons.search,
              color: Color(0xffC4C6CC),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            color: Color(0xffF0F1F5),
          ),
        ),
      ),
    );
  }
}
