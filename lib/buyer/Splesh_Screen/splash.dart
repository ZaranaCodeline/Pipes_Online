import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/b_submit_profile_screen.dart';
import 'package:pipes_online/buyer/screens/home_screen_widget.dart';
import 'package:pipes_online/routes/app_routes.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import '../routes/app_routes.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      PreferenceManager.getUID() == null
          ? Get.to(BSubmitProfileScreen())
          : Get.to(CatelogeHomeWidget());
    });
    // Future.delayed(const Duration(milliseconds: 5000)).then(
    //   (value) => Get.offNamed(SRoutes.SOnBoardingScreen),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.commonWhiteTextColor,
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset('assets/images/png/pipe_logo.png',fit: BoxFit.cover,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
