import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
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

FirebaseAuth _auth = FirebaseAuth.instance;

class _SplashState extends State<Splash> {
  BuyerSellerController buyerSellerController =
      Get.put(BuyerSellerController());

  @override
  void initState() {
    super.initState();
    // Timer(Duration(seconds: 2), () {
    //   print(
    //       'PreferenceManager.getUId=============>${PreferenceManager.getUId()}');
    //
    //   if (PreferenceManager.getUId() != null) {
    //     print('TEST:- 1');
    //
    //     if (PreferenceManager.getUserType() == 'Buyer') {
    //       print('TEST:- 2');
    //       if (PreferenceManager.getUId() != null) {
    //         print('Buyer====>${PreferenceManager.getUId()}');
    //         print('TEST:- 3');
    //         Get.offAll(() => BottomNavigationBarScreen());
    //       }
    //       if (PreferenceManager.getName() == null) {
    //         print('B---Name--${PreferenceManager.getName()}');
    //         print('TEST:- 4');
    //         Get.offAll(() => BFirstUserInfoScreen());
    //       }
    //     } else if (PreferenceManager.getUserType() == '' ||
    //         PreferenceManager.getUserType() == null ||
    //         PreferenceManager.getUId() == 'uid') {
    //       print('TEST:- 5');
    //       Get.offAll(() => BWelcomeScreen());
    //     } else {
    //       print('TEST:- 6');
    //       PreferenceManager.getUserType() == 'Seller';
    //       if (PreferenceManager.getUId() != null &&
    //           PreferenceManager.getName() != null) {
    //         PreferenceManager.getSubscribeCategory();
    //         PreferenceManager.getSubscribeTime();
    //         print('Seller==>)${PreferenceManager.getUId()}');
    //         print('TEST:- 7');
    //         Get.offAll(() => NavigationBarScreen());
    //       } else if (PreferenceManager.getName() == null) {
    //         print('s---Name--${PreferenceManager.getName()}');
    //
    //         print('TEST:- 8');
    //         Get.offAll(() => SFirstUserInfoScreen());
    //       } else if (PreferenceManager.getUserType() == '' ||
    //           PreferenceManager.getUserType() == null ||
    //           PreferenceManager.getUId() == 'uid') {
    //         print('TEST:-9');
    //         Get.offAll(() => SWelcomeScreen());
    //       }
    //       /* Get.off(() => NavigationBarScreen());
    //       print('TEST:- 9');*/
    //     }
    //   } else {
    //     print('TEST:- 10');
    //     Get.offAll(() => SOnBoardingScreen());
    //   }
    // });
    Timer(Duration(seconds: 2), () {
      print(
          'PreferenceManager.getUId=============>${PreferenceManager.getUId()}');
      if (PreferenceManager.getUId() != null) {
        print('TEST:- 1');
        if (PreferenceManager.getUserType() == '' ||
            PreferenceManager.getUserType() == null ||
            PreferenceManager.getUId() == 'uid') {
          print('TEST:- 2');
          Get.offAll(BWelcomeScreen());
        } else {
          if (PreferenceManager.getUserType() == 'Buyer') {
            if (PreferenceManager.getUId() != null) {
              print('Buyer====>3)${PreferenceManager.getUId()}');
              print('TEST:- 3');
              Get.offAll(BottomNavigationBarScreen());
            }

            if (PreferenceManager.getName() != null) {
              PreferenceManager.getSubscribeCategory();
              PreferenceManager.getSubscribeTime();
              Get.offAll(BottomNavigationBarScreen());
            }
            Get.offAll(() => BFirstUserInfoScreen());
            if (PreferenceManager.getUserType() == '' ||
                PreferenceManager.getUId() == null ||
                PreferenceManager.getUId() == 'uid') {
              print('TEST:- 4');
              print('Buyer====>4)${PreferenceManager.getUId()}');
              Get.offAll(BWelcomeScreen());
            }
          } else {
            print('TEST:- 5');
            PreferenceManager.getUserType() == 'Seller';
            if (PreferenceManager.getUId() != null) {
              print('Seller==>6)${PreferenceManager.getUId()}');
              print('TEST:- 6');
              Get.offAll(NavigationBarScreen());
            }

            if (PreferenceManager.getName() != null) {
              Get.offAll(NavigationBarScreen());
            }
            Get.off(() => NavigationBarScreen());
            if (PreferenceManager.getUserType() == '' ||
                PreferenceManager.getUId() == null ||
                PreferenceManager.getUId() == 'uid') {
              print('TEST:- 7');
              print('Seller==>7)${PreferenceManager.getUId()}');
              Get.offAll(BWelcomeScreen());
            }
          }
        }
      } else {
        print('TEST:- 7');
        Get.offAll(SOnBoardingScreen());
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
