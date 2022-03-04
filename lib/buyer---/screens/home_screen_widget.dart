import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/screens/chat_page.dart';
import 'package:pipes_online/buyer/screens/personal_info_page.dart';
import '../app_constant/app_colors.dart';
import '../custom_widget/custom_home_page_widget/custom_drawer_widget.dart';
import '../custom_widget/custom_home_page_widget/custom_home_search_widget.dart';
import '../custom_widget/widgets/custom_widget/custom_navigationbar_items.dart';
import '../custom_widget/widgets/custom_widget/custom_text.dart';
import 'cart_page.dart';
import 'categories_card__list.dart';
import '../custom_widget/widgets/custom_widget/custom_title_text.dart';
import 'product_card_list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  static   List<Widget> _widgetOptions = <Widget>[
    CatelogHomeWidget(),
    CartPage(),
    ChatPage(),
    PersonalInfoPage(),
  ];
  PageController pageController = PageController();

  void onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.jumpToPage(index);
  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(



      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: AppColors.commonWhiteTextColor,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.offLightPurpalColor,
        elevation: 7,
        onTap: (value){
         setState(() {
           _selectedIndex = value;
         });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.border_all_outlined), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: ' '),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline), label: ' '),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: ' '),
        ],
      ),
    );
  }

}

class CatelogHomeWidget extends StatelessWidget {

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
          position: RelativeRect.fromLTRB(25.0, 0, 0, 25.0),
          //position where you want to show the menu on screen
          items: [
            const PopupMenuItem<String>(
                child: Text('Filter by KM'), value: '1'),
            PopupMenuItem<String>(
                child: Card(
                  elevation: 4,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                          width: 32,
                          height: 28,
                          // color: AppColors.primaryColor,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.primaryColor,
                          ),
                          child: Icon(
                            Icons.search,
                            size: 25,
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
            borderRadius: BorderRadius.circular(30),
          ));
    }
    return  Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.only(bottom: Get.height / 14),
          icon: SvgPicture.asset('assets/images/drawer_icon.svg'),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        actions: [
          Stack(
            children: [
              Container(
                color: AppColors.primaryColor,
                margin: EdgeInsets.only(
                    bottom: Get.height / 9,
                    top: 30,
                    right: Get.height / 30),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => CartPage());
                  },
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    size: 40,
                  ),
                ),
                // SvgPicture.asset('assets/images/cart_icon.svg',),
              ),
              Positioned(
                top: 29,
                left: 13,
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.commonWhiteTextColor,
                  ),
                  child: CustomText(
                    text: '3',
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.secondaryBlackColor,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
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
              text: 'PIPES ONLINE',
              fontSize: 24,
              fontWeight: FontWeight.w600,
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
      drawer: Container(
          child: const Drawer(
            child: CustomDrawerWidget(),
          )),
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
    );
  }
}
