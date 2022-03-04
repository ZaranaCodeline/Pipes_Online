import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/view_model/b_help_center_controller.dart';
import 'package:pipes_online/seller/common/s_text_style.dart';
import 'package:sizer/sizer.dart';

import '../app_constant/app_colors.dart';
import '../custom_widget/widgets/custom_widget/custom_text.dart';

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
      // appBar: AppBar(
      //   //leading: Icon(Icons.arrow_back),
      //   title: Text(
      //     'HELP CENTER',
      //     style: STextStyle.bold700White14,
      //   ),
      //   centerTitle: true,
      //   backgroundColor: AppColors.primaryColor,
      //   toolbarHeight: Get.height * 0.1,
      //   shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.vertical(
      //       bottom: Radius.circular(25),
      //     ),
      //   ),
      // ),
      body: GetBuilder<BHelpCenterController>(
        builder: (controller) {
          return Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  Divider(
                    thickness: 2,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.sp,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'How can i cancel order?',
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                          color: AppColors.secondaryBlackColor,
                          textAlign: TextAlign.start,
                          alignment: Alignment.topLeft,
                        ),
                        IconButton(
                          icon: Icon(
                            controller.openSlide
                                ? Icons.keyboard_arrow_up_outlined
                                : Icons.keyboard_arrow_down_outlined,
                          ),
                          onPressed: () {
                            controller.setSlide();
                          },
                        ),
                      ],
                    ),
                  ),
                  // controller.openSlide
                  //     ? SizedBox(
                  //         height: 10.sp,
                  //       )
                  //     : SizedBox(),
                  controller.openSlide
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.sp,
                          ),
                          child: CustomText(
                              text:
                                  'Sofkkoog dkj fdjj fjf djijidf ijifjdi fijidj vfggf gfff ffgfg fdfd fidfji dfiif fdfh wiquiu aooiqw qkjq dfgfgf ffg gfg asaga ayha quidehgk fifjc ujyt.',
                              fontWeight: FontWeight.w400,
                              fontSize: 11.sp,
                              color: AppColors.secondaryBlackColor),
                        )
                      : SizedBox(),
                  controller.openSlide
                      ? SizedBox(
                          height: 5.sp,
                        )
                      : SizedBox(),
                  Divider(
                    thickness: 2,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'How can i cancel order?',
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                          color: AppColors.secondaryBlackColor,
                          textAlign: TextAlign.start,
                          alignment: Alignment.topLeft,
                        ),
                        IconButton(
                          icon: Icon(
                            controller.openSlide
                                ? Icons.keyboard_arrow_up_outlined
                                : Icons.keyboard_arrow_down_outlined,
                          ),
                          onPressed: () {
                            controller.setSlide();
                          },
                        ),
                      ],
                    ),
                  ),

                  controller.openSlide
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.sp,
                          ),
                          child: CustomText(
                              text:
                                  'Sofkkoog dkj fdjj fjf djijidf ijifjdi fijidj vfggf gfff ffgfg fdfd fidfji dfiif fdfh wiquiu aooiqw qkjq dfgfgf ffg gfg asaga ayha quidehgk fifjc ujyt.',
                              fontWeight: FontWeight.w400,
                              fontSize: 11.sp,
                              color: AppColors.secondaryBlackColor),
                        )
                      : SizedBox(),
                  controller.openSlide
                      ? SizedBox(
                          height: 10.sp,
                        )
                      : SizedBox(),
                  Divider(
                    thickness: 2,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
