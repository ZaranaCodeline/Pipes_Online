import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/app_constant/app_colors.dart';

import 'custom_mobile_screen_widget.dart';
import 'widgets/custom_widget/custom_text.dart';

class TabBarViewWidget extends StatefulWidget {
  const TabBarViewWidget({Key? key}) : super(key: key);

  @override
  State<TabBarViewWidget> createState() => _TabBarViewWidgetState();
}

class _TabBarViewWidgetState extends State<TabBarViewWidget>
    with SingleTickerProviderStateMixin {

  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              // give the tab bar a height [can change hheight to preferred height]
              Container(
                height: Get.height * 0.06,
                decoration: BoxDecoration(
                  color: AppColors.commonWhiteTextColor,
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  border: Border.all(
                    color:AppColors.hintTextColor,
                    width: 0.7,
                  ),
                ),
                child: TabBar(
                  indicatorWeight: 10,
                  controller: _tabController,
                  // give the indicator a decoration (color and border radius)
                  indicator:  UnderlineTabIndicator(
                    borderSide: BorderSide(width: 3.0,color: AppColors.primaryColor),
                    insets: EdgeInsets.symmetric(horizontal:50.0),
                  ),
                  labelColor:AppColors.primaryColor,
                  unselectedLabelColor: AppColors.hintTextColor,
                  // indicatorColor: AppColors.primaryColor,
                  tabs: const [
                    // first tab [you can add an icon using the icon property]
                    Tab(
                      text: 'Mobile',
                    ),
                    // second tab [you can add an icon using the icon property]
                    Tab(
                      text: 'Email',
                    ),
                  ],
                ),
              ),
              // tab bar view here
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: const [
                    // first tab bar view widget
                    Center(
                      child: CustomMobileScreenWidget(),
                    ),

                    // second tab bar view widget
                    Center(
                      // child: CustomEmailScreenWidget(),
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
