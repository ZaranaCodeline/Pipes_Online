import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/seller/view/s_screens/s_drawer_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_order_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_product_card_list.dart';
import 'package:sizer/sizer.dart';
import '../../../buyer/app_constant/app_colors.dart';
import '../../../buyer/custom_widget/custom_home_page_widget/custom_home_search_widget.dart';
import '../../../routes/bottom_controller.dart';
import '../../common/s_text_style.dart';
import 's_subscribe_screen.dart';

class SCatelogeHomeScreen extends StatelessWidget {
  const SCatelogeHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: Get.height,
          child: SafeArea(
            child: Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                leading: IconButton(
                  padding:
                      EdgeInsets.only(bottom: Get.height / 9.sp, left: 15.sp),
                  icon: SvgPicture.asset(
                    'assets/images/svg/drawer_icon.svg',
                    width: 15.sp,
                    height: 15.sp,
                  ),
                  onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                ),
                actions: [
                  InkWell(
                    onTap: () {
                      Get.to(() => SOrdersScreen());
                    },
                    child: Container(
                        margin: EdgeInsets.only(
                            top: 10.sp, right: 15.sp, bottom: 60.sp),
                        // width: Get.width * 0.1,
                        color: AppColors.primaryColor,
                        child: SvgPicture.asset(
                          'assets/images/svg/s_add_pro_icon.svg',width: 18.sp,
                          height: 20.sp,fit: BoxFit.fill,
                          color: AppColors.commonWhiteTextColor,
                        )),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: Get.height / 12,
                        ),
                        const CustomHomeSearchWidget(),
                      ],
                    ),
                  ),
                ),
                foregroundColor: AppColors.commonWhiteTextColor,
                backgroundColor: AppColors.primaryColor,
                title: Container(
                  padding: EdgeInsets.only(top: 15.sp),
                  margin: EdgeInsets.only(bottom: Get.height / 9.sp),
                  child:Image.asset("assets/images/png/pipe_logo.png",fit: BoxFit.fill,height: 40,)),
                centerTitle: true,
                toolbarHeight: Get.height * 0.13.sp,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(25),
                  ),
                ),
              ),
              drawer: Container(
                  child: const Drawer(
                child: SDrawerScreen(),
              )),
              body: SafeArea(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.02.sp,
                      ),
                      Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'My Products',
                            style: STextStyle.bold700Purple16,
                          )),
                      SizedBox(
                        height: Get.height * 0.01.sp,
                      ),
                      Expanded(child: SProductCardList()),
                    ],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Get.to(() => SSubscribeScreen());
                },
                child: Container(
                  width: Get.width * 0.15.sp,
                  height: Get.height / 9.sp,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(50.sp),
                  ),
                  child: Icon(
                    Icons.add,
                    color: AppColors.commonWhiteTextColor,
                    size: 20.sp,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
