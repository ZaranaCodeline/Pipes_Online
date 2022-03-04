import 'package:flutter/material.dart';

import '../../app_constant/app_colors.dart';

Widget CustomNavigationbarItems(){
  return  Container(
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.offLightPurpalColor, width: 1,  ),
      // borderRadius: const BorderRadius.vertical(
      //   top: Radius.circular(25),
      // ),
    ),
    child: BottomNavigationBar(
      backgroundColor: AppColors.commonWhiteTextColor,
      selectedItemColor: AppColors.primaryColor,
      unselectedItemColor:AppColors.offLightPurpalColor,
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
