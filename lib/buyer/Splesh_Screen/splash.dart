import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/b_welcome_screen.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/b_navigationbar.dart';
import 'package:pipes_online/s_onboarding_screen/s_buyer_seller_contoller.dart';
import 'package:pipes_online/seller/bottombar/s_navigation_bar.dart';
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
    Timer(Duration(seconds: 2), () {
      print(
          'PreferenceManager.getUId=============>${PreferenceManager.getUId()}');
      if (PreferenceManager.getUId() != null) {
        print('TEST:- 1');
        if (PreferenceManager.getUserType() == '' ||
            PreferenceManager.getUserType() == null ||
            PreferenceManager.getUId() == 'uid') {
          print('TEST:- 2');

          // Get.offAll(SBuyerSellerScreen());
          Get.offAll(() => BWelcomeScreen());
        } else {
          if (PreferenceManager.getUserType() == 'Buyer') {
            if (PreferenceManager.getUId() != null) {
              print('============>3)${PreferenceManager.getUId()}');
              print('TEST:- 3');
              // print('==Email==>${PreferenceManager.getEmail()}');
              // print('==PhoneNumber==>${PreferenceManager.getPhoneNumber()}');
              Get.offAll(() => BottomNavigationBarScreen());
            } else if (PreferenceManager.getUserType() == '' ||
                PreferenceManager.getUId() == null ||
                PreferenceManager.getUId() == 'uid') {
              print('TEST:- 4');
              print('============>4)${PreferenceManager.getUId()}');
              Get.to(() => BWelcomeScreen());
            }
          } else {
            print('TEST:- 5');
            print('============>5)${PreferenceManager.getUId()}');
            print('=========Email==>${PreferenceManager.getEmail()}');
            print('==PhoneNumber==>${PreferenceManager.getPhoneNumber()}');
            PreferenceManager.getUserType() == 'Seller';
            if (PreferenceManager.getUId() != null) {
              print('============>6)${PreferenceManager.getUId()}');
              print('TEST:- 6');
              Get.offAll(() => NavigationBarScreen());
            } else if (PreferenceManager.getUId() == null) {
              print('TEST:- 7');
              Get.to(() => SWelcomeScreen());
            }
          }
        }
      } else {
        print('TEST:- 10');
        Get.offAll(() => SOnBoardingScreen());
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
