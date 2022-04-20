// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pipes_online/buyer/screens/b_authentication_screen/login_phone_controller.dart';
//
// class OtpScreen extends StatelessWidget {
//   final loginController = Get.put(LoginController());
//   final otp = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: loginController.isLoading(false) ? Center(child: CircularProgressIndicator()) : Center(
//           child: Column(
//             children: [
//               Spacer(),
//               TextField(
//                 controller: otp,
//                 decoration: InputDecoration(
//                   hintText: "Enter OTP",
//                 ),
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//               FlatButton(
//                 onPressed: ()  {
//                   loginController.otpVerify(otp.text);
//                 },
//                 child: Text("VERIFY"),
//                 color: Colors.blue,
//                 textColor: Colors.white,
//               ),
//               Spacer(),
//             ],
//           )),
//     );
//   }
// }