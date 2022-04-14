import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/routes/bottom_controller.dart';
import 'package:sizer/sizer.dart';
import 's_selected_product_screen.dart';

class SProductCardList extends StatefulWidget {
   SProductCardList({Key? key, this.name, this.price, this.image, this.desc}) : super(key: key);
final String? name,price,image,desc;
  @override
  State<SProductCardList> createState() => _SProductCardListState();
}

class _SProductCardListState extends State<SProductCardList> {
BottomController _bottomController=Get.find();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        height: Get.height * 3.sp,
        padding: EdgeInsets.symmetric(horizontal: 0.sp),
        child:
        StreamBuilder<QuerySnapshot>(
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
