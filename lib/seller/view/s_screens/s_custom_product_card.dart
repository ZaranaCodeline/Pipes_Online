import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/seller/bottombar/widget/category_bottom_bar_route.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:pipes_online/seller/view/s_screens/s_add_product_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_selected_product_screen.dart';
import 'package:pipes_online/seller/view_model/s_add_product_controller.dart';
import 'package:pipes_online/seller/view_model/s_edit_product_controller.dart';
import 'package:sizer/sizer.dart';

class SCustomProductCard extends StatefulWidget {
  SCustomProductCard({Key? key}) : super(key: key);

  @override
  State<SCustomProductCard> createState() => _SCustomProductCardState();
}

class _SCustomProductCardState extends State<SCustomProductCard> {
  EditProductContoller editProductContoller = Get.put(EditProductContoller());
  FirebaseAuth _auth = FirebaseAuth.instance;
  String? proName, desc, price, image;

  // Future<void> getData() async {
  //   print('demo.....');
  //   final  user =
  //   await userCollection.doc('${FirebaseAuth.instance.currentUser!.uid}').get();
  //   Map<String, dynamic>? getUserData = user.data() as Map<String, dynamic>?;
  //   proName=getUserData!['firstname'];
  //   desc=getUserData['email'];
  //   price=getUserData['address'];
  //   image.text=getUserData['phoneno'];
  //   setState(() {
  //     Img=getUserData['imageProfile'];
  //   });
  //   print('============================${user.get('imageProfile')}');
  // }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.7,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Products').snapshots(),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapShot.connectionState == ConnectionState.done) {}
            return GridView.builder(
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 1.7 / 2),
                itemCount: snapShot.data!.docs.length,
                itemBuilder: (BuildContext context, index) {
                  return GestureDetector(
                    onTap: () {
                      print('gfvf');
                      print('DATA OF ID${snapShot.data!.docs[index].id}');

                      /*  editProductContoller.selectedName=proName.toString();
                      // editProductContoller.images=downloadUrl;
                      editProductContoller.selectedDesc=desc.toString();
                      editProductContoller.selectedPrice=editProductContoller.selectedPrice;
                      */
                      EditProductContoller editProductContoller =
                          Get.put(EditProductContoller());
                      print(
                          'prdName==>${editProductContoller.selectedName = snapShot.data!.docs[index]['prdName']}');
                      print(
                          'selectedPrice==>${editProductContoller.selectedPrice = editProductContoller.selectedPrice}');
                      print(
                          'selectedPrice====>${editProductContoller.selectedPrice = (snapShot.data!.docs[index]['price'])}');
                      // editProductContoller.selectedName =
                      //     (snapShot.data!.docs[index]['prdName']);
                      // editProductContoller.selectedName =
                      //     snapShot.data!.docs[index]['prdName'];
                      // // editProductContoller.selectedName;
                      // editProductContoller.images = editProductContoller.images;
                      // editProductContoller.selectedDesc =
                      //     editProductContoller.selectedDesc;
                      // // editProductContoller.selectedPrice =
                      // editProductContoller.selectedProductName(
                      //     snapShot.data!.docs[index]['prdName']);
                      //
                      // editProductContoller.selectedProductPrice(
                      //     snapShot.data!.docs[index]['price']);

                      editProductContoller
                          .selectedID(snapShot.data!.docs[index].id);

                      homeController.selectedScreen('SSelectedProductScreen');
                      homeController.bottomIndex.value = 0;
                      // Get.to(SSelectedProductScreen(
                      //   name: snapShot.data!.docs[index]['prdName'],
                      //   price: snapShot.data!.docs[index]['price'],
                      //   image: snapShot.data!.docs[index]['imageProfile'],
                      //   desc: snapShot.data!.docs[index]['dsc'],
                      //   id: snapShot.data!.docs[index].id,
                      // ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: Get.width * 0.4,
                        height: Get.height * 0.26,
                        decoration: BoxDecoration(
                            color: AppColors.commonWhiteTextColor,
                            borderRadius:
                                BorderRadius.circular(Get.width * 0.05),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 1,
                                color: SColorPicker.fontGrey,
                              )
                            ]),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                //width: Get.width * 0.35,height: Get.height*0.1,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(Get.width * 0.02),
                                  child: snapShot.data!.docs[index]
                                                  ['imageProfile'] ==
                                              null ||
                                          snapShot.data!.docs[index]
                                                  ['imageProfile'] ==
                                              ''
                                      ? Center(
                                          child: CircularProgressIndicator())
                                      : Image.network(
                                          snapShot.data!.docs[index]
                                              ['imageProfile'],
                                          height: Get.height * 0.1,
                                          width: Get.width * 0.4,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.sp),
                              child: CustomText(
                                text: snapShot.data!.docs[index]['prdName'],
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: SColorPicker.purple,
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.sp),
                              child: CustomText(
                                text: snapShot.data!.docs[index]['dsc'],
                                textOverflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w600,
                                max: 1,
                                fontSize: 12.sp,
                                color: SColorPicker.black,
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.sp),
                              child: CustomText(
                                text: snapShot.data!.docs[index]['price'],
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                                color: SColorPicker.black,
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          }
        },
      ),
    );
  }
}
