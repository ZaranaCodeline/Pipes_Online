import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/b_welcome_screen.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/new_ui/b_first_user_info_screen.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/b_navigationbar.dart';
import 'package:pipes_online/s_onboarding_screen/s_buyer_seller_contoller.dart';
import 'package:pipes_online/seller/bottombar/s_navigation_bar.dart';
import 'package:pipes_online/seller/view/s_authentication_screen/NEW/s_first_user_info_screen.dart';
import 'package:pipes_online/seller/view/s_authentication_screen/s_welcome_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_onboarding_screen.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  BuyerSellerController buyerSellerController =
      Get.put(BuyerSellerController());

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), () {
      if (PreferenceManager.getUId() != null) {
        print('T-1');
        if (PreferenceManager.getUserType() == 'Buyer') {
          print('T-2');
          if (PreferenceManager.getName() != null ||
              PreferenceManager.getAddress() != null) {
            print('T-3');
            Get.off(BottomNavigationBarScreen());
          } else if (PreferenceManager.getUId() != null) {
            if (PreferenceManager.getUserType() == 'Buyer') {
              if (PreferenceManager.getName() == null ||
                  PreferenceManager.getAddress() == null ||
                  PreferenceManager.getUId() == null) {
                Get.off(BWelcomeScreen());
              }
            }
            print('T-4');
            Get.off(BFirstUserInfoScreen());
          }
        } else if (PreferenceManager.getUserType() == 'Seller') {
          print('T-5');
          if (PreferenceManager.getName() != null ||
              PreferenceManager.getAddress() != null) {
            print('SELLER NAME--${PreferenceManager.getName()}');
            print('T-6');
            Get.off(NavigationBarScreen());
          } else if (PreferenceManager.getUId() != null) {
            print('T-7');
            if (PreferenceManager.getUserType() == 'Seller') {
              if (PreferenceManager.getName() == null ||
                  PreferenceManager.getAddress() == null ||
                  PreferenceManager.getUId() == null) {
                print('T-8');
                Get.off(SWelcomeScreen());
              }
            }
          }
          Get.off(SFirstUserInfoScreen());
        } else {
          print('T-9');
          Get.offAll(SOnBoardingScreen());
        }
      } else {
        print('T-8');
        Get.off(SWelcomeScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff131254),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Center(
              child: Image.asset(
                'assets/images/png/splash_logo.png',
                fit: BoxFit.contain,
                width: 200,
                height: 200,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
