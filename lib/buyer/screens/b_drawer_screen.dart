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
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/b_navigationbar.dart';
import 'package:pipes_online/buyer/screens/help_center_page.dart';
import 'package:pipes_online/buyer/screens/terms_condition_page.dart';
import 'package:pipes_online/buyer/view_model/b_drawer_controller.dart';
import 'package:pipes_online/s_onboarding_screen/s_buyer_seller_screen.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';

import '../app_constant/app_colors.dart';
import '../view_model/geolocation_controller.dart';
import 'b_my_order_page.dart';
import 'b_review_info_screen.dart';
import 'b_settings_page.dart';
import 'bottom_bar_screen_page/widget/b_personal_info_bottom_bar_route.dart';

class CustomDrawerWidget extends StatefulWidget {
  CustomDrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawerWidget> createState() => _CustomDrawerWidgetState();
}

class _CustomDrawerWidgetState extends State<CustomDrawerWidget> {
  BDrawerController bDrawerController = Get.put(BDrawerController());
  GeolocationController _controller = Get.find();
  TextEditingController? _address;

  CollectionReference ProfileCollection = bFirebaseStore.collection('BProfile');
  String? name;
  String? phoneNo;
  String? Img;
  String? address;

  Future<void> getData() async {
    print('demo seller.....');
    final user =
        await ProfileCollection.doc('${PreferenceManager.getUId()}').get();
    Map<String, dynamic>? getUserData = user.data() as Map<String, dynamic>?;

    setState(() {
      name = getUserData?['user_name'];
      phoneNo = getUserData?['phoneno'];
      Img = getUserData?['imageProfile'];
      address = getUserData?['address'];
    });
    /*print('=======SDrawerScreen=======${getUserData}');
    print('=======SDrawerScreen===========${user.get('$name')}');
    print('=======SDrawerScreen=======${user.get('$phoneNo')}');
    print('=======SDrawerScreen=======${user.get('$Img')}');
    print('=======SDrawerScreen======${user.get('$address')}');*/
  }

  // Future<void> getData() async {
  //   print('demo.....');
  //   final user =
  //       await ProfileCollection.doc('${FirebaseAuth.instance.currentUser?.uid}')
  //           .get();
  //   Map<String, dynamic>? getUserData = user.data() as Map<String, dynamic>?;
  //
  //   setState(() {
  //     name = getUserData?['user_name'];
  //     phoneNo = getUserData?['phoneno'];
  //     Img = getUserData?['imageProfile'];
  //     address = getUserData?['address'];
  //   });
  //   print('============================${user.get('imageProfile')}');
  // }

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
              children: <Widget>[
                builtTopItem(
                  urlImage: Img.toString(),
                  name: name.toString(),
                  phone: phoneNo.toString(),
                  onClicked: () {
                    ///TODO
                    // homeController.selectedScreen('SPersonalInfoPage');
                    // homeController.bottomIndex.value = 3;
                    // Get.to(() => PersonalInfoPage());
                  },
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 15.sp,
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 5.sp, vertical: 0.sp),
                  height: Get.height * 0.07,
                  // width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.sp),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          BImagePick.DrawerLocationIcon,
                          width: 18.sp,
                          height: 18.sp,
                        ),
                        SizedBox(width: 5.sp),
                        Flexible(
                          child: Container(
                            // color: Colors.red,
                            height: Get.height * 0.07,
                            // width: Get.width * 0.9,
                            alignment: Alignment.centerLeft,
                            child: TextFormField(
                              readOnly: bDrawerController.readOnly,
                              // controller: _address,
                              cursorColor: AppColors.primaryColor,
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: address),
                            ),
                          ),
                        ),
                        // Text('Yogichowk, Varachha, Surat'),
                        IconButton(
                          onPressed: () {
                            ///TODO
                            // controller.setEdit();
                            // homeController.selectedScreen('SPersonalInfoPage');
                            // homeController.bottomIndex.value = 3;
                          },
                          icon: Icon(
                            controller.readOnly == true
                                ? Icons.edit_outlined
                                : Icons.clear,
                            color: AppColors.primaryColor,
                            size: 14.sp,
                          ),
                        )
                      ]),
                ),
                buildMenuItem(
                  text: 'Home',
                  icon: Icons.home_outlined,
                  onClicked: () => selectedItem(context, 0),
                ),
                buildMenuItem(
                    text: 'Orders',
                    icon: Icons.border_left_outlined,
                    onClicked: () => selectedItem(context, 1)),
                buildMenuItem(
                    text: 'Earnings',
                    icon: Icons.currency_rupee_outlined,
                    onClicked: () => selectedItem(context, 2)),
                buildMenuItem(
                    text: 'Insight',
                    icon: Icons.insights_outlined,
                    onClicked: () => selectedItem(context, 3)),
                buildMenuItem(
                    text: 'Subscribe',
                    icon: Icons.settings_outlined,
                    onClicked: () => selectedItem(context, 4)),
                buildMenuItem(
                    text: 'Settings',
                    icon: Icons.reviews_outlined,
                    onClicked: () => selectedItem(context, 5)),
                buildMenuItem(
                    text: 'Reviews',
                    icon: Icons.reviews_outlined,
                    onClicked: () => selectedItem(context, 6)),
                buildMenuItem(
                    text: 'Terms & Conditions',
                    icon: Icons.pages_outlined,
                    onClicked: () => selectedItem(context, 7)),
                buildMenuItem(
                    text: 'Logout',
                    icon: Icons.logout,
                    onClicked: () => selectedItem(context, 8)),
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
            bottomBarIndexController.setSelectedScreen(
                value: 'PersonalInfoPage');
            bottomBarIndexController.bottomIndex.value = 3;
            // Get.to(() => PersonalInfoPage());
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
          ));

  Widget buildMenuItem(
      {required String text, required IconData icon, VoidCallback? onClicked}) {
    final color = AppColors.commonWhiteTextColor;
    final hoverColor = Colors.white70;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
      child: ListTile(
        leading: Icon(
          icon,
          size: 13.sp,
          color: color,
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
        // PreferenceManager.clearData();
        BRegisterRepo.bLogOut;
        logOutFormGoogle()
            // BAuthMethods.logOut()
            .then((value) => Get.off(() => SBuyerSellerScreen()));

        break;
    }
  }
}
