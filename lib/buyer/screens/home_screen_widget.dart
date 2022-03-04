import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/screens/personal_info_page.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:sizer/sizer.dart';
import '../../seller/common/s_image.dart';
import '../../seller/common/s_text_style.dart';
import '../app_constant/app_colors.dart';
import '../custom_widget/custom_home_page_widget/custom_drawer_widget.dart';
import '../custom_widget/custom_home_page_widget/custom_home_search_widget.dart';
import '../custom_widget/widgets/custom_widget/custom_navigationbar_items.dart';
import '../custom_widget/widgets/custom_widget/custom_text.dart';
import 'bottom_bar_screen_page/widget/cart_bottom_bar_route.dart';
import 'cart_page.dart';
import 'categories_card__list.dart';
import '../custom_widget/widgets/custom_widget/custom_title_text.dart';
import 'product_card_list.dart';

// class HomePage extends StatefulWidget {
//   HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   int _selectedIndex = 0;
//
//   static List<Widget> _widgetOptions = <Widget>[
//     CatelogeHomeWidget(),
//     CartPage(),
//     ChatPage(),
//     PersonalInfoPage(),
//   ];
//   PageController pageController = PageController();
//
//   void onTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//     pageController.jumpToPage(index);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _widgetOptions[_selectedIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _selectedIndex,
//         backgroundColor: AppColors.commonWhiteTextColor,
//         selectedItemColor: AppColors.primaryColor,
//         unselectedItemColor: AppColors.offLightPurpalColor,
//         elevation: 7,
//         onTap: (value) {
//           setState(() {
//             _selectedIndex = value;
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(
//               icon: Icon(Icons.border_all_outlined), label: ''),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.shopping_cart_outlined), label: ' '),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.chat_bubble_outline), label: ' '),
//           BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ' '),
//         ],
//       ),
//     );
//   }
// }

class CatelogeHomeWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    _showPopupMenu() {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      final offset = renderBox.localToGlobal(Offset.zero);
      //*calculate the start point in this case, below the button
      final left = offset.dx;
      final top = offset.dy + renderBox.size.height;
      //*The right does not indicates the width
      final right = left + renderBox.size.width;
      final bottom = offset.dx;
      showMenu<String>(
          context: context,
          position: RelativeRect.fromLTRB(25.0, Get.height * 0.17, 0, 25.0),
          //position where you want to show the menu on screen
          items: [
            const PopupMenuItem<String>(
                child: Text('Filter by KM'), value: '1'),
            PopupMenuItem<String>(
                child: Card(
                  elevation: 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Row(
                      children: [
                        CustomText(
                          text: '2 KM',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: AppColors.secondaryBlackColor,
                          textDecoration: TextDecoration.underline,
                        ),
                        SizedBox(
                          width: Get.width * 0.05,
                        ),
                        Container(
                          width: 32.sp,
                          height: 28.sp,
                          // color: AppColors.primaryColor,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.primaryColor,
                          ),
                          child: Icon(
                            Icons.search,
                            size: 25.sp,
                            color: AppColors.commonWhiteTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                value: '2'),
          ],
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.sp),
          ));
    }

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(Get.height * 0.17),
            child: Container(
              height: Get.height * 0.17,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(Get.width * 0.070),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 1),
                        blurRadius: 10,
                        spreadRadius: 2)
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: Get.height * 0.07,
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                    // color: Colors.red,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          //padding: EdgeInsets.only(left: 15.sp),
                          icon: SvgPicture.asset(
                            'assets/images/svg/drawer_icon.svg',
                            width: 15.sp,
                            height: 15.sp,
                            color: AppColors.commonWhiteTextColor,
                          ),
                          onPressed: () =>
                              _scaffoldKey.currentState?.openDrawer(),
                        ),
                        // SvgPicture.asset("${SImagePick.pipesDealLogo}"),
                        Container(
                            margin: EdgeInsets.only(right: 15.sp,bottom: 5.sp,top: 5.sp),

                            child: Image.asset("assets/images/png/pipe_logo.png",width: 35.sp,height: 35.sp,)),
                        // Text(
                        //   'PIPES ONLINE',
                        //   style: STextStyle.bold700White14,
                        // ),
                        InkWell(
                          onTap: () {
                            Get.to(() => CartPage());
                            // if (bottomBarIndexController.bottomIndex.value == 1) {
                            //   bottomBarIndexController.setSelectedScreen(
                            //       value: 'HomeScreen');
                            //   bottomBarIndexController.bottomIndex.value = 0;
                            // } else {
                            //   Get.back();
                            // }
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: Get.height * 0.05,
                                child: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: SColorPicker.white,
                                  size: 21.sp,
                                ),
                              ),
                              Positioned(
                                top: 2.sp,
                                left: 0,
                                right: 0,
                                child: Container(
                                  width: 10.sp,
                                  height: 10.sp,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.commonWhiteTextColor,
                                  ),
                                  child: CustomText(
                                    text: '3',
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.secondaryBlackColor,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                    height: Get.height * 0.1,
                    //color: Colors.green,
                    child: SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomHomeSearchWidget(),
                          GestureDetector(
                            onTap: () {
                              print('FILTER');
                              _showPopupMenu();
                              // CustomHoverPopupFilterWidget();
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.sp),
                              child: Container(
                                width: Get.width / 6,
                                height: Get.height * 0.06,
                                color: AppColors.commonWhiteTextColor,
                                child: Icon(
                                  Icons.filter_alt_outlined,
                                  color: AppColors.primaryColor,
                                  size: 22.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
        drawer: CustomDrawerWidget(),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.02,
              ),
              CustomTitleText(
                text: 'Categories',
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                alignment: Alignment.topLeft,
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              CategoriesCardList(),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Expanded(child: ProductCardList()),
            ],
          ),
        ),
      ),
    );
  }
}
