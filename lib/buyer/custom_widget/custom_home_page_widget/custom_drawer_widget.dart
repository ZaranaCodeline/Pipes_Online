import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pipes_online/buyer/buyer_common/b_image.dart';
import 'package:pipes_online/buyer/screens/add_reviews_page.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/bottom_bar_screen_page.dart';
import 'package:pipes_online/buyer/screens/help_center_page.dart';
import 'package:pipes_online/buyer/screens/terms_condition_page.dart';
import 'package:pipes_online/buyer/view_model/b_drawer_controller.dart';
import 'package:sizer/sizer.dart';

import '../../app_constant/app_colors.dart';
import '../../authentificaion/functions.dart';
import '../../screens/b_authentication_screen/b_welcome_screen.dart';
import '../../screens/b_review_screen.dart';
import '../../screens/home_screen_widget.dart';
import '../../screens/my_order_page.dart';
import '../../screens/drawer_profile_page.dart';
import '../../screens/personal_info_page.dart';
import '../../screens/settings_page.dart';

class CustomDrawerWidget extends StatefulWidget {
  const CustomDrawerWidget({Key? key}) : super(key: key);

  @override
  State<CustomDrawerWidget> createState() => _CustomDrawerWidgetState();
}

class _CustomDrawerWidgetState extends State<CustomDrawerWidget> {
  BDrawerController bDrawerController = Get.put(BDrawerController());
  TextEditingController _address =
      TextEditingController(text: 'Yogichowk, Varacha, Surat',);
  final name = 'Jan Doe';
  final phone = '+00 0000000000';
  final urlImage =
      'https://firebasestorage.googleapis.com/v0/b/pipesonline-b2a41.appspot.com/o/cat_1.png?alt=media&token=a8b761df-c503-466b-baf3-d4ef73d5650d';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.drawerColor,
      child: GetBuilder<BDrawerController>(
        builder: (controller) {
          return Container(
            height: Get.height,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                    padding: EdgeInsets.symmetric(horizontal: 5.sp),
                    height: Get.height * 0.06,
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
                            width: 15.sp,
                            height: 15.sp,
                          ),
                          SizedBox(width: 5.sp),
                          Flexible(
                            child: Container(
                                // color: Colors.red,
                                height: Get.height * 0.06,
                                // width: Get.width * 0.9,
                                alignment: Alignment.centerLeft,
                                child: TextFormField(
                                  readOnly: controller.readOnly,
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
                              size: 15.sp,
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
            Get.to(() => PersonalInfoPage());
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
                  width: Get.height / 50,
                ),
                Padding(
                  padding:  EdgeInsets.all(5.0.sp),
                  child: CircleAvatar(
                      radius: 30, backgroundImage: NetworkImage(urlImage,),),
                ),
                SizedBox(width: Get.width / 20),
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
                            fontWeight: FontWeight.w400),
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
                SvgPicture.asset('assets/images/svg/dots.svg',width: 15.sp,height: 15.sp,),
              ],
            ),
          ));

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
        Get.to(() => SettingsPage());
        break;
      case 2:
        Get.to(() => MyOrderPage());
        break;
      case 3:
        Get.to(() => BReviewScreen());
        break;

      case 4:
        Get.to(() => HelpCenterPage());
        break;

      case 5:
        Get.to(() => TermsAndConditionPage());
        break;
      case 6:
        Get.to(() => signOut());
        break;
    }
  }
}
