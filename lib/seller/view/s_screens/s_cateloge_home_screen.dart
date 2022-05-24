import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/seller/bottombar/s_navigation_bar.dart';
import 'package:pipes_online/seller/view/s_screens/s_custom_product_card.dart';
import 'package:pipes_online/seller/view/s_screens/s_drawer_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_home_screen_search_widget.dart';
import 'package:pipes_online/seller/view/s_screens/s_order_screen.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';
import '../../../buyer/app_constant/app_colors.dart';
import '../../../buyer/app_constant/b_image.dart';
import '../../../buyer/screens/custom_widget/custom_search_widget.dart';
import '../../../routes/bottom_controller.dart';
import '../../common/s_text_style.dart';
import '../../view_model/s_add_product_controller.dart';
import 's_subscribe_screen.dart';

class SCatelogeHomeScreen extends StatefulWidget {
  const SCatelogeHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SCatelogeHomeScreen> createState() => _SCatelogeHomeScreenState();
}

class _SCatelogeHomeScreenState extends State<SCatelogeHomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Seller User Name ${PreferenceManager.getName()}');
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  BottomController homeController = Get.find();
  bool isLoading = false;
  AddProductController addProductController = Get.put(AddProductController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            leading: IconButton(
              padding: EdgeInsets.only(bottom: Get.height / 9.sp, left: 15.sp),
              icon: SvgPicture.asset(
                'assets/images/svg/drawer_icon.svg',
                width: 15.sp,
                height: 15.sp,
              ),
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  padding:
                      EdgeInsets.only(bottom: Get.height / 9.sp, left: 15.sp),
                  icon: SvgPicture.asset(
                    'assets/images/svg/s_add_pro_icon.svg',
                    width: 23.sp,
                    height: 23.sp,
                  ),
                  onPressed: () {
                    Get.to(SOrdersScreen());
                  },
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.07,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.sp),
                    child: GestureDetector(
                        onTap: () {
                          isLoading = true;
                        },
                        child: const SCustomHomeSearchWidget()),
                  ),
                ],
              ),
            ),
            foregroundColor: AppColors.commonWhiteTextColor,
            backgroundColor: AppColors.primaryColor,
            title: Container(
                padding: EdgeInsets.only(top: 0.sp),
                margin: EdgeInsets.only(bottom: Get.height / 9.sp),
                child: Image.asset(
                  'assets/images/png/pipe_logo.png',
                  fit: BoxFit.fill,
                  height: 35,
                )),
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    SCustomProductCard(),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              print('hello');
              if (PreferenceManager.getSubscribeCategory() != null ||
                  PreferenceManager.getSubscribeCategory() != '' &&
                      PreferenceManager.getSubscribeTime() != null ||
                  PreferenceManager.getSubscribeTime() != null) {
                print(
                    '---subscribe category----->${PreferenceManager.getSubscribeCategory()}');
                print('else if if part');
                homeController.selectedScreen('SShowSubcriptionValueScreen');
                homeController.bottomIndex.value = 0;
              } else if (PreferenceManager.getSubscribeCategory() == null ||
                  PreferenceManager.getSubscribeCategory() == '' &&
                      PreferenceManager.getSubscribeTime() == null ||
                  PreferenceManager.getSubscribeTime() == null) {
                print('else if part');
                homeController.selectedScreen('SSubscribeScreen');
                homeController.bottomIndex.value = 0;
              }
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
    );
  }
}
