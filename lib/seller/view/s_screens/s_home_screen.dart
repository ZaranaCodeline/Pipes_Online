import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/seller/view/s_screens/s_order_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_prosonal_info_page.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import '../../../routes/bottom_controller.dart';
import '../../bottombar/s_navigation_bar.dart';
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

  static List<Widget> _widgetOptions = <Widget>[
    SCatelogeHomeScreen(),
    SOrdersScreen(isBottomBarVisible: false),
    SChatScreen(),
    SPersonalInfoPage()
  ];
  PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(
        'LAT>>>>>+1 ${PreferenceManager.getLat()}-LONG>>>>2--${PreferenceManager.getLong()}');
  }

  @override
  Widget build(BuildContext context) {
    // BottomController homeController = Get.find();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: _widgetOptions[_selectedIndex],
          bottomNavigationBar: NavigationBarScreen(),
        ),
      ),
    );
  }
}
