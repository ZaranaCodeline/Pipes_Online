import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_constant/app_colors.dart';
import 'custom_mobile_screen_widget.dart';
import 'custom_email_screen_widget.dart';
import 'widgets/custom_widget/custom_text.dart';

class TabBarViewWidget extends StatefulWidget {

  final bool? isLogin;

  const TabBarViewWidget({Key? key, this.isLogin}) : super(key: key);


  @override
  State<TabBarViewWidget> createState() => _TabBarViewWidgetState();
}

class _TabBarViewWidgetState extends State<TabBarViewWidget>
    with SingleTickerProviderStateMixin {

  TabController? _tabController;

  int selectedPage = 0;

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
      initialIndex: selectedPage,

      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 30),
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

                  onTap: (value){
                    setState(() {
                      selectedPage = value;
                    });
                    print('value$value');
                  },
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
                  children:  [
                    // first tab bar view widget
                    Center(
                      child: CustomMobileScreenWidget(isLogin: widget.isLogin),
                    ),

                    // second tab bar view widget
                    Center(
                      child: CustomEmailScreenWidget(isLogin: widget.isLogin),
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
