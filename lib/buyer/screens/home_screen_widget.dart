import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../app_constant/app_colors.dart';
import '../custom_widget/custom_home_page_widget/custom_drawer_widget.dart';
import '../custom_widget/custom_home_page_widget/custom_home_search_widget.dart';
import '../custom_widget/widgets/custom_widget/custom_navigationbar_items.dart';
import '../custom_widget/widgets/custom_widget/custom_text.dart';
import 'categories_card__list.dart';
import '../custom_widget/widgets/custom_widget/custom_title_text.dart';
import 'product_card_list.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    _showPopupMenu() {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      //*get the global position, from the widget local position
      final offset = renderBox.localToGlobal(Offset.zero);

      //*calculate the start point in this case, below the button
      final left = offset.dx;
      final top = offset.dy + renderBox.size.height;
      //*The right does not indicates the width
      final right = left + renderBox.size.width;
      final bottom = offset.dx;
      showMenu<String>(
          context: context,
          position: RelativeRect.fromLTRB(left, 25, 25,0),
          //position where you want to show the menu on screen
          items: [
            const PopupMenuItem<String>(
                child: Text('menu option 1'), value: '1'),
            const PopupMenuItem<String>(
                child: Text('menu option 2'), value: '2'),
            const PopupMenuItem<String>(
                child: Text('menu option 3'), value: '3'),
          ],
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ));
    }

    return Scaffold(
      key: _scaffoldKey,
      drawer: Container(
          child: const Drawer(
        child: CustomDrawerWidget(),
      )),
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.only(bottom: Get.height / 14),
          icon: SvgPicture.asset('assets/images/drawer_icon.svg'),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        actions: [
          Container(
            color: AppColors.primaryColor,
            margin: EdgeInsets.only(
                bottom: Get.height / 9, top: 25, right: Get.height / 30),
            child: GestureDetector(
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 32,
              ),
            ),
            // SvgPicture.asset('assets/images/cart_icon.svg',),
          ),
        ],
        flexibleSpace: FlexibleSpaceBar(
          background: Column(
            children: [
              SizedBox(
                height: Get.height * 0.18,
              ),
              Row(
                children: [
                  const CustomHomeSearchWidget(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0.0),
                    child: GestureDetector(
                      onTap: () {
                        print('FILTER');
                        _showPopupMenu();
                        // CustomHoverPopupFilterWidget();
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 45,
                          height: 45,
                          color: AppColors.commonWhiteTextColor,
                          child: Icon(
                            Icons.filter_alt_outlined,
                            color: AppColors.primaryColor,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        foregroundColor: AppColors.commonWhiteTextColor,
        backgroundColor: AppColors.primaryColor,
        title: Container(
            padding: EdgeInsets.only(top: 35),
            margin: EdgeInsets.only(bottom: Get.height / 8),
            child: CustomText(
              text: 'Pipes Online',
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.commonWhiteTextColor,
            )),
        centerTitle: true,
        toolbarHeight: Get.height * 0.2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.01,
            ),
            CustomTitleText(
              text: 'Categories',
              fontSize: 27,
              fontWeight: FontWeight.w700,
              alignment: Alignment.topLeft,
            ),
            SizedBox(
              height: Get.height * 0.001,
            ),
            CategoriesCardList(),
            SizedBox(
              height: Get.height * 0.001,
            ),
            Expanded(child: ProductCardList()),
          ],
        ),
      ),
      bottomNavigationBar:CustomNavigationbarItems(),
    );
  }
}