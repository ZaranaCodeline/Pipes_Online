import 'package:country_code_picker/country_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SSignUpHomeController extends GetxController {
  CountryCode? countryCode = CountryCode(code: '+91');
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController otpNumber = TextEditingController();
  bool otpCodeVisible = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  String verificationIDReceived = "";

  void verifyNumber() async {
    auth.verifyPhoneNumber(
        phoneNumber: mobileNumber.text.trim(),
        verificationCompleted: (PhoneAuthCredential credential) {
          auth.signInWithCredential(credential).then((value) {
            print('you are logged in succesfully');
          });
        },
        verificationFailed: (FirebaseAuthException exception) {
          print(exception.message);
        },
        codeSent: (String verificationID, int? resendToken) {
          verificationIDReceived = verificationID;
        },
        codeAutoRetrievalTimeout: (String varificationID) {
          print('you are logged in succesfully');
        });
  }

  void setCountryCode(value) {
    countryCode = value;
    print('countryCode:- $countryCode');
    update();
  }



}
