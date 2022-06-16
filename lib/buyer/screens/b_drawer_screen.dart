import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/app_constant/b_image.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/register_repo.dart';
import 'package:pipes_online/buyer/screens/b_personal_info_page.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/b_navigationbar.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/widget/b_cart_bottom_bar_route.dart';
import 'package:pipes_online/buyer/screens/help_center_page.dart';
import 'package:pipes_online/buyer/screens/terms_condition_page.dart';
import 'package:pipes_online/buyer/view_model/b_drawer_controller.dart';
import 'package:pipes_online/s_onboarding_screen/s_buyer_seller_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_image.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';

import '../app_constant/app_colors.dart';
import 'b_my_order_page.dart';
import 'b_review_info_screen.dart';
import 'b_settings_page.dart';

class CustomDrawerWidget extends StatefulWidget {
  CustomDrawerWidget({
    Key? key,
  }) : super(key: key);
  @override
  State<CustomDrawerWidget> createState() => _CustomDrawerWidgetState();
}

class _CustomDrawerWidgetState extends State<CustomDrawerWidget> {
  BDrawerController bDrawerController = Get.put(BDrawerController());
  TextEditingController? _address;

  CollectionReference ProfileCollection = bFirebaseStore.collection('BProfile');
  String? name;
  String? phoneNo;
  String? Img;
  String? address;

  Future<void> getData() async {
    print('demo buyer.....');
    final user =
        await ProfileCollection.doc('${PreferenceManager.getUId()}').get();
    Map<String, dynamic>? getUserData = user.data() as Map<String, dynamic>?;

    setState(() {
      name = getUserData?['user_name'];
      phoneNo = getUserData?['phoneno'];
      Img = getUserData?['imageProfile'];
      address = getUserData?['address'];
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.drawerColor,
      child: GetBuilder<BDrawerController>(
        builder: (controller) {
          return Center(
            child: ListView(
              children: [
                InkWell(
                  onTap: () {
                    bottomBarIndexController.setSelectedScreen(
                        value: 'PersonalInfoPage');
                    bottomBarIndexController.bottomIndex.value = 3;

                    // Get.to(PersonalInfoPage(
                    //   isBottomBarVisible: true,
                    // ));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: 18.sp, vertical: 18.sp),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: AppColors.commonWhiteTextColor),
                    height: Get.height * 0.1,
                    width: Get.width / 1.5,
                    child: Row(
                      children: [
                        SizedBox(
                          height: Get.height * 0.1,
                        ),
                        Img != null
                            ? Container(
                                width: 35.sp,
                                height: 35.sp,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    Img ?? '',
                                    fit: BoxFit.fill,
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return Image.asset(
                                        BImagePick.cartIcon,
                                        height: Get.height * 0.1,
                                        width: Get.width * 0.4,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                ),
                              )
                            : Container(
                                width: 35.sp,
                                height: 35.sp,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: SvgPicture.asset(''),
                                ),
                              ),
                        SizedBox(width: Get.width * 0.02),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              /*   snapShot.data!.docs[index]
                                      ['user_name'] ??*/
                              name ?? '',
                              style: GoogleFonts.ubuntu(
                                textStyle: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColors.secondaryBlackColor,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.005,
                            ),
                            Text(
                              /*  snapShot.data?.docs[index]['phoneno'] ??*/
                              phoneNo ?? '',
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColors.secondaryBlackColor),
                            ),
                          ],
                        ),
                        Spacer(),
                        SvgPicture.asset(
                          'assets/images/svg/dots.svg',
                          width: 15.sp,
                          height: 15.sp,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: Get.height,
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 15.sp,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 5.sp),
                          height: Get.height * 0.09,
                          // width: Get.width,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.sp),
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset(
                                  BImagePick.DrawerLocationIcon,
                                  width: 14.sp,
                                  height: 14.sp,
                                ),
                                SizedBox(width: 5.sp),
                                Flexible(
                                  child: Container(
                                    // height: Get.height * 0.07,
                                    alignment: Alignment.centerLeft,
                                    child: TextFormField(
                                      readOnly: controller.readOnly,
                                      controller: _address,
                                      cursorColor: AppColors.primaryColor,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: address),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    bottomBarIndexController.setSelectedScreen(
                                        value: 'PersonalInfoPage');
                                    bottomBarIndexController.bottomIndex.value =
                                        3;

                                    // bottomBarIndexController.setSelectedScreen(
                                    //     value: 'PersonalInfoPage');
                                    // bottomBarIndexController.bottomIndex.value =
                                    //     3;
                                    // Get.to(PersonalInfoPage(
                                    //   isBottomBarVisible: true,
                                    // ));
                                  },
                                  icon: Icon(
                                    controller.readOnly == true
                                        ? Icons.edit_outlined
                                        : Icons.clear,
                                    color: AppColors.primaryColor,
                                    size: 12.sp,
                                  ),
                                )
                              ]),
                        ),
                        SizedBox(height: Get.height * 0.01),
                        buildMenuItem(
                          text: 'Home',
                          imageName: BImagePick.homeIcon,
                          onClicked: () => selectedItem(context, 0),
                        ),
                        // SizedBox(height: Get.height * 0.005),
                        buildMenuItem(
                          text: 'Settings',
                          imageName: BImagePick.settingIcon,
                          onClicked: () => selectedItem(context, 1),
                        ),
                        // SizedBox(height: Get.height * 0.01),
                        buildMenuItem(
                          text: 'My Orders',
                          imageName: BImagePick.MyOrderIcon,
                          onClicked: () => selectedItem(context, 2),
                        ),
                        // SizedBox(height: Get.height * 0.01),
                        buildMenuItem(
                          text: 'Reviews',
                          imageName: BImagePick.ReviewsIcon,
                          onClicked: () => selectedItem(context, 3),
                        ),
                        // SizedBox(height: Get.height * 0.01),
                        buildMenuItem(
                          text: 'Help Center',
                          imageName: BImagePick.HelpCenterIcon,
                          onClicked: () => selectedItem(context, 4),
                        ),
                        // SizedBox(height: Get.height * 0.01),
                        buildMenuItem(
                          text: 'Terms & Conditions',
                          imageName: BImagePick.TermsAndConditionIcon,
                          onClicked: () => selectedItem(context, 5),
                        ),
                        // SizedBox(height: Get.height * 0.01),
                        buildMenuItem(
                          text: 'Logout',
                          imageName: BImagePick.LogOutIcon,
                          onClicked: () => selectedItem(context, 6),
                        ),
                        // SizedBox(
                        //   height: Get.height * 0.05,
                        // )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget builtTopItem({
    required String urlImage,
    required String name,
    required String phone,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: () {
          bottomBarIndexController.setSelectedScreen(value: 'PersonalInfoPage');
          bottomBarIndexController.bottomIndex.value = 3;
          // Get.to(PersonalInfoPage(
          //   isBottomBarVisible: true,
          // ));
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 18.sp),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColors.commonWhiteTextColor),
          height: Get.height * 0.09,
          width: Get.width / 1.5,
          child: Row(
            children: [
              SizedBox(
                height: Get.height * 0.1,
              ),
              Padding(
                padding: EdgeInsets.all(5.0.sp),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    urlImage,
                  ),
                ),
              ),
              SizedBox(width: Get.width * 0.02),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.ubuntu(
                      textStyle: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.secondaryBlackColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.005,
                  ),
                  Text(
                    phone,
                    style: TextStyle(
                        fontSize: 12.sp, color: AppColors.secondaryBlackColor),
                  ),
                ],
              ),
              Spacer(),
              SvgPicture.asset(
                'assets/images/svg/dots.svg',
                width: 15.sp,
                height: 15.sp,
              ),
            ],
          ),
        ),
      );

  Widget buildMenuItem(
      {required String text,
      required String imageName,
      VoidCallback? onClicked}) {
    final color = AppColors.commonWhiteTextColor;
    final hoverColor = Colors.white70;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
      child: ListTile(
        leading: SvgPicture.asset(
          imageName,
          width: 15.sp,
          height: 15.sp,
        ),
        minLeadingWidth: 14.sp,
        title: Text(
          text,
          style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                  fontSize: 13.sp, color: color, fontWeight: FontWeight.w400)),
        ),
        hoverColor: hoverColor,
        onTap: onClicked,
      ),
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Get.to(() => BottomNavigationBarScreen());
        break;
      case 1:
        Get.to(() => BSettingsScreen());
        break;
      case 2:
        Get.to(() => BMyOrderPage());
        break;
      case 3:
        Get.to(() => BReviewInfoScreen());
        break;
      case 4:
        Get.to(() => HelpCenterPage());
        break;

      case 5:
        Get.to(() => TermsAndConditionPage());
        break;
      case 6:
        FirebaseAuth.instance.signOut();
        logOutFormGoogle().then((value) => Get.off(() => SBuyerSellerScreen()));
        PreferenceManager.clearData();
        BRegisterRepo.bLogOut;
        logOutFormGoogle().then((value) => Get.off(SBuyerSellerScreen()));
        break;
    }
  }
}
