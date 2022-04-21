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
      this.id})
      : super(key: key);
  final String? name, image, desc, price, category, id;

  @override
  State<CustomSelectedProductBuildTopWidget> createState() =>
      _CustomSelectedProductBuildTopWidgetState();
}

class _CustomSelectedProductBuildTopWidgetState
    extends State<CustomSelectedProductBuildTopWidget> {
  @override
  Widget build(BuildContext context) {
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
          // SizedBox(height: Get.height * 0.01),
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
                        GestureDetector(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Addes Into Cart'),
                                backgroundColor: AppColors.primaryColor,
                              ),
                            );
                            print('CATEGORY----->${widget.category}');
                            File? imagUrl;
                            FirebaseFirestore.instance
                                .collection('Cart')
                                .doc(PreferenceManager.getUId().toString())
                                .collection('MyCart')
                                .add({
                              'cartID': PreferenceManager.getUId().toString(),
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
                                ),
                              );
                            });
                            // addCart(widget.id!).then((value) {
                            //   print('Added into cart');
                            //
                            //   // Get.to(ProductCartScreen());
                            // });
                          },
                          child: CustomText(
                            text: 'ADD TO CART',
                            fontWeight: FontWeight.w600,
                            fontSize: 11.sp,
                            color: AppColors.commonWhiteTextColor,
                            textAlign: TextAlign.left,
                          ),
                        ),
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

// CollectionReference productsCartCollection =
//     bFirebaseStore.collection('Cart');
// FirebaseAuth _auth = FirebaseAuth.instance;

// Future<void> addDataToCart(File? file) async {
//   String? imageUrl = await uploadImageToFirebase(
//     context: context,
//   );
//   BAuthMethods().getCurrentUser().then((value) {
//     print(
//         'PreferenceManager.getUId()....${PreferenceManager.getUId().toString()}');
//     FirebaseFirestore.instance
//         .collection('Cart')
//         .doc(PreferenceManager.getTime().toString())
//         .collection('MyCart')
//         .add({
//           'userID': _auth.currentUser!.uid,
//           'imageProfile': imageUrl,
//           'category': widget.category,
//           'prdName': widget.name,
//           'dsc': widget.desc,
//           'price': widget.price,
//           'createdOn': DateTime.now(),
//         })
//         .catchError((e) => print('Error ===>>> $e'))
//         .then(
//           (value) {
//             bottomBarIndexController.bottomIndex.value = 0;
//             bottomBarIndexController.selectedScreen('SCatelogeHomeScreen');
//           },
//         );
//   });
// }
}
