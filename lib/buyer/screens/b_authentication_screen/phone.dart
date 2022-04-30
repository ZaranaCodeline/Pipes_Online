import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/otp.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/b_navigationbar.dart';

String? verificationCode;

class BSignUpPhoneNumberScreen extends StatefulWidget {
  const BSignUpPhoneNumberScreen({Key? key}) : super(key: key);

  @override
  State<BSignUpPhoneNumberScreen> createState() =>
      _BSignUpPhoneNumberScreenState();
}

class _BSignUpPhoneNumberScreenState extends State<BSignUpPhoneNumberScreen> {
  int? resendingTokenID;

  FirebaseAuth _auth = FirebaseAuth.instance;

  final _phoneController = TextEditingController();
  final _globalKey = GlobalKey<ScaffoldState>();

  Future sendOtp(FirebaseAuth auth) async {
    await auth.verifyPhoneNumber(
      phoneNumber: '${"+91" + "${_phoneController.text}"}',
      verificationCompleted: (phoneAuthCredential) async {
        print('Verification Completed');
      },
      verificationFailed: (verificationFailed) async {
        log("verificationFailed error ${verificationFailed.message}");
        _globalKey.currentState!.showSnackBar(SnackBar(
          content: Text(verificationFailed.message!),
        ));
      },
      codeSent: (verificationId, resendingToken) async {
        verificationCode = verificationId;
        resendingTokenID = resendingToken;
      },
      codeAutoRetrievalTimeout: (verificationId) async {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _phoneController,
              inputFormatters: [LengthLimitingTextInputFormatter(10)],
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter phone Number",
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await sendOtp(_auth).then(
                  (value) => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BSignUpPhoneOtpScreen(),
                    ),
                  ),
                );
              },
              child: Text("Send Otp"),
            )
          ],
        ),
      ),
    );
  }
}
