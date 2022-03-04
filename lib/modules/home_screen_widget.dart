import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/app_constant/app_colors.dart';

import '../custom_widget/custom_home_page_widget/custom_home_search_widget.dart';
import '../custom_widget/custom_home_page_widget/custom_drawer_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
          margin: EdgeInsets.only(bottom: Get.height / 8,right: Get.height / 30),
          child: Drawer()),
      appBar: AppBar(
        actions: [
          Container(
            margin: EdgeInsets.only(bottom: Get.height / 8,right: Get.height / 30),
              child: Icon(
            Icons.shopping_cart_outlined,
          ))
        ],
        flexibleSpace: FlexibleSpaceBar(
          background: Column(
            children: [
              SizedBox(
                height: Get.height / 6,
              ),
              CustomHomeSearchWidget(),
            ],
          ),
        ),
        foregroundColor: Colors.white,
        backgroundColor: AppColors.primaryDarkColor,
        title: Container(
          margin: EdgeInsets.only(bottom: Get.height / 8),
          child: Text('title'),
        ),
        centerTitle: true,
        toolbarHeight: 160.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
      ),
      body: Container(),
    );
  }
}
