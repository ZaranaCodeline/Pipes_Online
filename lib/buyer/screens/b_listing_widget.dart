import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
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

  CollectionReference ProfileCollection = bFirebaseStore.collection('Products');

  Future<void> getData() async {
    print('demo.....');
    final user =
    await ProfileCollection.doc('${FirebaseAuth.instance.currentUser!.uid}')
        .get();
    Map<String, dynamic>? getUserData = user.data() as Map<String, dynamic>?;
    pname = getUserData!['prdName'];
    catName = getUserData['category'];
    Img = getUserData['imageProfile'];
    price = getUserData['price'];
    setState(() {
      Img = getUserData['imageProfile'];
    });
    print('============================${user.get('imageProfile')}');
    print('===Listing review buyer=getUserData====${getUserData}');
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Card(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child:
                        Image.network(
                          Img == null
                              ? 'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'
                              : Img!,
                          fit: BoxFit.cover,
                        )
                        /*Image.asset(
                          'assets/images/png/cart_page.png',
                          fit: BoxFit.cover,
                          width: 130,
                          height: 95,
                        )*/,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            CustomText(
                              text: '',
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: AppColors.primaryColor,
                              alignment: Alignment.topLeft,
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            CustomText(
                              text: catName.toString(),
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: AppColors.secondaryBlackColor,
                              alignment: Alignment.centerLeft,
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            CustomText(
                              text: price.toString(),
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
              ),
            ),
            Card(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          'assets/images/png/cart_page.png',
                          fit: BoxFit.cover,
                          width: 130,
                          height: 95,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            CustomText(
                              text:pname.toString(),
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: AppColors.primaryColor,
                              alignment: Alignment.topLeft,
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            CustomText(
                              text: catName.toString(),
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: AppColors.secondaryBlackColor,
                              alignment: Alignment.centerLeft,
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            CustomText(
                              text: price.toString(),
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: AppColors.secondaryBlackColor,
                              alignment: Alignment.centerLeft,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      flex: 3,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          'assets/images/png/cart_page.png',
                          fit: BoxFit.cover,
                          width: 130,
                          height: 95,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            CustomText(
                              text: 'Round',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: AppColors.primaryColor,
                              alignment: Alignment.topLeft,
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            CustomText(
                              text: catName.toString(),
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: AppColors.secondaryBlackColor,
                              alignment: Alignment.centerLeft,
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            CustomText(
                              text: '\$10/ Feet',
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: AppColors.secondaryBlackColor,
                              alignment: Alignment.centerLeft,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
