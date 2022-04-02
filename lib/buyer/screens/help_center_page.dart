import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/view_model/b_help_center_controller.dart';
import 'package:pipes_online/seller/common/s_text_style.dart';
import 'package:sizer/sizer.dart';

import '../app_constant/app_colors.dart';
import '../custom_widget/widgets/custom_text.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({Key? key}) : super(key: key);

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  BHelpCenterController bHelpCenterController =
      Get.put(BHelpCenterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
      body: GetBuilder<BHelpCenterController>(
        builder: (controller) {
          return Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ExpansionTile(
                      iconColor: AppColors.secondaryBlackColor,
                      children: [
                        ListTile(
                          title: Text(
                              'Sofkkoog dkj fdjj fjf djijidf ijifjdi fijidj vfggf gfff ffgfg\nfdfd fidfji dfiif fdfh wiquiu aooiqw qkjq dfgfgf ffg gfg\nasaga ayha quidehgk fifjc ujyt.'),
                        )
                      ],
                      title: Text('How can i cancel order?',
                          style:
                              TextStyle(color: AppColors.secondaryBlackColor))),
                  ExpansionTile(
                      iconColor: AppColors.secondaryBlackColor,
                      children: [
                        ListTile(
                          title: Text(
                              'Sofkkoog dkj fdjj fjf djijidf ijifjdi fijidj vfggf gfff ffgfg\nfdfd fidfji dfiif fdfh wiquiu aooiqw qkjq dfgfgf ffg gfg\nasaga ayha quidehgk fifjc ujyt.'),
                        )
                      ],
                      title: Text(
                        'How can i cancel order?',
                        style: TextStyle(color: AppColors.secondaryBlackColor),
                      ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
