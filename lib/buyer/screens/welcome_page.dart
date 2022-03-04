// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../app_constant/app_colors.dart';
// import '../authentificaion/views/login_page.dart';
// import '../authentificaion/views/sign_up_page.dart';
// import '../custom_widget/widgets/custom_widget/custom_button.dart';
// import '../custom_widget/widgets/custom_widget/custom_text.dart';
//
// class WelComePage extends StatelessWidget {
//   const WelComePage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Center(child: Image.asset('assets/images/wel_come_logo.png')),
//           CustomText(
//               text: 'WELCOME!',
//               fontWeight: FontWeight.w600,
//               fontSize: 40,
//               color: AppColors.primaryColor),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               Custombutton(name: 'Sign Up',function:()=> Get.to(()=>SignUpPage()),height: Get.height * 0.07 ,width: Get.width / 3,),
//               Custombutton(name: 'Login', function: ()=> Get.to(()=>LoginPage()),height: Get.height * 0.07,width: Get.width / 3,),
//             ],
//           ),
//         ],
//       ),
//     ));
//   }
// }
