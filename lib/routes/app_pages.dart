import 'package:get/get.dart';
import 'package:pipes_online/routes/app_routes.dart';
import 'package:pipes_online/screens/profile_page.dart';

import '../Splesh_Screen/views/splash.dart';
import '../screens/home_screen_widget.dart';
import '../screens/my_order_page.dart';
import '../screens/settings_page.dart';
import '../screens/start_buyer_seller_page.dart';
import '../screens/welcome_page.dart';

class AppPages {
  static final initial = Routes.START;

  static final routes = [
    GetPage(name: Routes.START, page: () => StartBuyerSellerPageWidget()),
    GetPage(name: Routes.SPLASH, page: () => Splash()),
    GetPage(name: Routes.WELCOME, page: () => WelComePage()),
    GetPage(name: Routes.HOME, page: () => HomePage()),
    GetPage(name: Routes.PROFILE, page: () => ProfilePage()),
    GetPage(name: Routes.MYORDER, page: () => MyOrderPage()),
    GetPage(name: Routes.SETTINGPAGE, page: () => SettingsPage()),
  ];
}
