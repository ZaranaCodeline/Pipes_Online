import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/seller/view/s_screens/s_onboarding_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_submit_profile_screen.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // Timer(Duration(seconds: 2), () {
    //   Navigator.push(context, MaterialPageRoute(
    //     builder: (context) {
    //       return PreferenceManager.getUID() == null
    //           ? SOnBoardingScreen()
    //           : SSubmitProfileScreen();
    //     },
    //   ));
    // });
    Timer(Duration(seconds: 2), () {
      Get.off(SOnBoardingScreen());
      // PreferenceManager.getUID() == null
      //     ? Get.to(SOnBoardingScreen())
      //     : Get.to(CatelogeHomeWidget());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Image.asset('assets/images/png/pipe_logo.png',fit: BoxFit.fill,height: 50.sp,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
