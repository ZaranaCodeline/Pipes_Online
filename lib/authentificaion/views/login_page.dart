import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/app_constant/app_colors.dart';
import 'package:pipes_online/custom_widget/widgets/custom_widget/custom_text.dart';

import '../../custom_widget/custom_mobile_screen_widget.dart';
import '../../custom_widget/custom_tab_bar_widget.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   LoginPageState createState() => LoginPageState();
// }
//
// class LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: CustomText(
//             alignment: Alignment.centerLeft,
//             text: 'Login',
//             fontWeight: FontWeight.w700,
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
//           // bottom:
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(30.0),
//           child: Column(
//             children: [
//               // give the tab bar a height [can change hheight to preferred height]
//               Container(
//                 height: Get.height * 0.06,
//                 decoration: BoxDecoration(
//                   color: AppColors.commonWhiteTextColor,
//                   borderRadius: BorderRadius.circular(
//                     10.0,
//                   ),
//                   border: Border.all(
//                     color:AppColors.hintTextColor,
//                     width: 0.7,
//                   ),
//                 ),
//                 child: TabBar(
//                   indicatorWeight: 10,
//                   controller: _tabController,
//                   // give the indicator a decoration (color and border radius)
//                   indicator:  UnderlineTabIndicator(
//                       borderSide: BorderSide(width: 3.0,color: AppColors.primaryColor),
//                       insets: EdgeInsets.symmetric(horizontal:50.0),
//                   ),
//                   labelColor:AppColors.primaryColor,
//                   unselectedLabelColor: AppColors.hintTextColor,
//                   // indicatorColor: AppColors.primaryColor,
//                   tabs: const [
//                     // first tab [you can add an icon using the icon property]
//                     Tab(
//                       text: 'Mobile',
//                     ),
//                     // second tab [you can add an icon using the icon property]
//                     Tab(
//                       text: 'Email',
//                     ),
//                   ],
//                 ),
//               ),
//               // tab bar view here
//               Expanded(
//                 child: TabBarView(
//                   controller: _tabController,
//                   children: const [
//                     // first tab bar view widget
//                     Center(
//                       child: CustomMobileScreenWidget(),
//                     ),
//
//                     // second tab bar view widget
//                     Center(
//                       // child: CustomEmailScreenWidget(),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
            alignment: Alignment.centerLeft,
            text: 'Login',
            fontWeight: FontWeight.w700,
            fontSize: 22,
            color: AppColors.commonWhiteTextColor,
          ),
          backgroundColor: AppColors.primaryColor,
          toolbarHeight: Get.height * 0.1,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25),
            ),
          ),
      ),
      body: Container(
        child: TabBarViewWidget(),
      ),
    );
  }
}
