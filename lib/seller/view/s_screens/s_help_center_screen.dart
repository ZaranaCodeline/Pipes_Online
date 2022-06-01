import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../buyer/app_constant/app_colors.dart';
import '../../common/s_text_style.dart';

class SHelpCenter extends StatelessWidget {
  const SHelpCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HELP CENTER',
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExpansionTile(
                  collapsedIconColor: AppColors.primaryColor,
                  collapsedTextColor: AppColors.primaryColor,
                  iconColor: AppColors.primaryColor,
                  children: [
                    ListTile(
                      title: Text(
                          'Sofkkoog dkj fdjj fjf djijidf ijifjdi fijidj vfggf gfff ffgfg\nfdfd fidfji dfiif fdfh wiquiu aooiqw qkjq dfgfgf ffg gfg\nasaga ayha quidehgk fifjc ujyt.'),
                    )
                  ],
                  title: Text('How can i cancel order?')),
              ExpansionTile(children: [
                ListTile(
                  title: Text(
                      'Sofkkoog dkj fdjj fjf djijidf ijifjdi fijidj vfggf gfff ffgfg\nfdfd fidfji dfiif fdfh wiquiu aooiqw qkjq dfgfgf ffg gfg\nasaga ayha quidehgk fifjc ujyt.'),
                )
              ], title: Text('How can i cancel order?'))
            ],
          ),
        ),
      ),
    );
  }
}
