import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../app_constant/app_colors.dart';
import '../custom_widget/widgets/custom_widget/custom_text.dart';

class ChatMessagePage extends StatelessWidget {
  const ChatMessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      child: Image.asset(
                        'assets/images/cat_1.png',
                        width: 50.sp,
                        height: 50.sp,
                        fit: BoxFit.fill,
                      ),
                      backgroundColor: AppColors.offWhiteColor,
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        width: 10.sp,
                        height: 10.sp,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: Get.width * 0.05),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      alignment: Alignment.center,
                      text: 'Jan Doe',
                      fontWeight: FontWeight.w500,
                      fontSize: 22,
                      color: AppColors.commonWhiteTextColor,
                    ),
                    CustomText(
                      alignment: Alignment.center,
                      text: 'Online',
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Colors.green,
                    ),
                  ],
                ),
              ],
            ),
            Container(
              width: 35.sp,
              height: 35.sp,
              // padding: EdgeInsets,
              decoration: BoxDecoration(
                color: AppColors.commonWhiteTextColor,
                borderRadius: BorderRadius.circular(8.sp),
                border: Border.all(color: AppColors.hintTextColor, width: 2.sp),
              ),
              child: TextButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.call,
                    color: AppColors.secondaryBlackColor,
                  )),
            )
          ],
        ),
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: Get.height * 0.1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.all(Get.width * 0.05),
            child: Column(
              children: [
                Text('Today'),
                Container(
                  width: Get.width,
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        height: Get.height * 0.06,
                        width: Get.width * 0.3,
                        child: const Text(
                          'Hii',
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColors.offLightPurpalColor,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.sp),
                                bottomRight: Radius.circular(10.sp),
                                topLeft: Radius.circular(10.sp))),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.sp),
                        child: Text(
                          '01:00',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: Get.width,
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.sp),
                        height: Get.height * 0.06,
                        width: Get.width * 0.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.check),
                            Text(
                              'Hii',
                            ),
                            SizedBox(),
                          ],
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColors.lightBlackColor,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.sp),
                                bottomLeft: Radius.circular(10.sp),
                                topLeft: Radius.circular(10.sp))),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.sp),
                        child: Text(
                          '01:05',
                        ),
                      ),
                    ],
                  ),
                ),
                // Container(
                //   alignment: Alignment.topRight,
                //   child: Column(
                //     children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.end,
                //         children: [
                //           Icon(Icons.check),
                //           Container(
                //             padding: EdgeInsets.symmetric(horizontal: 50),
                //             height: 50,
                //             width: 200,
                //             child: const Text(
                //               'Hii',
                //             ),
                //             alignment: Alignment.center,
                //             decoration: BoxDecoration(
                //                 color: AppColors.lightBlackColor,
                //                 borderRadius: const BorderRadius.only(
                //                     topLeft: Radius.circular(20),
                //                     bottomRight: Radius.circular(20))),
                //           )
                //         ],
                //       ),
                //       Container(
                //         padding: const EdgeInsets.symmetric(horizontal: 20),
                //         height: 50,
                //         width: 200,
                //         child: const Text(
                //           '01:00',
                //         ),
                //         alignment: Alignment.centerRight,
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
          Container(
            height: 100,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextField(
              decoration: InputDecoration(
                fillColor: AppColors.offWhiteColor,
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    width: 3,
                    color: AppColors.offLightPurpalColor,
                    style: BorderStyle.solid,
                  ),
                ),
                hintText: 'Message...',
                hintStyle: TextStyle(color: AppColors.hintTextColor),
                prefixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.insert_link_outlined,
                      color: AppColors.primaryColor,
                    )),
                suffixIcon: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.send,
                        size: 21.sp, color: AppColors.primaryColor),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
