import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/screens/category_detail_page.dart';
import 'package:pipes_online/routes/bottom_controller.dart';
import 'package:sizer/sizer.dart';
import '../custom_widget/custom_home_page_widget/common_category_card.dart';
import '../view_model/b_bottom_bar_controller.dart';
import 'bottom_bar_screen_page/widget/home_bottom_bar_route.dart';

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
                          '---------selectedScreen--------- ${bottomBarIndexController.selectedScreen.value}');
                      bottomBarIndexController.setCategoriesType(
                          value: categories[index].get("name"));
                      _bottomController.selectedScreen('BCategoryDetailsPage');
                      _bottomController.bottomIndex.value=1;
                      // Get.to(()=>BCategoryDetailsPage());
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
