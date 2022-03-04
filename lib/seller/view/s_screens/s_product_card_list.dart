import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/routes/bottom_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../buyer/custom_widget/custom_home_page_widget/custom_product_card.dart';
import '../../../buyer/screens/selected_product_widget.dart';
import 's_selected_product_screen.dart';

class SProductCardList extends StatelessWidget {
   SProductCardList({Key? key}) : super(key: key);
BottomController _bottomController=Get.find();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        height: Get.height * 4.sp,
        padding: EdgeInsets.symmetric(horizontal: 0.sp),
        child: StreamBuilder<QuerySnapshot>(
          stream:
          FirebaseFirestore.instance.collection("Products").snapshots(),
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
                  gridDelegate:   SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.sp,
                    crossAxisSpacing: 10.sp,
                    childAspectRatio: 3/4,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        // _bottomController.selectedScreen('SSelectedProductScreen');
                        // _bottomController.bottomIndex.value=0;
                        Get.to(()=>
                            SSelectedProductScreen(
                              image:products[index].get("image"),
                              name: products[index].get("name"),
                              desc: products[index].get("desc"),
                              price: products[index].get("price"),
                            ),
                        );

                      },
                      child:CustomProductCard(
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
