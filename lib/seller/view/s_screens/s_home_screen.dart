import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/seller/view/s_screens/s_order_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_prosonal_info_page.dart';

import '../../../buyer/app_constant/app_colors.dart';
import '../../../buyer/screens/b_drawer_profile_page.dart';
import '../../../buyer/screens/b_personal_info_page.dart';
import '../../../routes/bottom_controller.dart';
import '../../bottombar/s_navigation_bar.dart';
import 's_cart_screen.dart';
import 's_cateloge_home_screen.dart';
import 's_chat_screen.dart';

class SHomeScreen extends StatefulWidget {
  const SHomeScreen({Key? key}) : super(key: key);

  @override
  State<SHomeScreen> createState() => _SHomeScreenState();
}

class _SHomeScreenState extends State<SHomeScreen> {
  BottomController homeController = Get.find();
  int _selectedIndex = 0;

  static   List<Widget> _widgetOptions = <Widget>[
    SCatelogeHomeScreen(),
    SOrdersScreen(),
    SChatScreen(),
    SPersonalInfoPage()
    // SProfileScreen(),
  ];
  PageController pageController = PageController();



  @override
  Widget build(BuildContext context) {
    // BottomController homeController = Get.find();
    return SafeArea(
      child: Scaffold(
        body: _widgetOptions[_selectedIndex],
        bottomNavigationBar:NavigationBarScreen(),
      ),
    );
  }
}
