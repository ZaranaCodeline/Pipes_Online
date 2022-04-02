import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pipes_online/seller/Authentication/s_function.dart';
import 'package:pipes_online/seller/view/s_screens/s_earning_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_home_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_order_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_review_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_settings_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_subscribe_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_terms_and_condition_screen.dart';
import 'package:sizer/sizer.dart';
import '../../../buyer/app_constant/app_colors.dart';
import '../../../buyer/authentificaion/b_functions.dart';
import '../../../buyer/buyer_common/b_image.dart';
import '../../../buyer/screens/drawer_profile_page.dart';
import '../../controller/s_drawer_controller.dart';
import 's_insight_screen.dart';

class SDrawerScreen extends StatefulWidget {
  const SDrawerScreen({Key? key}) : super(key: key);

  @override
  State<SDrawerScreen> createState() => _SDrawerScreenState();
}

class _SDrawerScreenState extends State<SDrawerScreen> {
  SDrawerController sDrawerController = Get.put(SDrawerController());

  @override
  Widget build(BuildContext context) {
    TextEditingController _address =
    TextEditingController(text: 'Yogichowk, Varacha, Surat');

    final name = 'Jan Doe';
    final phone = '+00 0000000000';
    final urlImage =
        'https://firebasestorage.googleapis.com/v0/b/pipesonline-b2a41.appspot.com/o/cat_1.png?alt=media&token=a8b761df-c503-466b-baf3-d4ef73d5650d';

    return Drawer(
      backgroundColor: AppColors.drawerColor,
      child: GetBuilder<SDrawerController>(
        builder: (controller){
          return Center(
            child: ListView(
              children: <Widget>[
                builtTopItem(
                  urlImage: urlImage,
                  name: name,
                  phone: phone,
                  onClicked: () => Get.to(() => DrawerProfilePage()),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 15.sp,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 5.sp,vertical: 0.sp),
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
                                readOnly: sDrawerController.readOnly,
                                controller: _address,
                                cursorColor: AppColors.primaryColor,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              )),
                        ),
                        // Text('Yogichowk, Varachha, Surat'),
                        IconButton(
                          onPressed: () {
                            controller.setEdit();
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
            Get.to(() => DrawerProfilePage());
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 18.sp, vertical: 15.sp),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.sp),
                color: AppColors.commonWhiteTextColor),
            height: Get.height / 8.sp,
            width: Get.width / 1.4.sp,
            child: Row(
              children: [
                SizedBox(
                  height: Get.height * 0.1,
                  width: Get.height / 50.sp,
                ),
                CircleAvatar(
                    radius: 30, backgroundImage: NetworkImage(urlImage)),
                SizedBox(width: Get.width / 25.sp),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: Get.height * 0.01.sp,
                    ),
                    Text(
                      name,
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.secondaryBlackColor,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01.sp,
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

    return ListTile(
      leading: Icon(
        icon,
        size: 13.sp,
        color: color,
      ),
      title: Text(
        text,
        style: GoogleFonts.ubuntu(
            textStyle: TextStyle(
                fontSize: 13.sp, color: color, fontWeight: FontWeight.w400)),
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Get.to(() => SHomeScreen());
        break;
      case 1:
        Get.to(() => SOrdersScreen());
        break;
      case 2:
        Get.to(() => SEarningsScreen());
        break;
      case 3:
        Get.to(() => SInsightScreen());
        break;

      case 4:
        Get.to(() => SSubscribeScreen());
        break;

      case 5:
        Get.to(() => SSettingsScreen());
        break;

      case 6:
        Get.to(() => SReviewScreen());
        break;
      case 7:
        Get.to(() => STermsAndConditions());
        break;
      case 8:
        Get.to(() => SAuthMethods().signInWithGoogle(context));
        break;
    }
  }
}
