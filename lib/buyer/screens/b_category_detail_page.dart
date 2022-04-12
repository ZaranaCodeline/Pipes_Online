import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/screens/product_card_list.dart';
import 'package:pipes_online/buyer/screens/b_selected_product_widget.dart';
import 'package:pipes_online/buyer/view_model/b_bottom_bar_controller.dart';
import 'package:sizer/sizer.dart';

import '../../seller/common/s_color_picker.dart';
import '../../seller/common/s_text_style.dart';
import 'custom_widget/custom_text.dart';
import 'bottom_bar_screen_page/widget/b_cart_bottom_bar_route.dart';

class BCategoryDetailsPage extends StatefulWidget {
  const BCategoryDetailsPage({Key? key, this.category}) : super(key: key);
  final String? category;

  @override
  State<BCategoryDetailsPage> createState() => _BCategoryDetailsPageState();
}

class _BCategoryDetailsPageState extends State<BCategoryDetailsPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;


  BBottomBarIndexController controller = Get.put(BBottomBarIndexController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              widget.category.toString().toUpperCase(),
              style: STextStyle.bold700White14,
            ),
            leading: IconButton(
                onPressed: () {
                  if (bottomBarIndexController.bottomIndex.value == 1) {
                    bottomBarIndexController.setSelectedScreen(
                        value: 'HomeScreen');
                    bottomBarIndexController.bottomIndex.value = 0;
                  } else {
                    Get.back();
                  }
                },
                icon: Icon(Icons.arrow_back_rounded)),
            backgroundColor: AppColors.primaryColor,
            toolbarHeight: Get.height * 0.09,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(25),
              ),
            ),
          ),
          body: Container(
            // height: Get.height * 5.sp,
            padding: EdgeInsets.symmetric(horizontal: 8.sp),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('User')
                  .doc('${_auth.currentUser!.uid}')
                  .collection('data')
                  .where('category', isEqualTo:widget.category)
                  .snapshots(),
              builder: (context, snapShot) {
                if (snapShot.hasData) {
                  if (snapShot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return GridView.builder(
                      physics: BouncingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          childAspectRatio: 1.7 / 2),
                      itemCount: snapShot.data!.docs.length,
                      itemBuilder: (BuildContext context, index) {
                        print('LENGTH ${snapShot.data!.docs.length}');
                        return GestureDetector(
                          onTap: () {
                            print('gfvf');
                            print('DATA OF ID${snapShot.data!.docs[index].id}');
                            Get.to(SelectedProductWidget(
                              name: snapShot.data!.docs[index]['prdName'],
                              price: snapShot.data!.docs[index]['price'],
                              image: snapShot.data!.docs[index]['imageProfile'],
                              desc: snapShot.data!.docs[index]['dsc'],
                              category: widget.category,
                            ));
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
                                        borderRadius: BorderRadius.circular(
                                            Get.width * 0.02),
                                        child: snapShot.data!.docs[index]
                                                        ['imageProfile'] ==
                                                    null ||
                                                snapShot.data!.docs[index]
                                                        ['imageProfile'] ==
                                                    ''
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator())
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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.sp),
                                    child: CustomText(
                                      text: snapShot.data!.docs[index]
                                          ['prdName'],
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
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  );
                }
              },
            ),
          )),
    );
  }
}
