import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_constant/app_colors.dart';
import 'b_listing_widget.dart';
import 'b_review_widgets.dart';

class ListingReviewTabBarWidget extends StatefulWidget {
  final String? id,
      category,
      sellerAddress,
      sellerName,
      sellerID,
      sellerImage,
      sellerPhone;
  const ListingReviewTabBarWidget(
      {Key? key,
      this.id,
      this.category,
      this.sellerAddress,
      this.sellerName,
      this.sellerID,
      this.sellerImage,
      this.sellerPhone})
      : super(key: key);

  @override
  State<ListingReviewTabBarWidget> createState() =>
      _ListingReviewTabBarWidgetState();
}

class _ListingReviewTabBarWidgetState extends State<ListingReviewTabBarWidget>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  int selectedPage = 0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    print('=========Category widget========${widget.category}');
    print('=========sellerImage========${widget.sellerName}');
    print('=========sellerName========${widget.sellerImage}');
    print('=========sellerPhone========${widget.sellerPhone}');
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('====>b listing review tab===>${widget.category}');
    return Card(
      child: Container(
        height: Get.height * 0.001,
        child: DefaultTabController(
          length: 2,
          initialIndex: selectedPage,
          child: Scaffold(
            body: Column(
              children: [
                // give the tab bar a height [can change hheight to preferred height]
                Container(
                  height: Get.height * 0.06,
                  decoration: BoxDecoration(
                    color: AppColors.commonWhiteTextColor,
                    borderRadius: BorderRadius.circular(
                      0.0,
                    ),
                    border: Border.all(
                      color: AppColors.hintTextColor,
                      width: 0.4,
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
                          BorderSide(width: 2, color: AppColors.primaryColor),
                      insets: EdgeInsets.symmetric(horizontal: 0.0),
                    ),
                    labelColor: AppColors.primaryColor,
                    unselectedLabelColor: AppColors.hintTextColor,
                    // indicatorColor: AppColors.primaryColor,
                    tabs: const [
                      Tab(
                        text: 'Listings',
                      ),
                      Tab(
                        text: 'Reviews',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // first tab bar view widget
                      const Center(
                        child: BListingWidget(),
                      ),
                      Center(
                        child: BReviewWidget(
                          id: widget.id,
                          category: widget.category,
                          sImage: widget.sellerImage,
                          sName: widget.sellerName,
                          sContact: widget.sellerPhone,
                          sellerID: widget.sellerID,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
