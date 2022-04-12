import 'package:get/get.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/b_phone_otp_screen.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/b_ragistraion_screen.dart';
import 'package:pipes_online/buyer/screens/b_chat_screen.dart';
import 'package:pipes_online/buyer/screens/b_drawer_profile_page.dart';
import 'package:pipes_online/buyer/screens/b_my_order_page.dart';
import 'package:pipes_online/buyer/screens/b_settings_page.dart';
import 'package:pipes_online/s_onboarding_screen/s_buyer_seller_screen.dart';
import 'package:pipes_online/s_onboarding_screen/s_onboarding_screen.dart';
import 'package:pipes_online/s_onboarding_screen/s_permission_screen.dart';
import 'package:pipes_online/seller/view/s_authentication_screen/s_login_home_screen.dart';
import 'package:pipes_online/seller/view/s_authentication_screen/s_login_otp_screen.dart';
import 'package:pipes_online/seller/view/s_authentication_screen/s_signup_home_screen.dart';
import 'package:pipes_online/seller/view/s_authentication_screen/s_signup_otp_screen.dart';
import 'package:pipes_online/seller/view/s_authentication_screen/s_submit_profile_screen.dart';
import 'package:pipes_online/seller/view/s_authentication_screen/s_welcome_screen.dart';
import '../buyer/Splesh_Screen/splash.dart';
import '../buyer/screens/b_authentication_screen/b_phone_otp_screen.dart';
import '../buyer/screens/b_authentication_screen/b_ragistraion_screen.dart';
import '../buyer/screens/b_authentication_screen/b_login_screen.dart';
import '../seller/bottombar/s_navigation_bar.dart';
import 'app_routes.dart';

class AppPages {
  // static final initial = SRoutes.SOnBoardingScreen;
  static final initial = Routes.SPLASH;
  static final bottom = SRoutes.SBottomBar;

  static final routes = [
    GetPage(name: Routes.SPLASH, page: () => Splash()),
    GetPage(name: Routes.HOME, page: () => SWelcomeScreen()),

    GetPage(name: SRoutes.SOnBoardingScreen, page: () => SOnBoardingScreen()),
    GetPage(name: SRoutes.SPermissionScreen, page: () => SPermissionScreen()),
    GetPage(name: SRoutes.SBuyerSellerScreen, page: () => SBuyerSellerScreen()),
    GetPage(name: SRoutes.SWelcomeScreen, page: () => SWelcomeScreen()),

    GetPage(name: BRoutes.LoginScreen, page: () => LoginScreen()),
    GetPage(name: BRoutes.BPhoneOTP_Screen, page: () => BPhoneOTP_Screen()),
    GetPage(name: BRoutes.BSignUpRagistraionScreen, page: () => BSignUpRagistraionScreen()),
    GetPage(name: BRoutes.BChatScreen, page: () => BChatScreen()),

    GetPage(name: Routes.PROFILE, page: () => DrawerProfilePage()),
    GetPage(name: Routes.MYORDER, page: () => MyOrderPage()),
    GetPage(name: Routes.SETTINGPAGE, page: () => BSettingsScreen()),


    GetPage(name: SRoutes.SSignUpHomeScreen, page: () => SSignUpHomeScreen()),
    GetPage(name: SRoutes.SSignUpOTPScreen, page: () => SSignUpOTPScreen()),
    GetPage(name: SRoutes.SLogInHomeScreen, page: () => SLogInHomeScreen()),
    GetPage(name: SRoutes.SLogInOTPScreen, page: () => SLogInOTPScreen()),
    GetPage(name: SRoutes.SBottomBar, page: () => NavigationBarScreen()),
    GetPage(
        name: SRoutes.SSubmitProfileScreen, page: () => SSubmitProfileScreen()),

  ];
}
