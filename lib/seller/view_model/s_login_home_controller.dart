import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SLogInController extends GetxController {
  CountryCode? countryCode = CountryCode(code: '+00');
  TextEditingController mobileNumber = TextEditingController();

  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController _otp = TextEditingController();

  bool otpCodeVisible = false;
  String? verificationId;

  void setCountryCode(value) {
    countryCode = value;
    print('countryCode:- $countryCode');
    update();
  }
}
