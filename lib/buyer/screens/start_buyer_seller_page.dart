// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:pipes_online/buyer/authentificaion/views/sign_up_page.dart';
//
// import '../app_constant/app_colors.dart';
// import '../custom_widget/widgets/custom_widget/custom_button.dart';
// import '../custom_widget/widgets/custom_widget/custom_radio_button.dart';
// import '../custom_widget/widgets/custom_widget/custom_text.dart';
// import 'home_screen_widget.dart';
//
// class StartBuyerSellerPageWidget extends StatelessWidget {
//   const StartBuyerSellerPageWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return BackgroundImage(
//       child: Center(
//         child: SingleChildScrollView(
//           child: Container(
//             height: Get.height * 0.4,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 SizedBox(height: Get.height / 8,),
//                 CustomText(
//                     text: 'Are you Seller or Buyer?',
//                     fontWeight: FontWeight.w700,
//                     fontSize: 24,
//                     color: AppColors.primaryColor),
//                 SizedBox(height: Get.height /30),
//                 const Expanded(
//                     child: CustomRadioButton()),
//                 SizedBox(height: Get.height * 0.01,),
//                 Custombutton(
//                   name: 'Continue',
//                   function: () {
//                     Get.to(()=>SignUpPage());
//                   },
//                   height: Get.height * 0.07,
//                   width: Get.width / 2,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class BackgroundImage extends StatelessWidget {
//   const BackgroundImage({Key? key, required this.child}) : super(key: key);
//   final Widget  child;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.commonWhiteTextColor,
//       body: SafeArea(
//         child: Container(
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               Positioned(
//                 top: 0,
//                 left: -10,
//                 child: Image.asset('assets/images/main_top.png',fit: BoxFit.fill,),
//               ),
//               Positioned(
//                 top: 0,
//                 left: 30,
//                 child: Image.asset('assets/images/main_top1.png'),
//               ),
//               SizedBox(height: Get.height * 1,),
//               child,
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
