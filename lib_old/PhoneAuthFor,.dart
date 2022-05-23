// import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_get_data/home_page.dart';
// import 'package:flutter/material.dart';
//
// class PhoneAuthForm extends StatefulWidget {
//   PhoneAuthForm({Key? key}) : super(key: key);
//
//   @override
//   _PhoneAuthFormState createState() => _PhoneAuthFormState();
// }
//
// class _PhoneAuthFormState extends State<PhoneAuthForm> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   TextEditingController phoneNumber = TextEditingController();
//   TextEditingController otpCode = TextEditingController();
//
//   OutlineInputBorder border = OutlineInputBorder(
//       borderSide: BorderSide(color: Colors.black, width: 3.0));
//
//   bool isLoading = false;
//   bool otpCodeVisible = false;
//   String? verificationId;
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Verify OTP"),
//           backwardsCompatibility: false,
//         ),
//         // systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.blue),),
//         // backgroundColor: Colors.deepOrangeAccent,
//         body: Center(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   width: size.width * 0.8,
//                   child: TextFormField(
//                       keyboardType: TextInputType.phone,
//                       controller: phoneNumber,
//                       decoration: InputDecoration(
//                         labelText: "Enter Phone",
//                         contentPadding: EdgeInsets.symmetric(
//                             vertical: 15.0, horizontal: 10.0),
//                         border: border,
//                       )),
//                 ),
//                 SizedBox(
//                   height: size.height * 0.01,
//                 ),
//                 SizedBox(
//                   width: size.width * 0.8,
//                   child: TextFormField(
//                     keyboardType: TextInputType.number,
//                     controller: otpCode,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       labelText: "Enter Otp",
//                       contentPadding: EdgeInsets.symmetric(
//                           vertical: 15.0, horizontal: 10.0),
//                       border: border,
//                     ),
//                   ),
//                 ),
//                 Padding(padding: EdgeInsets.only(bottom: size.height * 0.05)),
//                 ElevatedButton(
//                     onPressed: () async {
//                       if (otpCodeVisible) {
//                         verifyCode();
//                       } else {
//                         await phoneSignIn(phoneNumber: phoneNumber.text);
//                       }
//                     },
//                     child: Text(otpCodeVisible ? "Login" : "Verify"))
//
//               ],
//             ),
//           ),
//         ));
//   }
//
//   Future<void> phoneSignIn({required String phoneNumber}) async {
//     await _auth.verifyPhoneNumber(
//         phoneNumber: '+91 ' + phoneNumber,
//         verificationCompleted: _onVerificationCompleted,
//         verificationFailed: _onVerificationFailed,
//         codeSent: _onCodeSent,
//         codeAutoRetrievalTimeout: _onCodeTimeout);
//   }
//
//   _onVerificationCompleted(PhoneAuthCredential authCredential) async {
//     print("verification completed ${authCredential.smsCode}");
//     User? user = FirebaseAuth.instance.currentUser;
//     setState(() {
//       this.otpCode.text = authCredential.smsCode!;
//     });
//     if (authCredential.smsCode != null) {
//       try {
//         UserCredential credential =
//             await user!.linkWithCredential(authCredential);
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'provider-already-linked') {
//           await _auth.signInWithCredential(authCredential);
//         }
//       }
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   _onVerificationFailed(FirebaseAuthException exception) {
//     if (exception.code == 'invalid-phone-number') {
//       showMessage("The phone number entered is invalid!");
//     }
//   }
//
//   _onCodeSent(String verificationId, int? forceResendingToken) {
//     this.verificationId = verificationId;
//     print(forceResendingToken);
//     print("code sent");
//     otpCodeVisible = true;
//   }
//
//   _onCodeTimeout(String timeout) {
//     return null;
//   }
//
//   void showMessage(String errorMessage) {
//     showDialog(
//         context: context,
//         builder: (BuildContext builderContext) {
//           return AlertDialog(
//             title: Text("Error"),
//             content: Text(errorMessage),
//             actions: [
//               TextButton(
//                 child: Text("Ok"),
//                 onPressed: () async {
//                   Navigator.of(builderContext).pop();
//                 },
//               )
//             ],
//           );
//         }).then((value) {
//       setState(() {
//         isLoading = false;
//       });
//     });
//   }
//
//   void verifyCode() async {
//     PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: verificationId!, smsCode: otpCode.text);
//     await _auth.signInWithCredential(credential).then((value) {
//       print('You are logged in successfully');
//     });
//   }
// }
//
//
// Container(
//   width: 25.sp,
//   height: 25.sp,
//    decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(25),
//       color: AppColors
//           .secondaryBlackColor.withOpacity(0.3)    Color(0xffFB8C00)  ),
//   child: IconButton(
//     onPressed: () {
//       cartProductcontroller.increment();
//     },
//     icon: Icon(
//       Icons.arrow_back_ios,
//       color:AppColors
//           .secondaryBlackColor.withOpacity(0.3),
//       size:15.sp,
//     ),
//   ),
// ),
// ,
//  SizedBox(
//   width: 10.sp,
// ),
// Obx(
//   () => Text(
//     '${cartProductcontroller.items.toString()}',
//     style: TextStyle(
//         fontSize: 14.sp, fontWeight: FontWeight.w700
//     ),
//   ),
// ),
// SizedBox(
//   width:10.sp,
// ),
// Container(
//   width: 25.sp,
//   height: 25.sp,
//    decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(25),
//       color: AppColors.secondaryBlackColor),
//   child: IconButton(
//     onPressed: () {
//       cartProductcontroller.decrement();
//     },
//     icon: Icon(
//       Icons.arrow_forward_ios,
//       color: AppColors
//           .secondaryBlackColor.withOpacity(0.3),
//       size: 15.sp,
//     ),
//   ),
// ),
