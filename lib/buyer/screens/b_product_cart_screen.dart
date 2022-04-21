import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/app_constant/b_image.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/buyer/view_model/cart_product_controller.dart';
import 'package:pipes_online/seller/view/s_screens/s_text_style.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';

import 'bottom_bar_screen_page/widget/b_home_bottom_bar_route.dart';

class ProductCartScreen extends StatefulWidget {
  String? id;

  ProductCartScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProductCartScreen> createState() => _ProductCartScreenState();
}

class _ProductCartScreenState extends State<ProductCartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  CartProductcontroller cartProductcontroller =
      Get.put(CartProductcontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              // Get.back();
              bottomBarIndexController.setSelectedScreen(value: 'HomeScreen');
              bottomBarIndexController.bottomIndex.value = 0;
            },
            icon: Icon(Icons.arrow_back_rounded)),
        title: Text(
          'cart'.toUpperCase(),
          style: STextStyle.bold700White14,
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: Get.height * 0.1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Cart')
            .doc(PreferenceManager.getUId())
            .collection('MyCart')
            .snapshots(),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return ListView.builder(
                itemCount: snapShot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(15.sp),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: Get.width * 0.4,
                              height: Get.height / 5,
                              // flex: 3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  snapShot.data!.docs[index]['imageProfile'],
                                  fit: BoxFit.cover,
                                )
                                /* Image.network(
                        Img.toString(),
                        */ /*BImagePick.cartIcon,*/ /*
                        fit: BoxFit.cover,
                        height: Get.height / 5,`
                      )*/
                                ,
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.symmetric(horizontal: 15.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: snapShot.data!.docs[index]['prdName'],
                                    /*widget.name.toString()*/
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp,
                                    color: AppColors.primaryColor,
                                    alignment: Alignment.topLeft,
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01.sp,
                                  ),
                                  CustomText(
                                    text: snapShot.data!.docs[index]
                                        ['category'],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: AppColors.secondaryBlackColor,
                                    alignment: Alignment.centerLeft,
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01.sp,
                                  ),
                                  CustomText(
                                    text: snapShot.data!.docs[index]['price'],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: AppColors.secondaryBlackColor,
                                    alignment: Alignment.centerLeft,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.02.sp,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                                text: 'Remove form Cart',
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                                color: AppColors.hintTextColor),
                            // Container(
                            //   width: 25.sp,
                            //   height: 25.sp,
                            //    decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(25),
                            //       color: AppColors
                            //           .secondaryBlackColor.withOpacity(0.3)    Color(0xffFB8C00)  ),
                            //   child: IconButton(
                            //     onPressed: () {
                            //       cartProductcontroller.increment();
                            //     },
                            //     icon: Icon(
                            //       Icons.arrow_back_ios,
                            //       color:AppColors
                            //           .secondaryBlackColor.withOpacity(0.3),
                            //       size:15.sp,
                            //     ),
                            //   ),
                            // ),
                            // ,
                            //  SizedBox(
                            //   width: 10.sp,
                            // ),
                            // Obx(
                            //   () => Text(
                            //     '${cartProductcontroller.items.toString()}',
                            //     style: TextStyle(
                            //         fontSize: 14.sp, fontWeight: FontWeight.w700
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(
                            //   width:10.sp,
                            // ),
                            // Container(
                            //   width: 25.sp,
                            //   height: 25.sp,
                            //    decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(25),
                            //       color: AppColors.secondaryBlackColor),
                            //   child: IconButton(
                            //     onPressed: () {
                            //       cartProductcontroller.decrement();
                            //     },
                            //     icon: Icon(
                            //       Icons.arrow_forward_ios,
                            //       color: AppColors
                            //           .secondaryBlackColor.withOpacity(0.3),
                            //       size: 15.sp,
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              height: 15.sp,
                            ),
                            Container(
                              height: Get.height / 15.sp,
                              width: Get.width * 0.1,
                              decoration: BoxDecoration(
                                  color: AppColors.commonWhiteTextColor,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    new BoxShadow(
                                        blurRadius: 1,
                                        color: AppColors.hintTextColor),
                                  ]),
                              child: TextButton(
                                onPressed: () {
                                  print('Delete');

                                  FirebaseFirestore.instance
                                      .collection('Products')
                                      .doc()
                                      .collection('Cart')
                                      .doc('id')
                                      .delete()
                                      .then((value) {
                                    cartProductcontroller
                                        .getItemDetails(widget.id.toString());
                                    return 'delete product';
                                  });
                                  // FirebaseFirestore.instance
                                  //     .collection("Products")
                                  //     .doc()
                                  //     .delete()
                                  //     .then((_) {
                                  //   print("delete success!");
                                  // });
                                  Get.back();
                                },
                                child: SvgPicture.asset(BImagePick.deleteIcon),
                              ),
                            ),
                          ],
                        ),
                      ],
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
    );
  }
}
