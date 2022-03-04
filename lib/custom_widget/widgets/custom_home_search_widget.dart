// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pipes_online/app_constant/app_colors.dart';
//
// class CustomHomeSearchWidget extends StatelessWidget {
//   const CustomHomeSearchWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(25.0, 6.0, 25.0, 16.0),
//         child: Container(
//           height: Get.height / 16,
//           width: Get.width / 1.4,
//           child: CupertinoTextField(
//             keyboardType: TextInputType.text,
//             placeholder: 'Search items hear',
//             cursorColor: AppColors.primaryColor,
//             placeholderStyle: GoogleFonts.nunito(
//               textStyle: TextStyle(
//                 color: AppColors.hintTextColor,
//                 fontSize: 14.0,
//               ),
//             ),
//             prefix: const Padding(
//               padding: EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
//               child: Icon(
//                 Icons.search,
//                 color: Color(0xffC4C6CC),
//               ),
//             ),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(50.0),
//               color:AppColors.commonWhiteTextColor,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
