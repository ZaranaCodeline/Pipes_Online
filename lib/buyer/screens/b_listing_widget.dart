import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';
import '../app_constant/app_colors.dart';
import 'custom_widget/custom_text.dart';

class BListingWidget extends StatefulWidget {
  const BListingWidget({Key? key}) : super(key: key);

  @override
  State<BListingWidget> createState() => _BListingWidgetState();
}

class _BListingWidgetState extends State<BListingWidget> {
  String? Img;
  String? pname;
  String? catName;
  String? price;
  String? sellerID;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Products').snapshots(),
              builder: (context, snapShot) {
                print(
                    'ProductCardList==============-->${snapShot.data?.docs.length}');
                if (snapShot.hasData) {
                  return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapShot.data?.docs.length,
                      itemBuilder: (context, index) {
                        //ToDo getUserType as Seller can't fetch
                        if (snapShot.data!.docs[index] !=
                            PreferenceManager.getUserType()) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.network(
                                      snapShot.data!.docs[index]
                                          ['imageProfile'],
                                      fit: BoxFit.cover,
                                      width: Get.width * 0.1,
                                      height: Get.height / 6,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Column(
                                      children: [
                                        CustomText(
                                          text: snapShot.data!.docs[index]
                                              ['prdName'],
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.sp,
                                          color: AppColors.primaryColor,
                                          alignment: Alignment.topLeft,
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.01,
                                        ),
                                        CustomText(
                                          text: snapShot.data!.docs[index]
                                              ['category'],
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.sp,
                                          color: AppColors.secondaryBlackColor,
                                          alignment: Alignment.centerLeft,
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.01,
                                        ),
                                        CustomText(
                                          text: snapShot.data!.docs[index]
                                              ['price'],
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.sp,
                                          color: AppColors.secondaryBlackColor,
                                          alignment: Alignment.centerLeft,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return SizedBox();
                      },);
                }
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
