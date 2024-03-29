import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/routes/bottom_controller.dart';
import 'package:pipes_online/seller/bottombar/widget/category_bottom_bar_route.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:pipes_online/seller/view/s_screens/s_prosonal_info_page.dart';
import 'package:sizer/sizer.dart';
import '../view/s_screens/s_cateloge_home_screen.dart';
import '../view/s_screens/s_chat_screen.dart';
import '../view/s_screens/s_order_screen.dart';

class NavigationBarScreen extends StatefulWidget {
  @override
  _NavigationBarScreenState createState() => _NavigationBarScreenState();
}

class _NavigationBarScreenState extends State<NavigationBarScreen> {
  int _pageIndex = 0;
  BottomController homeController = Get.put(BottomController());
  List<Widget> tabPages = [
    SCatelogeHomeScreen(),
    SOrdersScreen(),
    SChatScreen(),
    SPersonalInfoPage(),
  ];
  List<Map<String, String>> bottomBarData = [
    {
      // "title": "Category",
      "Icon": "assets/images/svg/nav1_icon.svg",
    },
    {
      // "title": "Orders",
      "Icon": "assets/images/svg/nav2_icon.svg",
    },
    {
      // "title": "Chat",
      "Icon": "assets/images/svg/nav3_icon.svg",
    },
    {
      // "title": "User",
      "Icon": "assets/images/svg/nav_profile.svg",
    },
  ];

  @override
  void initState() {
    homeController.bottomIndex.value = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        return Scaffold(
            bottomNavigationBar: bottomNavigationBar(),
            body: Scaffold(
              body: Container(
                child: SafeArea(
                  child: homeController.selectedScreen.value != ''
                      ? homeController.bottomIndex.value == 0
                          ? categorySubScreen()
                          : homeController.bottomIndex.value == 1
                              ? SOrdersScreen()
                              : homeController.bottomIndex.value == 2
                                  ? SChatScreen()
                                  : SPersonalInfoPage()
                      : tabPages[homeController.bottomIndex.value],
                ),
              ),
            ));
      }),
    );
  }

  Container bottomNavigationBar() {
    return Container(
      height: Get.height * 0.06,
      width: Get.width,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: bottomBarData
            .map((e) => InkResponse(
                  onTap: () {
                    onTabTapped(bottomBarData.indexOf(e));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(
                          child: Container(
                    decoration: BoxDecoration(
                      color: SColorPicker.white,
                    /*  boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            spreadRadius: 0.5,
                            blurRadius: 1),
                      ],*/
                      borderRadius: BorderRadius.circular(10.sp),
                    ),
                            // decoration: BoxDecoration(
                            //     // color: AppColors.primaryColor
                            //     ),
                            child: SvgPicture.asset(
                              e["Icon"]!,
                              width: 15.sp,
                              height: 15.sp,
                              color: homeController.bottomIndex.value ==
                                      bottomBarData.indexOf(e)
                                  ? SColorPicker.purple
                                  : AppColors.offLightPurpalColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  void onTabTapped(int index) {
    homeController.bottomIndex.value = index;
    var milna = index;
    if (index == 0) {
      homeController.selectedScreen('SCatelogeHomeScreen');
    }
    if (index == 1) {
      homeController.selectedScreen('OrderScreen');
    }
    if (index == 2) {
      homeController.selectedScreen('ChatScreen');
    }
    if (index == 3) {
      homeController.selectedScreen('UserProfileScreen');
    }
  }
}
