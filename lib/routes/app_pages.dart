import 'package:get/get.dart';
import 'package:pipes_online/buyer/Splesh_Screen/splash.dart';
import 'package:pipes_online/buyer/authentificaion/views/login_page.dart';
import 'package:pipes_online/buyer/screens/drawer_profile_page.dart';
import 'package:pipes_online/buyer/screens/home_screen_widget.dart';
import 'package:pipes_online/buyer/screens/my_order_page.dart';
import 'package:pipes_online/buyer/screens/settings_page.dart';
import 'package:pipes_online/buyer/screens/start_buyer_seller_page.dart';
import 'package:pipes_online/buyer/screens/welcome_page.dart';
import 'package:pipes_online/s_onboarding_screen/s_buyer_seller_screen.dart';
import 'package:pipes_online/s_onboarding_screen/s_onboarding_screen.dart';
import 'package:pipes_online/s_onboarding_screen/s_permission_screen.dart';
import 'package:pipes_online/seller/view/s_authentication_screen/s_login_home_screen.dart';
import 'package:pipes_online/seller/view/s_authentication_screen/s_login_otp_screen.dart';
import 'package:pipes_online/seller/view/s_authentication_screen/s_signup_home_screen.dart';
import 'package:pipes_online/seller/view/s_authentication_screen/s_signup_otp_screen.dart';
import 'package:pipes_online/seller/view/s_authentication_screen/s_submit_profile_screen.dart';
import 'package:pipes_online/seller/view/s_authentication_screen/s_welcome_screen.dart';

import '../buyer/screens/b_authentication_screen/b_login_home_screen.dart';
import '../buyer/screens/b_authentication_screen/b_signup_home_screen.dart';
import '../buyer/screens/b_authentication_screen/b_submit_profile_screen.dart';
import '../seller/bottombar/navigation_bar.dart';
import 'app_routes.dart';

class AppPages {
  static final initial = SRoutes.SOnBoardingScreen;
  // static final othher = SRoutes.SSubmitProfileScreen;
  static final bottom = SRoutes.SBottomBar;

  static final routes = [
    // GetPage(name: Routes.SPLASH, page: () => Splash()),
    GetPage(name: Routes.HOME, page: () => SWelcomeScreen()),
    GetPage(name: Routes.PROFILE, page: () => DrawerProfilePage()),
    GetPage(name: Routes.MYORDER, page: () => MyOrderPage()),
    GetPage(name: Routes.SETTINGPAGE, page: () => SettingsPage()),

    GetPage(name: SRoutes.SOnBoardingScreen, page: () => SOnBoardingScreen()),
    GetPage(name: SRoutes.SPermissionScreen, page: () => SPermissionScreen()),
    GetPage(name: SRoutes.SBuyerSellerScreen, page: () => SBuyerSellerScreen()),
    GetPage(name: SRoutes.SWelcomeScreen, page: () => SWelcomeScreen()),
    GetPage(name: SRoutes.SSignUpHomeScreen, page: () => SSignUpHomeScreen()),
    GetPage(name: SRoutes.SSignUpOTPScreen, page: () => SSignUpOTPScreen()),
    GetPage(name: SRoutes.SLogInHomeScreen, page: () => SLogInHomeScreen()),
    GetPage(name: SRoutes.SLogInOTPScreen, page: () => SLogInOTPScreen()),
    GetPage(name: SRoutes.SBottomBar, page: () => NavigationBarScreen()),
    GetPage(
        name: SRoutes.SSubmitProfileScreen, page: () => SSubmitProfileScreen()),

    GetPage(name: BRoutes.BSubmitProfileScreen, page: () => BSubmitProfileScreen()),
    GetPage(name: BRoutes.BLogInHomeScreen, page: () => BLogInHomeScreen()),
    GetPage(name: BRoutes.BSignUpHomeScreen, page: () => BSignUpHomeScreen()),
  ];
}
