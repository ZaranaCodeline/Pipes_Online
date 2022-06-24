import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' show cos, sqrt, asin;

import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import 'package:pipes_online/buyer/app_constant/b_image.dart';
import 'package:pipes_online/buyer/view_model/b_bottom_bar_controller.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:geolocator/geolocator.dart';

import '../../seller/common/s_color_picker.dart';
import '../app_constant/app_colors.dart';
import 'b_selected_product_widget.dart';
import 'custom_widget/custom_text.dart';

class ProductCardList extends StatefulWidget {
  ProductCardList({
    Key? key,
    this.category,
    this.pID,
  }) : super(key: key);
  String? category, pID;

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
    getDistanceFromGPSPointsInRoute;
  }

  ///

  Future<double> getDistanceFromGPSPointsInRoute(List<LatLng> gpsList) async {
    print('--->>>>test1>>>>');
    double totalDistance = 0.0;

    for (var i = 0; i < gpsList.length; i++) {
      print('--->>>>test2>>>>');

      var p = 0.017453292519943295;
      var c = cos;
      var a = 0.5 -
          c((gpsList[i + 1].latitude - gpsList[i].latitude) * p) / 2 +
          c(gpsList[i].latitude * p) *
              c(gpsList[i + 1].latitude * p) *
              (1 - c((gpsList[i + 1].longitude - gpsList[i].longitude) * p)) /
              2;
      double distance = 12742 * asin(sqrt(a));
      totalDistance += distance;
      print('--->>>>test3>>>>');

      print('Distance is ${12742 * asin(sqrt(a))}');
    }
    print('--->>>>test4>>>>');

    print('Total distance is $totalDistance');
    return totalDistance;
  }

  ///
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
            if (!snapShot.hasData) {
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 1.7 / 2),
                  itemCount: snapShot.data?.docs.length,
                  itemBuilder: (BuildContext context, index) {
                    return Shimmer.fromColors(
                      baseColor: Colors.grey.shade100,
                      highlightColor: Colors.grey.shade200,
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
                                  blurRadius: 0,
                                  color: SColorPicker.fontGrey,
                                )
                              ]),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(Get.width * 0.02),
                                    child: Container(
                                      height: Get.height * 0.12,
                                      width: Get.width * 0.4,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
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
                                child: Container(
                                  height: 1.h,
                                  width: Get.width * 0.4,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 10.sp),
                                child: Container(
                                  height: 1.h,
                                  width: Get.width * 0.4,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 10.sp),
                                child: Container(
                                  height: 1.h,
                                  width: Get.width * 0.4,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
            if (snapShot.hasData) {
              print('>>>>buyer Latitude>>> ${PreferenceManager.getLat()}'
                  ' >>>buyer longitude>>>>${PreferenceManager.getLong()}');

              return GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 1.7 / 2),
                  itemCount: snapShot.data!.docs.length,
                  itemBuilder: (BuildContext context, index) {
                    double productLat =
                        double.parse(snapShot.data?.docs[index]['lat']);
                    double productLong =
                        double.parse(snapShot.data?.docs[index]['long']);
                    double buyerLat = double.parse(PreferenceManager.getLat());
                    double buyerLong =
                        double.parse(PreferenceManager.getLong());

                    print('>>pLat >>${productLat}');
                    print('>>pLong >>${productLong}');
                    print('>>buyer Lat>>${buyerLat}');
                    print('>>buyer Long>>${buyerLong}');

                    print('zzz');

                    ///Distance between two locations
                    double distanceInMeters = Geolocator.distanceBetween(
                        productLat, productLong, buyerLat, buyerLong);
                    print(
                        '>>>>DISTANCES>>>> ${distanceInMeters.toStringAsFixed(2)}');
                    var distanceBetween = distanceInMeters.toStringAsFixed(2);
                    print('<<DIS_BET>> ${distanceBetween}');
                    var distance = Distance();
                    final km = distance.as(
                      LengthUnit.Kilometer,
                      LatLng(buyerLat, buyerLong),
                      LatLng(productLat, productLong),
                    );
                    print('>>>Kilometer>>>---${km.toStringAsFixed(2)}');

                    final m = distance.as(
                      LengthUnit.Meter,
                      LatLng(buyerLat, buyerLong),
                      LatLng(productLat, productLong),
                    );
                    print('>>>Meters>>>---${m.toStringAsFixed(2)}');

                    ///

                    ///

                    dynamic calculateDistance(
                        productLat, productLong, buyerLat, buyerLong) {
                      print('zzz123');

                      dynamic p = 0.017453292519943295;
                      dynamic a = 0.5 -
                          cos((buyerLat - productLat) * p) / 2 +
                          cos(productLat * p) *
                              cos(buyerLat * p) *
                              (1 - cos((buyerLong - productLong) * p)) /
                              2;
                      dynamic res = 12742 * asin(sqrt(a));
                      print('---RESULT---$res');
                      print('>>>>RESULT>>>${12742 * asin(sqrt(a))}');
                      return res.toStringAsFixed(2);
                    }

                    return GestureDetector(
                      onTap: () {
                        widget.pID = snapShot.data!.docs[index].id;

                        ///
                        print(
                            'imageProfile==${snapShot.data!.docs[index]['imageProfile']}');
                        print(
                            "['prdName']--${snapShot.data!.docs[index]['prdName']}");
                        print('DATA OF ID==${snapShot.data!.docs[index]}');
                        print(
                            'seller_lat==${snapShot.data!.docs[index]['lat']}');
                        print(
                            'seller_long==${snapShot.data!.docs[index]['long']}');

                        print(
                            'DATA OF id=======${snapShot.data!.docs[index].id}');
                        print(
                            'sellerID===${snapShot.data!.docs[index]['sellerID']}');

                        Get.to(
                          SelectedProductWidget(
                            sellerLat: snapShot.data!.docs[index]['lat'],
                            sellerLong: snapShot.data!.docs[index]['long'],
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
                                  max: 1,
                                  textOverflow: TextOverflow.ellipsis,
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
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 10.sp),
                                child: CustomText(
                                  text: '(${km} KM away)',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 9.sp,
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
            return Container();
          },
        ),
      ),
    );
  }
}
