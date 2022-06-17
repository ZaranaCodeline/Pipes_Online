import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/screens/b_category_detail_page.dart';
import 'package:pipes_online/routes/bottom_controller.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../view_model/b_bottom_bar_controller.dart';
import 'custom_widget/common_category_card.dart';

class CategoriesCardList extends StatelessWidget {
  const CategoriesCardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BBottomBarIndexController bottomBarIndexController = Get.find();
    BottomController _bottomController = Get.find();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.sp),
      height: Get.height * 0.1.sp,
      width: double.infinity,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Categories").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Shimmer.fromColors(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, snapshot) {
                  return Center(
                    child: Container(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10.sp,
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              width: Get.width * 0.35,
                              height: Get.height / 13,
                              // flex: 3,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5.sp,
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: snapshot.data?.docs.length,
              ),
              baseColor: Colors.grey.shade200,
              highlightColor: Colors.grey.shade300,
            );
          }
          if (snapshot.hasData) {
            List<DocumentSnapshot> categories = snapshot.data!.docs;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  categories.length,
                  (index) => GestureDetector(
                    onTap: () {
                      bottomBarIndexController.setSelectedScreen(
                          value: 'CategoriesCardList');
                      bottomBarIndexController.bottomIndex.value = 0;
                      print(
                          '----selectedScreen-- ${bottomBarIndexController.selectedScreen.value}');
                      bottomBarIndexController.setCategoriesType(
                          value: categories[index].get("name"));

                      bottomBarIndexController.setSelectedScreen(
                          value: 'HomeScreen');
                      bottomBarIndexController.bottomIndex.value = 0;

                      Get.to(BCategoryDetailsPage(
                        category: categories[index].get("name"),
                      ));
                    },
                    child: CommonCategoryCard(
                      image: categories[index].get("image"),
                      name: categories[index].get("name"),
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
