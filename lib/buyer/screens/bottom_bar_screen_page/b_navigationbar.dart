import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/screens/b_chat_screen.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/widget/cart_bottom_bar_route.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/widget/chat_bottom_bar_route.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/widget/home_bottom_bar_route.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/widget/personal_info_bottom_bar_route.dart';
import 'package:pipes_online/buyer/screens/b_cart_page.dart';
import 'package:pipes_online/buyer/screens/b_home_screen_widget.dart';
import 'package:pipes_online/buyer/screens/b_personal_info_page.dart';
import 'package:pipes_online/buyer/view_model/b_bottom_bar_controller.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  _BottomNavigationBarScreenState createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  BBottomBarIndexController bottomBarIndexController =
      Get.put(BBottomBarIndexController());

  var data = [];

  List<Widget> tabPages = [
    CatelogeHomeWidget(),
    CartPage(),
    BChatScreen(),
    PersonalInfoPage(),
  ];
  List<Map<String, dynamic>> bottomBarData = [
    {
      "Icon": Icons.border_all_outlined,
    },
    {
      "Icon": Icons.shopping_cart_outlined,
    },
    {
      "Icon": Icons.chat_bubble_outline,
    },
    {
      "Icon": Icons.person_outline,
    },
  ];


  @override
  Widget build(BuildContext context) {
    print('yeessss');
    return Obx(() {
      return SafeArea(
        child: Scaffold(
            body: bottomBarIndexController.selectedScreen.value != ''
                ? bottomBarIndexController.bottomIndex.value == 0
                ? homeSubScreen()
                : bottomBarIndexController.bottomIndex.value == 1
                ? cartSubScreen()
                : bottomBarIndexController.bottomIndex.value == 2
                ? chatSubScreen()
                : personalInfoSubScreen()
                : tabPages[bottomBarIndexController.bottomIndex.value],
            bottomNavigationBar: BottomAppBar(
                elevation: 0,
                color: Colors.transparent,
                child: Container(
                  height: Get.height * 0.08,
                  width: Get.width,
                  decoration: BoxDecoration(
                      // color: CommonColor.grey,
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(Get.height * 0.02))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: bottomBarData
                        .map((e) => InkResponse(
                              onTap: () {
                                onTabTapped(bottomBarData.indexOf(e));
                                // print(
                                //     'value----${bottomBarIndexController.bottomIndex.value}');
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Icon(
                                  e['Icon'],
                                  color: bottomBarIndexController
                                              .bottomIndex.value ==
                                          bottomBarData.indexOf(e)
                                      ? AppColors.primaryColor
                                      : AppColors.offLightPurpalColor,
                                ),
                              ),
                            ))
                        .toList(),
                    // children: [
                    //   InkWell(
                    //     onTap: () {
                    //       controller.setSelectedScreen(value: 1);
                    //     },
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Icon(
                    //           Icons.home,
                    //           color: controller.bottomIndex == 1
                    //               ? CommonColor.white
                    //               : CommonColor.black,
                    //         ),
                    //         Text(
                    //           'Home',
                    //           style: TextStyle(
                    //             color: controller.index == 1
                    //                 ? CommonColor.white
                    //                 : CommonColor.black,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    //   InkWell(
                    //     onTap: () {
                    //       controller.setIndexBottomBar(value: 2);
                    //     },
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Icon(
                    //           Icons.folder_shared_outlined,
                    //           color: controller.index == 2
                    //               ? CommonColor.white
                    //               : CommonColor.black,
                    //         ),
                    //         Text(
                    //           'Folder',
                    //           style: TextStyle(
                    //             color: controller.index == 2
                    //                 ? CommonColor.white
                    //                 : CommonColor.black,
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //   ),
                    //   InkWell(
                    //     onTap: () {
                    //       controller.setIndexBottomBar(value: 3);
                    //     },
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Icon(
                    //           Icons.person_pin,
                    //           color: controller.index == 3
                    //               ? CommonColor.white
                    //               : CommonColor.black,
                    //         ),
                    //         Text('Account',
                    //             style: TextStyle(
                    //               color: controller.index == 3
                    //                   ? CommonColor.white
                    //                   : CommonColor.black,
                    //             ))
                    //       ],
                    //     ),
                    //   ),
                    //   InkWell(
                    //     onTap: () {
                    //       controller.setIndexBottomBar(value: 4);
                    //     },
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Icon(
                    //           Icons.contact_support_rounded,
                    //           color: controller.index == 4
                    //               ? CommonColor.white
                    //               : CommonColor.black,
                    //         ),
                    //         Text('Support',
                    //             style: TextStyle(
                    //               color: controller.index == 4
                    //                   ? CommonColor.white
                    //                   : CommonColor.black,
                    //             ))
                    //       ],
                    //     ),
                    //   )
                    // ],
                  ),
                ))),
      );
    });

    // return GetBuilder<BottomBarIndexController>(
    //   builder: (controller) {
    //     return Scaffold(
    //         body: controller.selectedScreen.value != ''
    //             ? controller.bottomIndex.value == 0
    //                 ? homeSubScreen()
    //                 : controller.bottomIndex.value == 1
    //                     ? folderSubScreen()
    //                     : controller.bottomIndex.value == 2
    //                         ? accountSubScreen()
    //                         : supportSubScreen()
    //             : tabPages[controller.bottomIndex.value],
    //         bottomNavigationBar: BottomAppBar(
    //             child: Container(
    //           height: Get.height * 0.08,
    //           width: Get.width,
    //           color: CommonColor.grey,
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceAround,
    //             children: bottomBarData
    //                 .map((e) => InkResponse(
    //                       onTap: () {
    //                         onTabTapped(bottomBarData.indexOf(e));
    //                         print('----e-----$e');
    //                       },
    //                       child: Padding(
    //                         padding: const EdgeInsets.symmetric(vertical: 5),
    //                         child: Column(
    //                           mainAxisSize: MainAxisSize.min,
    //                           children: [
    //                             // Expanded(
    //                             //     child: SvgPicture.asset(
    //                             //   e["Icon"],
    //                             //   color: homeController.bottomIndex.value ==
    //                             //           bottomBarData.indexOf(e)
    //                             //       ? ColorPicker.yellow
    //                             //       : Colors.grey,
    //                             // )),
    //
    //                             Icon(
    //                               e['Icon'],
    //                               color: bottomBarIndexController
    //                                           .bottomIndex.value ==
    //                                       bottomBarData.indexOf(e)
    //                                   ? CommonColor.white
    //                                   : CommonColor.black,
    //                             ),
    //
    //                             // Expanded(
    //                             //   child: Image(
    //                             //     image: AssetImage(e["Icon"]),
    //                             //     color: homeController.bottomIndex.value ==
    //                             //             bottomBarData.indexOf(e)
    //                             //         ? ColorPicker.yellow
    //                             //         : Colors.grey,
    //                             //   ),
    //                             // ),
    //                             SizedBox(
    //                               height: 2,
    //                             ),
    //                             Text(
    //                               e["title"],
    //                               style: TextStyle(
    //                                 color: bottomBarIndexController
    //                                             .bottomIndex.value ==
    //                                         bottomBarData.indexOf(e)
    //                                     ? CommonColor.white
    //                                     : CommonColor.black,
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ))
    //                 .toList(),
    //             // children: [
    //             //   InkWell(
    //             //     onTap: () {
    //             //       controller.setSelectedScreen(value: 1);
    //             //     },
    //             //     child: Column(
    //             //       mainAxisAlignment: MainAxisAlignment.center,
    //             //       children: [
    //             //         Icon(
    //             //           Icons.home,
    //             //           color: controller.bottomIndex == 1
    //             //               ? CommonColor.white
    //             //               : CommonColor.black,
    //             //         ),
    //             //         Text(
    //             //           'Home',
    //             //           style: TextStyle(
    //             //             color: controller.index == 1
    //             //                 ? CommonColor.white
    //             //                 : CommonColor.black,
    //             //           ),
    //             //         ),
    //             //       ],
    //             //     ),
    //             //   ),
    //             //   InkWell(
    //             //     onTap: () {
    //             //       controller.setIndexBottomBar(value: 2);
    //             //     },
    //             //     child: Column(
    //             //       mainAxisAlignment: MainAxisAlignment.center,
    //             //       children: [
    //             //         Icon(
    //             //           Icons.folder_shared_outlined,
    //             //           color: controller.index == 2
    //             //               ? CommonColor.white
    //             //               : CommonColor.black,
    //             //         ),
    //             //         Text(
    //             //           'Folder',
    //             //           style: TextStyle(
    //             //             color: controller.index == 2
    //             //                 ? CommonColor.white
    //             //                 : CommonColor.black,
    //             //           ),
    //             //         )
    //             //       ],
    //             //     ),
    //             //   ),
    //             //   InkWell(
    //             //     onTap: () {
    //             //       controller.setIndexBottomBar(value: 3);
    //             //     },
    //             //     child: Column(
    //             //       mainAxisAlignment: MainAxisAlignment.center,
    //             //       children: [
    //             //         Icon(
    //             //           Icons.person_pin,
    //             //           color: controller.index == 3
    //             //               ? CommonColor.white
    //             //               : CommonColor.black,
    //             //         ),
    //             //         Text('Account',
    //             //             style: TextStyle(
    //             //               color: controller.index == 3
    //             //                   ? CommonColor.white
    //             //                   : CommonColor.black,
    //             //             ))
    //             //       ],
    //             //     ),
    //             //   ),
    //             //   InkWell(
    //             //     onTap: () {
    //             //       controller.setIndexBottomBar(value: 4);
    //             //     },
    //             //     child: Column(
    //             //       mainAxisAlignment: MainAxisAlignment.center,
    //             //       children: [
    //             //         Icon(
    //             //           Icons.contact_support_rounded,
    //             //           color: controller.index == 4
    //             //               ? CommonColor.white
    //             //               : CommonColor.black,
    //             //         ),
    //             //         Text('Support',
    //             //             style: TextStyle(
    //             //               color: controller.index == 4
    //             //                   ? CommonColor.white
    //             //                   : CommonColor.black,
    //             //             ))
    //             //       ],
    //             //     ),
    //             //   )
    //             // ],
    //           ),
    //         )));
    //   },
    // );
  }

  void onTabTapped(int index) {
    bottomBarIndexController.bottomIndex.value = index;

    if (index == 0) {
      bottomBarIndexController.selectedScreen('HomeScreen');
    }
    if (index == 1) {
      bottomBarIndexController.selectedScreen('CartPage');
    }
    if (index == 2) {
      bottomBarIndexController.selectedScreen('ChatPage');
    }
    if (index == 3) {
      bottomBarIndexController.selectedScreen('PersonalInfoPage');
    }
  }
}
