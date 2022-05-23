import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/app_constant/b_image.dart';
import 'package:pipes_online/buyer/screens/b_cart_check_out_page.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/buyer/view_model/cart_product_controller.dart';
import 'package:pipes_online/seller/view/s_screens/s_text_style.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';

import 'bottom_bar_screen_page/widget/b_home_bottom_bar_route.dart';

class ProductCartScreen extends StatefulWidget {
  String? id;
  ProductCartScreen({Key? key, this.id});

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
    print('getUId==========${PreferenceManager.getUId()}');
    print('widget.id==========${widget.id}');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
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
            .orderBy('createdOn', descending: true)
            .snapshots(),
        builder: (context, snapShot) {
          if (!snapShot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapShot.data!.docs.isEmpty) {
              print('has not  data');
              return Center(
                child: Container(
                  width: Get.width * 0.6,
                  height: Get.height / 11,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.sp),
                      color: AppColors.primaryColor),
                  child: Center(
                      child: CustomText(
                    text: 'No Products in Cart',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.commonWhiteTextColor,
                  )),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapShot.data!.docs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(
                        () => CartPage(
                          name: snapShot.data!.docs[index]['category'],
                          category: snapShot.data!.docs[index]['category'],
                          desc: snapShot.data!.docs[index]['dsc'],
                          image: snapShot.data!.docs[index]['imageProfile'],
                          price: snapShot.data!.docs[index]['price'],
                          productID: snapShot.data!.docs[index]['productID'],
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.all(15.sp),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: Get.width * 0.35,
                                height: Get.height / 7,
                                // flex: 3,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.network(
                                    snapShot.data!.docs[index]['imageProfile'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 15.sp),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: snapShot.data!.docs[index]
                                            ['prdName'],
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16.sp,
                                        color: AppColors.primaryColor,
                                        alignment: Alignment.topLeft,
                                        textOverflow: TextOverflow.ellipsis,
                                        max: 1,
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
                                        text: snapShot.data!.docs[index]
                                            ['price'],
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.sp,
                                        color: AppColors.secondaryBlackColor,
                                        alignment: Alignment.centerLeft,
                                      ),
                                    ],
                                  ),
                                ),
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
                                child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('Cart')
                                      .doc(PreferenceManager.getUId())
                                      .collection('MyCart')
                                      .snapshots(),
                                  builder: (context, snapShot) {
                                    if (snapShot.hasData) {
                                      return TextButton(
                                        onPressed: () {
                                          try {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Product has been Removed From Cart'),
                                              ),
                                            );

                                            FirebaseFirestore.instance
                                                .collection("Cart")
                                                .doc(PreferenceManager.getUId())
                                                .collection("MyCart")
                                                .doc(snapShot
                                                    .data?.docs[index].id)
                                                .delete();
                                          } catch (e) {
                                            print(e.toString());
                                          }
                                        },
                                        child: SvgPicture.asset(
                                            BImagePick.deleteIcon),
                                      );
                                    }
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.primaryColor,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          }

          /* if (!snapShot.hasData) {
            print('has not data');
            return Center(
              child: Container(
                width: Get.width * 0.1,
                height: Get.height / 8,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(25.sp)),
                child: Text('Add Products in Cart'),
              ),
            );
          }
          else*/
          if (snapShot.hasData) {
            print('has data');
            return ListView.builder(
              itemCount: snapShot.data!.docs.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(
                      () => CartPage(
                        name: snapShot.data!.docs[index]['category'],
                        category: snapShot.data!.docs[index]['category'],
                        desc: snapShot.data!.docs[index]['dsc'],
                        image: snapShot.data!.docs[index]['imageProfile'],
                        price: snapShot.data!.docs[index]['price'],
                        productID: snapShot.data!.docs[index]['productID'],
                      ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.all(15.sp),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: Get.width * 0.35,
                              height: Get.height / 7,
                              // flex: 3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  snapShot.data!.docs[index]['imageProfile'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.symmetric(horizontal: 15.sp),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: snapShot.data!.docs[index]
                                          ['prdName'],
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp,
                                      color: AppColors.primaryColor,
                                      alignment: Alignment.topLeft,
                                      textOverflow: TextOverflow.ellipsis,
                                      max: 1,
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
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('Cart')
                                    .doc(PreferenceManager.getUId())
                                    .collection('MyCart')
                                    .snapshots(),
                                builder: (context, snapShot) {
                                  if (snapShot.hasData) {
                                    return TextButton(
                                      onPressed: () {
                                        try {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Product has been Removed From Cart'),
                                            ),
                                          );

                                          FirebaseFirestore.instance
                                              .collection("Cart")
                                              .doc(PreferenceManager.getUId())
                                              .collection("MyCart")
                                              .doc(
                                                  snapShot.data?.docs[index].id)
                                              .delete();
                                        } catch (e) {
                                          print(e.toString());
                                        }
                                      },
                                      child: SvgPicture.asset(
                                          BImagePick.deleteIcon),
                                    );
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.primaryColor,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else
            return Center(
              child: Container(
                width: Get.width * 0.1,
                height: Get.height / 8,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(25.sp)),
                child: Text('Add Products in Cart'),
              ),
            );
        },
      ),
    );
  }
}
