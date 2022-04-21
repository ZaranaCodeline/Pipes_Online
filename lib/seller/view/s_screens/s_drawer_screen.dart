import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/screens/b_personal_info_page.dart';
import 'package:pipes_online/buyer/view_model/geolocation_controller.dart';
import 'package:pipes_online/routes/bottom_controller.dart';
import 'package:pipes_online/seller/Authentication/s_function.dart';
import 'package:pipes_online/seller/view/s_screens/s_earning_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_home_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_order_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_prosonal_info_page.dart';
import 'package:pipes_online/seller/view/s_screens/s_review_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_settings_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_subscribe_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_terms_and_condition_screen.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';
import '../../../buyer/app_constant/app_colors.dart';
import '../../../buyer/app_constant/b_image.dart';
import '../../../s_onboarding_screen/s_buyer_seller_screen.dart';
import '../../view_model/s_drawer_controller.dart';
import 's_insight_screen.dart';

class SDrawerScreen extends StatefulWidget {
  const SDrawerScreen({Key? key}) : super(key: key);
  @override
  State<SDrawerScreen> createState() => _SDrawerScreenState();
}

class _SDrawerScreenState extends State<SDrawerScreen> {
  SDrawerController sDrawerController = Get.put(SDrawerController());
  // GeolocationController _controller = Get.find();
  // TextEditingController? _address;

  CollectionReference ProfileCollection = bFirebaseStore.collection('SProfile');
  String? name;
  String? phoneNo;
  String? Img;
  String? address;
  BottomController homeController = Get.find();

  Future<void> getData() async {
    print('demo seller.....');
    final user =
    await ProfileCollection.doc('${FirebaseAuth.instance.currentUser!.uid}')
        .get();
    Map<String, dynamic>? getUserData = user.data() as Map<String, dynamic>?;
    name = getUserData!['firstname'];
    phoneNo = getUserData['phoneno'];
    Img = getUserData['imageProfile'];
    address = getUserData['address'];

    setState(() {
      Img = getUserData['imageProfile'];
      address = getUserData['address'];
    });
    print('=======SDrawerScreen=======${getUserData}');
    print('=======SDrawerScreen===========${user.get('$name')}');
    print('=======SDrawerScreen=======${user.get('$phoneNo')}');
    print('=======SDrawerScreen=======${user.get('$Img')}');
    print('=======SDrawerScreen======${user.get('$address')}');
  }

  @override
  void initState() {
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    print('image:-${name}');
    print('firstname:-${phoneNo}');
    print('phoneno:-${Img}');
    print('address:-${address}');

    return Drawer(
      backgroundColor: AppColors.drawerColor,
      child: GetBuilder<SDrawerController>(
        builder: (controller){
          return Center(
            child: ListView(
              children: <Widget>[
                builtTopItem(
                  urlImage: Img.toString(),
                  name: name.toString(),
                  phone:phoneNo.toString(),
                  onClicked: () => Get.to(() => PersonalInfoPage()),

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
                                // controller: _address,
                                cursorColor: AppColors.primaryColor,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                hintText: address),

                              ),),
                        ),
                        // Text('Yogichowk, Varachha, Surat'),
                        IconButton(
                          onPressed: () {
                            // controller.setEdit();
                            homeController.selectedScreen('SPersonalInfoPage');
                            homeController.bottomIndex.value=0;
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
            Get.to(() => SPersonalInfoPage());
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
        SAuthMethods.logOut().then((value) =>
            Get.off(()=>SBuyerSellerScreen()));
        PreferenceManager.clearData();

        break;
    }
  }
}
