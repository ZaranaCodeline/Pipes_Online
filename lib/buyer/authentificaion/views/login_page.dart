// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../app_constant/app_colors.dart';
// import '../../custom_widget/widgets/custom_widget/custom_tab_bar_widget.dart';
// import '../../custom_widget/widgets/custom_widget/custom_text.dart';
//
// class LoginPage extends StatelessWidget {
//   const LoginPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: CustomText(
//             alignment: Alignment.centerLeft,
//             text: 'Login',
//             fontWeight: FontWeight.w600,
//             fontSize: 22,
//             color: AppColors.commonWhiteTextColor,
//           ),
//           backgroundColor: AppColors.primaryColor,
//           toolbarHeight: Get.height * 0.1,
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(
//               bottom: Radius.circular(25),
//             ),
//           ),
//       ),
//       body: Container(
//         child:  TabBarViewWidget(isLogin: true),
//       ),
//     );
//   }
// }
