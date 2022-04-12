import 'package:country_code_picker/country_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/s_authentication_screen/s_signup_otp_screen.dart';

class SSignUpHomeController extends GetxController {
  CountryCode? countryCode = CountryCode(code: '+91');
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController otpNumber = TextEditingController();
  bool otpCodeVisible = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  String verificationIDReceived = "";

  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _otp = TextEditingController();
  // bool otpCodeVisible = false;
  String? verificationId;



  void setCountryCode(value) {
    countryCode = value;
    print('countryCode:- $countryCode');
    update();
  }

}
