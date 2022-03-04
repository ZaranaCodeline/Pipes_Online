import 'package:flutter/material.dart';

import '../../../app_constant/app_colors.dart';

Widget CustomNavigationbarItems(){
  return  Container(
    padding: EdgeInsets.only(top: 5,left: 4,right: 4),

    decoration: const BoxDecoration(
      // border: Border.all(color: AppColors.offLightPurpalColor, width: 0,  ),
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15),
      ),
    ),
    child: BottomNavigationBar(
      backgroundColor: AppColors.commonWhiteTextColor,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor:AppColors.offLightPurpalColor,
      elevation: 7,
      // onTap: (){},
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
