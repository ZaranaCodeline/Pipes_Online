import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/authentificaion/b_functions.dart';
import 'package:pipes_online/buyer/screens/b_cart_page.dart';
import 'package:pipes_online/buyer/screens/b_product_cart_screen.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';

import '../app_constant/app_colors.dart';
import 'bottom_bar_screen_page/widget/b_home_bottom_bar_route.dart';
import 'custom_widget/custom_text.dart';

class CustomSelectedProductBuildTopWidget extends StatefulWidget {
  CustomSelectedProductBuildTopWidget(
      {Key? key,
      this.price,
      this.desc,
      this.name,
      this.category,
      this.image,
      this.productID})
      : super(key: key);
  final String? name, image, desc, price, category, productID;

  @override
  State<CustomSelectedProductBuildTopWidget> createState() =>
      _CustomSelectedProductBuildTopWidgetState();
}

class _CustomSelectedProductBuildTopWidgetState
    extends State<CustomSelectedProductBuildTopWidget> {
  List data = [];
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    print('ID  >>> ${widget.productID}');
    return Container(
      child: Column(
        children: [
          CustomText(
            text: widget.name.toString(),
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
            color: AppColors.primaryColor,
            alignment: Alignment.topLeft,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                  text: widget.category.toString(),
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  max: 1,
                  textOverflow: TextOverflow.ellipsis,
                  color: AppColors.secondaryBlackColor),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                    height: Get.height * 0.06,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.shopping_cart_outlined,
                          color: AppColors.commonWhiteTextColor,
                          size: 15.sp,
                        ),
                        SizedBox(width: Get.width * 0.01),
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Cart')
                              .doc(PreferenceManager.getUId())
                              .collection('MyCart')
                              .snapshots(),
                          builder: (BuildContext context, snapshot) {
                            return GestureDetector(
                              onTap: () {
                                if (snapshot.data!.docs.isEmpty) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  print('hello1....');
                                  FirebaseFirestore.instance
                                      .collection('Cart')
                                      .doc(
                                          PreferenceManager.getUId().toString())
                                      .collection('MyCart')
                                      .add({
                                    'productID': widget.productID,
                                    'cartID':
                                        PreferenceManager.getUId().toString(),
                                    'imageProfile': widget.image,
                                    'category': widget.category,
                                    'prdName': widget.name,
                                    'dsc': widget.desc,
                                    'price': widget.price,
                                    'createdOn': DateTime.now(),
                                  }).then((value) {
                                    Get.to(
                                      () => CartPage(
                                        category: widget.category,
                                        name: widget.name,
                                        desc: widget.desc,
                                        image: widget.image,
                                        price: widget.price,
                                        productID: widget.productID,
                                      ),
                                    );
                                  });
                                } else {
                                  print('test:-2');
                                  snapshot.data!.docs.forEach((element) {
                                    data.add(element['productID']);
                                    print('PRODUCT ID ${data}');
                                  });
                                  if (data.contains(widget.productID)) {
                                    print('hello4....');
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Product is Already added into Cart..'),
                                      ),
                                    );
                                  } else {
                                    print('hello3....');
                                    FirebaseFirestore.instance
                                        .collection('Cart')
                                        .doc(PreferenceManager.getUId()
                                            .toString())
                                        .collection('MyCart')
                                        .add({
                                      'productID': widget.productID,
                                      'cartID':
                                          PreferenceManager.getUId().toString(),
                                      'imageProfile': widget.image,
                                      'category': widget.category,
                                      'prdName': widget.name,
                                      'dsc': widget.desc,
                                      'price': widget.price,
                                      'createdOn': DateTime.now(),
                                    }).then((value) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text('Added into Cart'),
                                        duration: Duration(seconds: 5),
                                      ));
                                    });
                                    data.clear();
                                  }
                                  print('hello2....');
                                  print(
                                      'widget.productID-----${widget.productID}');
                                  print('data----${data}');
                                }
                              },
                              child: CustomText(
                                text: 'ADD TO CART'.toUpperCase(),
                                fontWeight: FontWeight.w600,
                                fontSize: 11.sp,
                                color: AppColors.commonWhiteTextColor,
                                textAlign: TextAlign.left,
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          CustomText(
            text: widget.price.toString(),
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            color: AppColors.secondaryBlackColor,
            alignment: Alignment.topLeft,
          ),
        ],
      ),
    );
  }

  Future<String?> uploadImageToFirebase(
      {BuildContext? context, File? file}) async {
    try {
      var response = await firebase_storage.FirebaseStorage.instance
          .ref('uploads/$file')
          .putFile(file!);
      print("Response>>>>>>>>>>>>>>>>>>$response");

      return response.storage.ref().getDownloadURL();
    } catch (e) {
      print(e);
    }
  }
}
