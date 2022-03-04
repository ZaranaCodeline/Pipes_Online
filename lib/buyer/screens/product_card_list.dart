import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/view_model/b_bottom_bar_controller.dart';
import 'package:sizer/sizer.dart';
import '../custom_widget/custom_home_page_widget/custom_product_card.dart';
import 'selected_product_widget.dart';

class ProductCardList extends StatefulWidget {
  ProductCardList({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductCardList> createState() => _ProductCardListState();
}

class _ProductCardListState extends State<ProductCardList> {
  BBottomBarIndexController bottomBarIndexController =
      Get.put(BBottomBarIndexController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // height: Get.height * 5.sp,
        padding: EdgeInsets.symmetric(horizontal: 8.sp),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("Products").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              List<DocumentSnapshot> products = snapshot.data!.docs;
              return SingleChildScrollView(
                child:
                GridView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: products.length,
                  scrollDirection: Axis.vertical,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
  }
}
