import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/b_image.dart';
import 'package:pipes_online/buyer/view_model/b_bottom_bar_controller.dart';
import 'package:sizer/sizer.dart';

import '../../seller/common/s_color_picker.dart';
import '../app_constant/app_colors.dart';
import 'b_selected_product_widget.dart';
import 'custom_widget/custom_text.dart';

class ProductCardList extends StatefulWidget {
  ProductCardList({
    Key? key,
    this.category,
  }) : super(key: key);
  final String? category;

  @override
  State<ProductCardList> createState() => _ProductCardListState();
}

class _ProductCardListState extends State<ProductCardList> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  BBottomBarIndexController bottomBarIndexController =
      Get.put(BBottomBarIndexController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // height: Get.height * 5.sp
        padding: EdgeInsets.symmetric(horizontal: 8.sp),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Products').snapshots(),
          builder: (context, snapShot) {
            print('ProductCardList=-->${snapShot.data?.docs.length}');
            if (snapShot.hasData) {
              return GridView.builder(
                  physics: BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 1.7 / 2),
                  itemCount: snapShot.data!.docs.length,
                  itemBuilder: (BuildContext context, index) {
                    return GestureDetector(
                      onTap: () {
                        print(
                            'imageProfile==${snapShot.data!.docs[index]['imageProfile']}');
                        print(
                            "['prdName']--${snapShot.data!.docs[index]['prdName']}");
                        print('DATA OF ID==${snapShot.data!.docs[index]}');

                        print(
                            'DATA OF ID=snapShot.data!.docs[index].id=======${snapShot.data!.docs[index].id}');
                        print(
                            'sellerID===${snapShot.data!.docs[index]['sellerID']}');

                        Get.to(
                          SelectedProductWidget(
                            name: snapShot.data!.docs[index]['prdName'],
                            price: snapShot.data!.docs[index]['price'],
                            image: snapShot.data!.docs[index]['imageProfile'],
                            desc: snapShot.data!.docs[index]['dsc'],
                            category: snapShot.data!.docs[index]['category'],
                            productID: snapShot.data!.docs[index].id,
                            sellerID: snapShot.data!.docs[index]['sellerID'],
                          ),
                        );
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
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          Get.width * 0.02),
                                      child: Image.network(
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
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 10.sp),
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
                                padding:
                                    EdgeInsets.symmetric(horizontal: 10.sp),
                                child: CustomText(
                                  text: snapShot.data!.docs[index]['category'],
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
                                padding:
                                    EdgeInsets.symmetric(horizontal: 10.sp),
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
            }
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            );
          },
        ),
      ),
    );
  }
}
