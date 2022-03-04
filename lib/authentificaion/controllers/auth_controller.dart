import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/app_constant/app_colors.dart';
import 'package:pipes_online/authentificaion/views/login_page.dart';
import 'package:pipes_online/screens/home_screen_widget.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      print('LoginPage');
      Get.offAll(() => LoginPage());
    } else {
      Get.offAll(() => HomePage());
    }
  }

  void register(String email, password) {
    try {
      auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      Get.snackbar(
        "About User",
        "User Message",
        backgroundColor: AppColors.hintTextColor,
        snackPosition: SnackPosition.BOTTOM,
        titleText: Text('Account Creatoin Failed'),
        messageText: Text(
          e.toString(),
          style: TextStyle(color: AppColors.secondaryBlackColor),
        ),
      );
    }
  }
}
