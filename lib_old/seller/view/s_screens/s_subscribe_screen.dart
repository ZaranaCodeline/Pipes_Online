import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/seller/bottombar/widget/category_bottom_bar_route.dart';
import 'package:pipes_online/seller/view/s_screens/s_plus_subscribe_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_simple_subscribe_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../buyer/app_constant/app_colors.dart';
import '../../common/s_text_style.dart';

class SSubscribeScreen extends StatefulWidget {
  @override
  _SSubscribeScreenState createState() => _SSubscribeScreenState();
}

class _SSubscribeScreenState extends State<SSubscribeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int selectedPage = 0;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'SUBSCRIBE',
          style: STextStyle.bold700White14,
        ),
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: Get.height * 0.1,
        leading: IconButton(
          onPressed: () {
            // homeController.bottomIndex.value = 0;
            // homeController.selectedScreen('NavigationBarScreen');
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
      ),
      body: Container(
        color: AppColors.backGroudColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // give the tab bar a height [can change hheight to preferred height]
              Container(
                height: 45,
                decoration: BoxDecoration(
                  color: AppColors.commonWhiteTextColor,
                  borderRadius: BorderRadius.circular(
                    5.0,
                  ),
                ),
                child: TabBar(
                  indicatorWeight: 0,
                  controller: _tabController,
                  onTap: (value) {
                    setState(() {
                      selectedPage = value;
                    });
                    print('value$value');
                  },
                  indicator: UnderlineTabIndicator(
                    borderSide:
                        BorderSide(width: 3, color: AppColors.primaryColor),
                    insets: EdgeInsets.symmetric(horizontal: 40),
                  ),
                  labelColor: AppColors.primaryColor,
                  unselectedLabelColor: AppColors.hintTextColor,
                  // indicatorColor: AppColors.primaryColor,
                  tabs: const [
                    Tab(
                      text: 'Simple',
                    ),
                    Tab(
                      text: 'Plus',
                    ),
                  ],
                ),
              ),
              // tab bar view here
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    // first tab bar view widget
                    Center(
                      child: SSimpleSubScribeScreen(),
                    ),
                    // second tab bar view widget
                    Center(
                      child: SPlusSubscribeScreen(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
