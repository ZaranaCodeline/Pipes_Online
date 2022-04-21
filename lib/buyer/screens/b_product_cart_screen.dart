import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/app_constant/b_image.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
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
  CollectionReference ProfileCollection = bFirebaseStore.collection('Cart');
  String? name;
  String? dsc;
  String? Img;
  String? price;
  String? category;

  Future<void> getData() async {
    final user =
        await ProfileCollection.doc('${PreferenceManager.getUId().toString()}')
            .get();
    var m = user.data();
    print('--m-- $m');
    print(
        '--PreferenceManager.getUId().toString()---> ${PreferenceManager.getUId().toString()}');
    print(
        '--bFirebaseAuth.currentUser!.uid---> ${bFirebaseAuth.currentUser!.uid}');

    Map<String, dynamic>? getUserData = m as Map<String, dynamic>?;
    setState(() {
      name = getUserData!['prdName'];
      dsc = getUserData['dsc'];
      Img = getUserData['imageProfile'];
      price = getUserData['price'];
      category = getUserData['category'];
    });

    print('============CartProductcontroller===${user.get('imageProfile')}');
    print('==getUserData===${getUserData}');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    print('name:-${name}');
    print('dsc:-${dsc}');
    print('category:-${category}');
    print('Img:-${Img}');
    print('price:-${price}');

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
              // bottomBarIndexController.setSelectedScreen(
              //     value: 'CatelogeHomeWidget');
              // bottomBarIndexController.bottomIndex.value = 0;
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
      body: Padding(
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
                      Img == null
                          ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQB4x3H3i8szbt2TfefSCNwMpzF28ZM1Hvx907uC6ybDPBBb7uUdi3AIQbD7x7Wpnezv6M&usqp=CAU'
                          : Img.toString(),
                      fit: BoxFit.cover,
                    )
                    /* Image.network(
                      Img.toString(),
                      */ /*BImagePick.cartIcon,*/ /*
                      fit: BoxFit.cover,
                      height: Get.height / 5,
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
                        text: name.toString(),
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
                        text: category.toString(),
                        fontWeight: FontWeight.w600,
                        fontSize: 12.sp,
                        color: AppColors.secondaryBlackColor,
                        alignment: Alignment.centerLeft,
                      ),
                      SizedBox(
                        height: Get.height * 0.01.sp,
                      ),
                      CustomText(
                        text: price.toString(),
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
                            blurRadius: 1, color: AppColors.hintTextColor),
                      ]),
                  child: TextButton(
                    onPressed: () {
                      print('Delete');
                      FirebaseFirestore.instance
                          .collection("Products")
                          .doc()
                          .delete()
                          .then((_) {
                        print("delete success!");
                      });
                      ;
                      Get.back();
                    },
                    child: SvgPicture.asset(BImagePick.deleteIcon),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
