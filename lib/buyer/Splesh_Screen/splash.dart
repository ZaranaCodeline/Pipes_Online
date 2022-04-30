import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/b_navigationbar.dart';
import 'package:pipes_online/s_onboarding_screen/s_buyer_seller_contoller.dart';
import 'package:pipes_online/seller/bottombar/s_navigation_bar.dart';
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
          'Splash.....Preferance Id =============>${PreferenceManager.getUId().toString()}');
      print(
          'bFirebaseAuth.currentUser!.uid =============>${bFirebaseAuth.currentUser?.uid}');
      print(
          'PreferenceManager.getUId().toString()=============>${PreferenceManager.getUId()}');
      if (PreferenceManager.getUId().toString() != null) {
        print('TEST:- 1');
        if (PreferenceManager.getUserType() == '' ||
            PreferenceManager.getUserType() == null) {
          print('TEST:- 2');

          // Get.offAll(SBuyerSellerScreen());
          Get.offAll(SOnBoardingScreen());
        } else {
          if (PreferenceManager.getUserType() == 'Buyer') {
            if (FirebaseAuth.instance.currentUser!.uid != null)
              print('TEST:- 3');
            print('==Email==>${PreferenceManager.getEmail()}');
            print('==PhoneNumber==>${PreferenceManager.getPhoneNumber()}');

            Get.offAll(BottomNavigationBarScreen());
          } else {
            print('TEST:- 4');
            print('=========Email==>${PreferenceManager.getEmail()}');
            print(
                '=========PhoneNumber==>${PreferenceManager.getPhoneNumber()}');
            PreferenceManager.getUserType() == 'Seller';
            if (FirebaseAuth.instance.currentUser!.uid != null)
              Get.offAll(NavigationBarScreen());
          }
        }
      } else {
        print('TEST:- 5');
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
