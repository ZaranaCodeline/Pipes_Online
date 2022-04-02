import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/b_signup_otp_screen.dart';

import '../../seller/common/s_color_picker.dart';
import '../screens/b_authentication_screen/b_login_otp_screen.dart';



class BLogInController extends GetxController {
  CountryCode? countryCode = CountryCode(code: '+91');
  TextEditingController mobileNumber = TextEditingController();


  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  TextEditingController _otp = TextEditingController();

  bool otpCodeVisible = false;
  String? verificationId;

  @override
  void dispose() {
    mobileNumber.dispose();
    super.dispose();
  }
  Future<void> phoneSignIn({required String phoneNumber}) async {
    print(phoneNumber);
    await _auth.verifyPhoneNumber(
        phoneNumber: '+91' + phoneNumber,
        verificationCompleted: _onVerificationCompleted,
        verificationFailed: _onVerificationFailed,
        codeSent: _onCodeSent,
        codeAutoRetrievalTimeout: _onCodeTimeout);
  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    print("verification completed ${authCredential.smsCode}");
    User? user = FirebaseAuth.instance.currentUser;
    this._otp.text = authCredential.smsCode!;
    if (authCredential.smsCode != null) {
      try {
        UserCredential credential =
        await user!.linkWithCredential(authCredential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'provider-already-linked') {
          await _auth.signInWithCredential(authCredential);
        }
      }

      isLoading = false;

      Get.to(BLogInOTPScreen(),
          arguments: _otp.text
              .toString());
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => SSignUpOTPScreen()));
    }
  }

  _onVerificationFailed(FirebaseAuthException exception) {
    if (exception.code == 'invalid-phone-number') {
      showMessage('Invalid',"The phone number entered is invalid!");
      Get.showSnackbar(GetSnackBar(
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: SColorPicker.red,
        duration: Duration(seconds: 2),
        message: 'Verify Phone Number',
      ));
    }
  }

  _onCodeSent(String verificationId, int? forceResendingToken) {
    this.verificationId = verificationId;
    print(forceResendingToken);
    print("code sent");
    otpCodeVisible = true;
    Get.to(BLogInOTPScreen(),arguments:[verificationId,_otp.text]  );
  }

  _onCodeTimeout(String timeout) {
    return null;
  }

  void showMessage(String errorMessage , context) {
    showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(errorMessage),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () async {
                  Navigator.of(builderContext).pop();
                },
              )
            ],
          );
        }).then((value) {
      isLoading = false;
    });
  }

  void verifyCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!, smsCode:mobileNumber.text);
    await _auth.signInWithCredential(credential).then((value) {
      print('You are logged in successfully');
    });
  }

  void setCountryCode(value) {
    countryCode = value;
    print('countryCode:- $countryCode');
    update();
  }
}

// Future  verifyPhoneNumber() async {
//   _auth.verifyPhoneNumber(
//       phoneNumber: mobileNumber.text,
//       verificationCompleted: (phonesAuthCredentials) async {},
//       verificationFailed: (verificationFailed) async {},
//       codeSent: (verificationId, resendingToken) async {
//         this.verificationId = verificationId;
//       },
//       codeAutoRetrievalTimeout: (verificationId) async {});
// }