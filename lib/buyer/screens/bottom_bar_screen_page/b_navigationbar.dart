import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/screens/b_chat_screen.dart';
import 'package:pipes_online/buyer/screens/b_personal_info_page.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/widget/b_cart_bottom_bar_route.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/widget/b_chat_bottom_bar_route.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/widget/b_home_bottom_bar_route.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/widget/b_personal_info_bottom_bar_route.dart';
import 'package:pipes_online/buyer/screens/b_cart_page.dart';
import 'package:pipes_online/buyer/screens/b_home_screen_widget.dart';
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
          backgroundColor: AppColors.commonWhiteTextColor.withOpacity(1),
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
                  height: Get.height * 0.06,
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
                  ),
                ))),
      );
    });

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
