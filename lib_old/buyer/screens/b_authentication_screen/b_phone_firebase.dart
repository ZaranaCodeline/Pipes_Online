// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:pipes_online/seller/view/s_screens/s_cateloge_home_screen.dart';
//
// enum MobileVerificationState {
//   SHOW_MOBILE_FORM_STATE,
//   SHOW_OTP_FORM_STATE,
// }
//
// class BPhoneOTP_Screen extends StatefulWidget {
//   @override
//   _BPhoneOTP_ScreenState createState() => _BPhoneOTP_ScreenState();
// }
//
// class _BPhoneOTP_ScreenState extends State<BPhoneOTP_Screen> {
//   MobileVerificationState currentState =
//       MobileVerificationState.SHOW_MOBILE_FORM_STATE;
//
//   final phoneController = TextEditingController();
//   final otpController = TextEditingController();
//
//   FirebaseAuth _auth = FirebaseAuth.instance;
//
//   late String verificationId;
//
//   bool showLoading = false;
//
//   ///
//   void signInWithPhoneAuthCredential(
//       PhoneAuthCredential phoneAuthCredential) async {
//     setState(() {
//       showLoading = true;
//     });
//
//     try {
//       final authCredential =
//           await _auth.signInWithCredential(phoneAuthCredential);
//       setState(() {
//         showLoading = false;
//       });
//
//       if (authCredential.user != null) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => SCatelogeHomeScreen(),
//           ),
//         );
//       }
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         showLoading = false;
//       });
//
//       _globalKey.currentState!.showSnackBar(
//         SnackBar(
//           content: Text(e.message!),
//         ),
//       );
//     }
//   }
//
//   ///
//   getMobileFormWidget(context) {
//     return Column(
//       children: [
//         Spacer(),
//         TextField(
//           controller: phoneController,
//           decoration: InputDecoration(hintText: 'Phone Number'),
//         ),
//         SizedBox(
//           height: 15,
//         ),
//         FlatButton(
//           onPressed: () async {
//             setState(() {
//               showLoading = true;
//             });
//
//             await _auth.verifyPhoneNumber(
//               phoneNumber: phoneController.text,
//               verificationCompleted: (phoneAuthCredential) async {
//                 setState(() {
//                   showLoading = false;
//                 });
//                 // signInWithPhoneAuthCredential(phoneAuthCredential);
//               },
//               verificationFailed: (verificationFailed) async {
//                 _globalKey.currentState!.showSnackBar(
//                   SnackBar(
//                     content: Text(verificationFailed.message!),
//                   ),
//                 );
//               },
//               codeSent: (verificationId, resendingToken) async {
//                 setState(() {
//                   showLoading = false;
//                   currentState = MobileVerificationState.SHOW_OTP_FORM_STATE;
//                   this.verificationId = verificationId;
//                 });
//               },
//               codeAutoRetrievalTimeout: (verificationId) async {},
//             );
//           },
//           child: Text('Send'),
//           color: Colors.blue,
//           textColor: Colors.white,
//         ),
//         Spacer(),
//       ],
//     );
//   }
//
//   ///
//   getOtpFormWidget(context) {
//     return Column(
//       children: [
//         Spacer(),
//         TextField(
//           controller: otpController,
//           decoration: InputDecoration(hintText: 'Enter Otp'),
//         ),
//         SizedBox(
//           height: 15,
//         ),
//         FlatButton(
//           onPressed: () async {
//             PhoneAuthCredential phoneAuthCredential =
//                 PhoneAuthProvider.credential(
//                     verificationId: verificationId,
//                     smsCode: otpController.text);
//             signInWithPhoneAuthCredential(phoneAuthCredential);
//           },
//           child: Text('Verify'),
//           color: Colors.blue,
//           textColor: Colors.white,
//         ),
//         Spacer(),
//       ],
//     );
//   }
//
//   final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _globalKey,
//       body: Container(
//         child: showLoading
//             ? Center(child: CircularProgressIndicator())
//             : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
//                 ? getMobileFormWidget(context)
//                 : getOtpFormWidget(context),
//         padding: EdgeInsets.all(16),
//       ),
//     );
//   }
// }
