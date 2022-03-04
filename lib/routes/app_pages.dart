import 'package:get/get.dart';
import 'package:pipes_online/login/views/login_page.dart';
import 'package:pipes_online/routes/app_routes.dart';

import '../Splesh_Screen/views/splash.dart';
import '../screens/home_screen_widget.dart';
class AppPages {
  static final initial = Routes.SPLASH;

  static final routes = [
    GetPage(name: Routes.SPLASH, page: () => Splash()),
    GetPage(name: Routes.HOME, page: () => HomeScreen()),
  ];
}