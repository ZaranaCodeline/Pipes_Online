import 'package:get/get.dart';

import '../Splesh_Screen/splash.dart';
import '../authentificaion/views/login_page.dart';
import '../screens/home_screen_widget.dart';
import '../screens/my_order_page.dart';
import '../screens/drawer_profile_page.dart';
import '../screens/settings_page.dart';
import '../screens/start_buyer_seller_page.dart';
import '../screens/welcome_page.dart';
import 'app_routes.dart';

class AppPages {
  static final initial = Routes.START;

  static final routes = [
    GetPage(name: Routes.START, page: () => StartBuyerSellerPageWidget()),

    GetPage(name: Routes.SPLASH, page: () => Splash()),
    GetPage(name: Routes.WELCOME, page: () => WelComePage()),
    GetPage(name: Routes.HOME, page: () => HomePage()),
    GetPage(name: Routes.PROFILE, page: () => DrawerProfilePage()),
    GetPage(name: Routes.MYORDER, page: () => MyOrderPage()),
    GetPage(name: Routes.SETTINGPAGE, page: () => SettingsPage()),
    GetPage(name: Routes.LOGIN, page: ()=>LoginPage()),
  ];
}
