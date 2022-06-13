import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/screens/b_product_cart_screen.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/widget/b_cart_bottom_bar_route.dart';
import 'package:pipes_online/buyer/view_model/b_profile_view_model.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';
import '../app_constant/app_colors.dart';
import 'b_categories_card_list.dart';
import 'b_drawer_screen.dart';
import 'custom_widget/custom_search_widget.dart';
import 'custom_widget/custom_text.dart';
import 'product_card_list.dart';

class CatelogeHomeWidget extends StatefulWidget {
  @override
  State<CatelogeHomeWidget> createState() => _CatelogeHomeWidgetState();
}

class _CatelogeHomeWidgetState extends State<CatelogeHomeWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  CollectionReference ProfileCollection = bFirebaseStore.collection('BProfile');
  BProfileViewModel _model = Get.find();

  Future<void> getData() async {
    print('demo seller.....');
    final user =
        await ProfileCollection.doc('${PreferenceManager.getUId()}').get();
    Map<String, dynamic>? getUserData = user.data() as Map<String, dynamic>?;

    setState(() {
      _model.firstnameController =
          TextEditingController(text: getUserData?['user_name'] ?? "");
      _model.phoneController =
          TextEditingController(text: getUserData?['phoneno'] ?? "");
      _model.emailController =
          TextEditingController(text: getUserData?['email'] ?? "");
      _model.addressController =
          TextEditingController(text: getUserData?['address'] ?? "");
      _model.image1 = getUserData?['imageProfile'] ?? "";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    print('--User Name ${PreferenceManager.getName()}');
    print('-- getUserImage  ${PreferenceManager.getUserImage()}');
    print('-- getAddress  ${PreferenceManager.getAddress()}');
    print('-- PhoneNumber  ${PreferenceManager.getPhoneNumber()}');
  }

  @override
  Widget build(BuildContext context) {
    _showPopupMenu() {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      final offset = renderBox.localToGlobal(Offset.zero);
      final left = offset.dx;
      final top = offset.dy + renderBox.size.height;
      final right = left + renderBox.size.width;
      final bottom = offset.dx;
      showMenu<String>(
          context: context,
          position: RelativeRect.fromLTRB(25.0, Get.height * 0.17, 0, 25.0),
          //position where you want to show the menu on screen
          items: [
            PopupMenuItem<String>(
                child: Text(
                  'Filter by KM',
                  style: TextStyle(fontSize: 12.sp),
                ),
                value: '1'),
            PopupMenuItem<String>(
                child: Card(
                  elevation: 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: '2 KM',
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                          color: AppColors.secondaryBlackColor,
                          textDecoration: TextDecoration.underline,
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
                            size: 20.sp,
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

    return WillPopScope(
      child: SafeArea(
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
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 1),
                        blurRadius: 11,
                        spreadRadius: 1)
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: Get.height * 0.07,
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
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
                        Container(
                            margin: EdgeInsets.only(
                                right: 10.sp, bottom: 5.sp, top: 5.sp),
                            child: Image.asset(
                              'assets/images/png/pipe_logo.png',
                              fit: BoxFit.cover,
                            )),
                        InkWell(
                          onTap: () {
                            // bottomBarIndexController.bottomIndex.value = 1;
                            // bottomBarIndexController.setSelectedScreen(
                            //     value: 'ProductCartScreen');
                            Get.to(() => ProductCartScreen());
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
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('Cart')
                                        .doc(PreferenceManager.getUId())
                                        .collection('MyCart')
                                        .snapshots(),
                                    builder: (context, snapShot) {
                                      if (snapShot.hasData) {
                                        print(
                                            '=====home_screen_cart_length=====${snapShot.data!.docs.length}');
                                        return CustomText(
                                          text: snapShot.data!.docs.length
                                              .toString(),
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.secondaryBlackColor,
                                          textAlign: TextAlign.center,
                                        );
                                      }
                                      return Container();
                                    },
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
                          CustomHomeSearchWidget(),
                          GestureDetector(
                            onTap: () {
                              print('FILTER');
                              _showPopupMenu();
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
            ),
          ),
          drawer: CustomDrawerWidget(),
          body: Column(
            children: [
              SizedBox(
                height: Get.height * 0.02,
              ),
              CustomTitleText(
                text: 'Categories',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
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
      onWillPop: () async {
        return true;
      },
    );
  }
}

class CustomTitleText extends StatelessWidget {
  CustomTitleText(
      {Key? key,
      required this.text,
      required this.fontWeight,
      required this.fontSize,
      required this.alignment})
      : super(key: key);

  String text;
  double fontSize;
  FontWeight fontWeight;
  Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text,
            style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                  color: AppColors.secondaryBlackColor,
                  fontSize: fontSize,
                  fontWeight: fontWeight),
            ),
          ),
          alignment: alignment,
        ),
      ],
    );
  }
}
