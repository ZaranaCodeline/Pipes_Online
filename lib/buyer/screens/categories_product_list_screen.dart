import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';

import 'package:pipes_online/buyer/view_model/b_bottom_bar_controller.dart';
import 'package:pipes_online/seller/common/s_text_style.dart';
import 'package:sizer/sizer.dart';
import '../custom_widget/custom_home_page_widget/custom_product_card.dart';
import 'selected_product_widget.dart';

class CategoriesProductListScreen extends StatefulWidget {
  @override
  _CategoriesProductListScreenState createState() =>
      _CategoriesProductListScreenState();
}

class _CategoriesProductListScreenState
    extends State<CategoriesProductListScreen> {
  BBottomBarIndexController bottomBarIndexController =
      Get.put(BBottomBarIndexController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        bottomBarIndexController.setSelectedScreen(value: 'HomeScreen');
        bottomBarIndexController.bottomIndex.value = 0;
        return Future.value(false);
      },
      child: GetBuilder<BBottomBarIndexController>(
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {
                    controller.setSelectedScreen(value: 'HomeScreen');
                    controller.bottomIndex.value = 0;
                  },
                  icon: Icon(Icons.arrow_back_rounded)),
              title: Text(
                '${controller.catName!.toUpperCase()}',
                style: STextStyle.bold700White14,
              ),
              backgroundColor: AppColors.primaryColor,
              toolbarHeight: Get.height * 0.1,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(25),
                ),
              ),
            ),
            body: Container(
              // height: Get.height * 5.sp,
              padding: EdgeInsets.symmetric(horizontal: 8.sp),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Products")
                    .where('categories',
                        isEqualTo: controller.catName!.toLowerCase())
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    List<DocumentSnapshot> products = snapshot.data!.docs;
                    print(
                        'snapshot.data!.docs----${products[0].get('categories').toString().toUpperCase()}');
                    print('controller----${controller.catName!.toUpperCase()}');

                    return SingleChildScrollView(
                      child: GridView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: products.length,
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 3 / 4,
                        ),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                () => SelectedProductWidget(
                                  image: products[index].get("image"),
                                  name: products[index].get("name"),
                                  desc: products[index].get("desc"),
                                  price: products[index].get("price"),
                                ),
                              );
                            },
                            child: CustomProductCard(
                              image: products[index].get("image"),
                              name: products[index].get("name"),
                              desc: products[index].get("desc"),
                              price: products[index].get("price"),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
