import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/seller/bottombar/widget/category_bottom_bar_route.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:pipes_online/seller/view_model/s_edit_product_controller.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

import '../../../buyer/screens/b_image.dart';

class SCustomProductCard extends StatefulWidget {
  SCustomProductCard({Key? key}) : super(key: key);

  @override
  State<SCustomProductCard> createState() => _SCustomProductCardState();
}

class _SCustomProductCardState extends State<SCustomProductCard> {
  EditProductContoller editProductContoller = Get.put(EditProductContoller());
  FirebaseAuth _auth = FirebaseAuth.instance;
  String? proName, desc, price, image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.7,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Products')
            .where('createdOn', isLessThan: DateTime.now())
            .snapshots(),
        builder: (context, snapShot) {
          if (!snapShot.hasData) {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    childAspectRatio: 1.7 / 2),
                itemCount: snapShot.data?.docs.length,
                itemBuilder: (BuildContext context, index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade100,
                    highlightColor: Colors.grey.shade200,
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
                                blurRadius: 0,
                                color: SColorPicker.fontGrey,
                              )
                            ]),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(Get.width * 0.02),
                                  child: Container(
                                    height: Get.height * 0.12,
                                    width: Get.width * 0.4,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.sp),
                              child: Container(
                                height: 1.h,
                                width: Get.width * 0.4,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.sp),
                              child: Container(
                                height: 1.h,
                                width: Get.width * 0.4,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.sp),
                              child: Container(
                                height: 1.h,
                                width: Get.width * 0.4,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }
          if (snapShot.hasData) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapShot.connectionState == ConnectionState.done) {}
            return GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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

                    EditProductContoller editProductContoller =
                        Get.put(EditProductContoller());
                    print(
                        'prdName==>${editProductContoller.selectedName = snapShot.data!.docs[index]['prdName']}');
                    print(
                        'selectedPrice==>${editProductContoller.selectedPrice = editProductContoller.selectedPrice}');
                    print(
                        'selectedPrice====>${editProductContoller.selectedPrice = (snapShot.data!.docs[index]['price'])}');

                    editProductContoller
                        .selectedID(snapShot.data!.docs[index].id);

                    homeController.selectedScreen('SSelectedProductScreen');
                    homeController.bottomIndex.value = 0;
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: Get.width * 0.4,
                      height: Get.height * 0.26,
                      decoration: BoxDecoration(
                          color: AppColors.commonWhiteTextColor,
                          borderRadius: BorderRadius.circular(Get.width * 0.05),
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
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(Get.width * 0.02),
                                child: snapShot.data!.docs[index]
                                                ['imageProfile'] ==
                                            null ||
                                        snapShot.data!.docs[index]
                                                ['imageProfile'] ==
                                            ''
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : Image.network(
                                        snapShot.data!.docs[index]
                                            ['imageProfile'],
                                        height: Get.height * 0.1,
                                        width: Get.width * 0.4,
                                        fit: BoxFit.cover,
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                          return Image.asset(
                                            BImagePick.cartIcon,
                                            height: Get.height * 0.1,
                                            width: Get.width * 0.4,
                                            fit: BoxFit.cover,
                                          );
                                        },
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
                              max: 1,
                              textOverflow: TextOverflow.ellipsis,
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
              },
            );
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
