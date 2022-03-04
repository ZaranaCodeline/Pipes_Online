import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pipes_online/app_constant/app_colors.dart';
import 'package:pipes_online/screens/welcome_page.dart';

import '../../screens/home_screen_widget.dart';
import '../../screens/my_order_page.dart';
import '../../screens/profile_page.dart';
import '../../screens/settings_page.dart';

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = 'Jan Doe';
    final phone = '+00 0000000000';
    final urlImage =
        'https://firebasestorage.googleapis.com/v0/b/pipesonline-b2a41.appspot.com/o/cat_1.png?alt=media&token=a8b761df-c503-466b-baf3-d4ef73d5650d';

    return Drawer(
      backgroundColor: AppColors.primaryColor,
      child: ListView(
        children: <Widget>[
          builtTopItem(
            urlImage: urlImage,
            name: name,
            phone: phone,
            onClicked: ()=> Get.to(()=>ProfilePage()),
          ),
          buildMenuItem(
              text: 'Home',
              icon: Icons.home_outlined,
              onClicked: () => selectedItem(context, 0),),
          buildMenuItem(
              text: 'Settings',
              icon: Icons.settings_outlined,
              onClicked: () => selectedItem(context, 1)),
          buildMenuItem(
              text: 'My Orders',
              icon: Icons.message_outlined,
              onClicked: () => selectedItem(context, 2)),
          buildMenuItem(
              text: 'Profile',
              icon: Icons.person_outline,
              onClicked: () => selectedItem(context, 3)),
          buildMenuItem(
              text: 'Invite Friends',
              icon: Icons.person_add_alt_1_outlined,
              onClicked: () => selectedItem(context, 4)),
          buildMenuItem(
              text: 'About Us',
              icon: Icons.messenger_outline,
              onClicked: () => selectedItem(context, 5)),
          buildMenuItem(
              text: 'Logout',
              icon: Icons.logout,
              onClicked: () => selectedItem(context, 6)),
        ],
      ),
    );
  }

  Widget builtTopItem({
    required String urlImage,
    required String name,
    required String phone,
    required VoidCallback onClicked,
  }) =>
      GestureDetector(
        onTap: onClicked,
        child:  Container(
          margin: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            color: AppColors.commonWhiteTextColor
          ),
          height: Get.height / 9,
          width: Get.width / 1.4,
          child:
          Row(
            children: [
              SizedBox(height: Get.height * 0.1,width: Get.height /50,),
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height * 0.02,),
                  Text(
                    name,
                    style:GoogleFonts.nunito(textStyle: TextStyle(fontSize: 22,color: AppColors.secondaryBlackColor,fontWeight: FontWeight.w400),),
                  ),
                  SizedBox(height: Get.height * 0.01,),

                  Text(
                    phone,
                    style: TextStyle(fontSize: 14, color:AppColors.secondaryBlackColor),
                  ),
                ],
              ),
              Spacer(),
              SvgPicture.asset('assets/images/dots.svg'),
            ],
          ),
        )

      );

  Widget buildMenuItem(
      {required String text, required IconData icon, VoidCallback? onClicked}) {
    final color = AppColors.commonWhiteTextColor;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: GoogleFonts.nunito(textStyle: TextStyle(fontSize: 24,color: color,fontWeight: FontWeight.w400)),
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        Get.to(()=>HomePage());
        break;
      case 1:
        Get.to(()=>SettingsPage());
        break;
      case 2:
        Get.to(()=>MyOrderPage());
        break;
      // case 3:
      //   Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) =>  ProfilePage(),
      //   ));
      //   break;
      // case 4:
      //   Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => InviteFriendPage(),
      //   ));
      //   break;
      // case 5:
      //   Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => AboutPage(),
      //   ));
      //   break;
      // case 6:
      //   Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => LogoutPage(),
      //   ));
      //   break;
    }
  }
}
