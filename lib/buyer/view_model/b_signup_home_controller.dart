import 'package:country_code_picker/country_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SSignUpHomeController extends GetxController {
  CountryCode? countryCode = CountryCode(code: '+91');
  TextEditingController mobileNumber = TextEditingController();

  void setCountryCode(value) {
    countryCode = value;
    print('countryCode:- $countryCode');
    update();
  }
}
