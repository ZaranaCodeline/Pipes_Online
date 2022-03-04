// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pipes_online/seller/view/s_screens/s_plus_subscribe_screen.dart';
// import 'package:pipes_online/seller/view/s_screens/s_simple_subscribe_screen.dart';
//
// import '../../../buyer/app_constant/app_colors.dart';
//
// class SSimplePlusWidget extends StatefulWidget {
//   const SSimplePlusWidget({Key? key}) : super(key: key);
//
//   @override
//   State<SSimplePlusWidget> createState() => _SSimplePlusWidgetState();
// }
//
// class _SSimplePlusWidgetState extends State<SSimplePlusWidget>
//     with SingleTickerProviderStateMixin {
//   TabController? _tabController;
//
//   int selectedPage = 0;
//
//   @override
//   void initState() {
//     _tabController = TabController(length: 2, vsync: this);
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _tabController!.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: AppColors.secondaryBlackColor,
//       child: Container(
//         color: AppColors.secondaryBlackColor,
//         height: 100,
//         child: DefaultTabController(
//           length: 2,
//           initialIndex: selectedPage,
//           child: Scaffold(
//             body: Column(
//               children: [
//                 // give the tab bar a height [can change hheight to preferred height]
//                 Container(
//                   height: Get.height * 0.06,
//                   decoration: BoxDecoration(
//                     color: AppColors.commonWhiteTextColor,
//                   ),
//                   child: TabBar(
//                     indicatorWeight: 0,
//                     controller: _tabController,
//                     onTap: (value) {
//                       setState(() {
//                         selectedPage = value;
//                       });
//                       print('value$value');
//                     },
//                     indicator: UnderlineTabIndicator(
//                       borderSide:
//                           BorderSide(width: 3, color: AppColors.primaryColor),
//                       insets: EdgeInsets.symmetric(horizontal: 40),
//                     ),
//                     labelColor: AppColors.primaryColor,
//                     unselectedLabelColor: AppColors.hintTextColor,
//                     // indicatorColor: AppColors.primaryColor,
//                     tabs: const [
//                       Tab(
//                         text: 'Simple',
//                       ),
//                       Tab(
//                         text: 'Plus',
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: TabBarView(
//                     controller: _tabController,
//                     children: const [
//                       // first tab bar view widget
//                       Center(
//                         child: SSimpleSubScribeScreen(),
//                       ),
//                       Center(
//                         child: SPlusSubscribeScreen(),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
