import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/custom_widget/widgets/custom_text.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:sizer/sizer.dart';

class SCustomProductCard extends StatefulWidget {
  SCustomProductCard({Key? key})
      : super(key: key);


  @override
  State<SCustomProductCard> createState() => _SCustomProductCardState();
}

class _SCustomProductCardState extends State<SCustomProductCard> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height*0.7,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('User').
          doc('${_auth.currentUser!.uid}')
            .collection('data')
            .snapshots(),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            return  GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 5,mainAxisSpacing: 5,childAspectRatio: 1.7/ 2),
                itemCount: snapShot.data!.docs.length,itemBuilder: (BuildContext context,index){
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: Get.width*0.4,
                  height: Get.height*0.26,
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
                          //width: Get.width * 0.35,height: Get.height*0.1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(Get.width * 0.02),
                            child: Image.network(
                              snapShot.data!.docs[index]['imageProfile'],
                              height: Get.height*0.1,
                              width:Get.width * 0.4,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10.sp),
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
                        padding:  EdgeInsets.symmetric(horizontal: 10.sp),
                        child: CustomText(
                          text:snapShot.data!.docs[index]['dsc'],
                          textOverflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600,
                          max: 2,
                          fontSize: 12.sp,
                          color: SColorPicker.black,
                          alignment: Alignment.centerLeft,
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 10.sp),
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
              );
            });
          }else{
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
