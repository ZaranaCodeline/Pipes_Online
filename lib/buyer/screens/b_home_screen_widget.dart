import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/widget/b_cart_bottom_bar_route.dart';
import 'package:pipes_online/buyer/view_model/b_profile_view_model.dart';
import 'package:pipes_online/buyer/view_model/distance_dropdown_filter.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import '../app_constant/app_colors.dart';
import 'b_categories_card_list.dart';
import 'b_drawer_screen.dart';
import 'custom_widget/custom_search_widget.dart';
import 'custom_widget/custom_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:pipes_online/buyer/app_constant/b_image.dart';
import '../../seller/common/s_color_picker.dart';
import 'b_selected_product_widget.dart';

class CatelogeHomeWidget extends StatefulWidget {
  @override
  State<CatelogeHomeWidget> createState() => _CatelogeHomeWidgetState();
}

class _CatelogeHomeWidgetState extends State<CatelogeHomeWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  CollectionReference ProfileCollection = bFirebaseStore.collection('BProfile');
  BProfileViewModel _model = Get.find();
  DropdownValue _dropdownvalue = DropdownValue();
  String? buyerID;
  String? category, pID;

  double? distanceInKM;

  Future<void> getSellerData() async {
    DocumentReference profileCollection =
        bFirebaseStore.collection('Orders').doc();

    print('profileCollection.....${profileCollection}');
    final user = await profileCollection.get();

    var m = user.data();
    print('--SelectedProductWidget----m----$m');
    dynamic getUserData = m;
    setState(() {
      print('======ID=====${PreferenceManager.getUId()}');
      print('buyer_deatils_seller_review_screen=====${getUserData}');
      buyerID = getUserData?['buyerID'];
    });
    print('rating:---${getUserData?['rating']}');
  }

  Future<void> getData() async {
    print('demo buyer.....');
    final user =
        await ProfileCollection.doc('${PreferenceManager.getUId()}').get();
    Map<String, dynamic>? getUserData = user.data() as Map<String, dynamic>?;

    setState(() {
      _model.firstnameController =
          TextEditingController(text: getUserData?['user_name'] ?? "");
      _model.phoneController =
          TextEditingController(text: getUserData?['phoneno'] ?? "");
      _model.emailController =
          TextEditingController(text: getUserData?['email'] ?? "");
      _model.addressController =
          TextEditingController(text: getUserData?['address'] ?? "");
      _model.image1 = getUserData?['imageProfile'] ?? "";
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    getSellerData();
    print('--User Name ${PreferenceManager.getName()}');
    print('-- getUserImage  ${PreferenceManager.getUserImage()}');
    print('-- getAddress  ${PreferenceManager.getAddress()}');
    print('-- PhoneNumber  ${PreferenceManager.getPhoneNumber()}');
  }

  // List Distance111 = [
  //   '2 KM',
  //   '5 KM',
  //   '10 KM',
  //   'All',
  // ];
  // bool isDistanceSelected = false;

  @override
  Widget build(BuildContext context) {
    _showPopupMenu() {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      final offset = renderBox.localToGlobal(Offset.zero);
      final left = offset.dx;
      final top = offset.dy + renderBox.size.height;
      final right = left + renderBox.size.width;
      final bottom = offset.dx;

      String? dropdownValue = 'All';

      showMenu<String>(
          context: context,
          position: RelativeRect.fromLTRB(25.0, Get.height * 0.17, 0, 25.0),
          //position where you want to show the menu on screen
          items: [
            PopupMenuItem<String>(
                child: Text(
                  'Filter by KM',
                  style: TextStyle(fontSize: 12.sp),
                ),
                value: '1'),
            PopupMenuItem<String>(
                child: Card(
                  elevation: 2,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => DropdownButton(
                            value: _dropdownvalue.selected.value,
                            items: <String>['2 KM', '5 KM', '10 KM', 'All']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      color: AppColors.secondaryBlackColor),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? val) {
                              print('VAL >>> $val');

                              FirebaseFirestore.instance
                                  .collection('Products')
                                  .doc()
                                  .update({'distanceBetweenInKM': val});

                              _dropdownvalue.setSelected(val!);
                              print(
                                  'DROP VALUE -${_dropdownvalue.selected.value}');
                              print(_dropdownvalue.selected.value);
                              setState(
                                () {
                                  if (_dropdownvalue.selected.value.contains(
                                      _dropdownvalue.selected.value)) {
                                    print('yes-----');
                                    print(
                                        '>>Yes>>${_dropdownvalue.selected.value}');
                                  } else {
                                    print('NO-----');
                                    print(
                                        '>>NO${_dropdownvalue.selected.value}');
                                  }
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                value: '2'),
          ],
          elevation: 8.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.sp),
          ));
    }

    return WillPopScope(
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(Get.height * 0.17),
            child: Container(
              height: Get.height * 0.17,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(Get.width * 0.070),
                  ),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 1),
                        blurRadius: 11,
                        spreadRadius: 1)
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: Get.height * 0.07,
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          //padding: EdgeInsets.only(left: 15.sp),
                          icon: SvgPicture.asset(
                            'assets/images/svg/drawer_icon.svg',
                            width: 15.sp,
                            height: 15.sp,
                            color: AppColors.commonWhiteTextColor,
                          ),
                          onPressed: () =>
                              _scaffoldKey.currentState?.openDrawer(),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                right: 10.sp, bottom: 5.sp, top: 5.sp),
                            child: Image.asset(
                              'assets/images/png/pipe_logo.png',
                              fit: BoxFit.cover,
                            )),
                        InkWell(
                          onTap: () {
                            bottomBarIndexController.bottomIndex.value = 1;
                            bottomBarIndexController.setSelectedScreen(
                                value: 'ProductCartScreen');
                            // Get.to(() => ProductCartScreen());
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: Get.height * 0.05,
                                child: Icon(
                                  Icons.shopping_cart_outlined,
                                  color: SColorPicker.white,
                                  size: 21.sp,
                                ),
                              ),
                              Positioned(
                                top: 2.sp,
                                left: 0,
                                right: 0,
                                child: Container(
                                  width: 10.sp,
                                  height: 10.sp,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.commonWhiteTextColor,
                                  ),
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('Cart')
                                        .doc(PreferenceManager.getUId())
                                        .collection('MyCart')
                                        .snapshots(),
                                    builder: (context, snapShot) {
                                      if (snapShot.hasData) {
                                        print(
                                            '=====home_screen_cart_length=====${snapShot.data!.docs.length}');
                                        return CustomText(
                                          text: snapShot.data!.docs.length
                                              .toString(),
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.secondaryBlackColor,
                                          textAlign: TextAlign.center,
                                        );
                                      }
                                      return Container();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                    height: Get.height * 0.1,
                    //color: Colors.green,
                    child: SingleChildScrollView(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomHomeSearchWidget(),
                          GestureDetector(
                            onTap: () {
                              print('FILTER');
                              _showPopupMenu();
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.sp),
                              child: Container(
                                width: Get.width / 6,
                                height: Get.height * 0.06,
                                color: AppColors.commonWhiteTextColor,
                                child: Icon(
                                  Icons.filter_alt_outlined,
                                  color: AppColors.primaryColor,
                                  size: 22.sp,
                                ),
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
          ),
          drawer: CustomDrawerWidget(),
          body: Column(
            children: [
              SizedBox(
                height: Get.height * 0.02,
              ),
              CustomTitleText(
                text: 'Categories',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                alignment: Alignment.topLeft,
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              CategoriesCardList(),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Expanded(
                  child: Container(
                // height: Get.height * 5.sp
                padding: EdgeInsets.symmetric(horizontal: 8.sp),
                child: _dropdownvalue.selected.value == '2 KM'
                    ? StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Products')
                            .where('createdOn', isLessThan: DateTime.now())
                            .where('distanceBetweenInKM', isEqualTo: '2 KM')
                            .snapshots(),
                        builder: (context, snapShot) {
                          print(
                              '>>>>VALYE>>>>${_dropdownvalue.selected.value}');

                          if (!snapShot.hasData) {
                            return GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
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
                                            color:
                                                AppColors.commonWhiteTextColor,
                                            borderRadius: BorderRadius.circular(
                                                Get.width * 0.05),
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 0,
                                                color: SColorPicker.fontGrey,
                                              )
                                            ]),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Container(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Get.width * 0.02),
                                                  child: Container(
                                                    height: Get.height * 0.12,
                                                    width: Get.width * 0.4,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade100,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.01,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.sp),
                                              child: Container(
                                                height: 1.h,
                                                width: Get.width * 0.4,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.01,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.sp),
                                              child: Container(
                                                height: 1.h,
                                                width: Get.width * 0.4,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.01,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.sp),
                                              child: Container(
                                                height: 1.h,
                                                width: Get.width * 0.4,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
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
                            return GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 5,
                                        childAspectRatio: 1.7 / 2),
                                itemCount: snapShot.data!.docs.length,
                                itemBuilder: (BuildContext context, index) {
                                  double productLat = double.parse(
                                      snapShot.data?.docs[index]['lat']);
                                  double productLong = double.parse(
                                      snapShot.data?.docs[index]['long']);
                                  double buyerLat =
                                      double.parse(PreferenceManager.getLat());
                                  double buyerLong =
                                      double.parse(PreferenceManager.getLong());

                                  double distanceInMeters =
                                      Geolocator.distanceBetween(productLat,
                                          productLong, buyerLat, buyerLong);

                                  var distanceBetween =
                                      distanceInMeters.toStringAsFixed(2);

                                  var distance = Distance();

                                  final km = distance.as(
                                    LengthUnit.Kilometer,
                                    LatLng(buyerLat, buyerLong),
                                    LatLng(productLat, productLong),
                                  );

                                  final m = distance.as(
                                    LengthUnit.Meter,
                                    LatLng(buyerLat, buyerLong),
                                    LatLng(productLat, productLong),
                                  );
                                  if (_dropdownvalue.selected.value ==
                                      '2 KM') {}
                                  return GestureDetector(
                                    onTap: () {
                                      // widget.pID = snapShot.data!.docs[index].id;

                                      print(
                                          'imageProfile==${snapShot.data!.docs[index]['imageProfile']}');
                                      print(
                                          "['prdName']--${snapShot.data!.docs[index]['prdName']}");
                                      print(
                                          'DATA OF ID==${snapShot.data!.docs[index]}');
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
                                          sellerLat: snapShot.data!.docs[index]
                                              ['lat'],
                                          sellerLong: snapShot.data!.docs[index]
                                              ['long'],
                                          name: snapShot.data!.docs[index]
                                              ['prdName'],
                                          price: snapShot.data!.docs[index]
                                              ['price'],
                                          image: snapShot.data!.docs[index]
                                              ['imageProfile'],
                                          desc: snapShot.data!.docs[index]
                                              ['dsc'],
                                          category: snapShot.data!.docs[index]
                                              ['category'],
                                          productID:
                                              snapShot.data!.docs[index].id,
                                          sellerID: snapShot.data!.docs[index]
                                              ['sellerID'],
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        width: Get.width * 0.4,
                                        height: Get.height * 0.26,
                                        decoration: BoxDecoration(
                                            color:
                                                AppColors.commonWhiteTextColor,
                                            borderRadius: BorderRadius.circular(
                                                Get.width * 0.05),
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 1,
                                                color: SColorPicker.fontGrey,
                                              )
                                            ]),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          Get.width * 0.02),
                                                  child: Image.network(
                                                    snapShot.data!.docs[index]
                                                        ['imageProfile'],
                                                    height: Get.height * 0.1,
                                                    width: Get.width * 0.4,
                                                    fit: BoxFit.cover,
                                                    errorBuilder:
                                                        (BuildContext context,
                                                            Object exception,
                                                            StackTrace?
                                                                stackTrace) {
                                                      return Image.asset(
                                                        BImagePick.cartIcon,
                                                        height:
                                                            Get.height * 0.1,
                                                        width: Get.width * 0.4,
                                                        fit: BoxFit.cover,
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.01,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.sp),
                                              child: CustomText(
                                                max: 1,
                                                textOverflow:
                                                    TextOverflow.ellipsis,
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
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.sp),
                                              child: CustomText(
                                                text: snapShot.data!.docs[index]
                                                    ['category'],
                                                textOverflow:
                                                    TextOverflow.ellipsis,
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
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.sp),
                                              child: CustomText(
                                                text: snapShot.data!.docs[index]
                                                    ['price'],
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
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.sp),
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
                      )
                    : (_dropdownvalue.selected.value == '5 KM')
                        ? StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Products')
                                .where('createdOn', isLessThan: DateTime.now())
                                .where('distanceBetweenInKM', isEqualTo: '5 KM')
                                .snapshots(),
                            builder: (context, snapShot) {
                              print(
                                  '>>>>VALYE>>>>${_dropdownvalue.selected.value}');

                              if (!snapShot.hasData) {
                                return GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                                                color: AppColors
                                                    .commonWhiteTextColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Get.width * 0.05),
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 0,
                                                    color:
                                                        SColorPicker.fontGrey,
                                                  )
                                                ]),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Container(
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Get.width * 0.02),
                                                      child: Container(
                                                        height:
                                                            Get.height * 0.12,
                                                        width: Get.width * 0.4,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .grey.shade100,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.01,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.sp),
                                                  child: Container(
                                                    height: 1.h,
                                                    width: Get.width * 0.4,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade100,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.01,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.sp),
                                                  child: Container(
                                                    height: 1.h,
                                                    width: Get.width * 0.4,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade100,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.01,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.sp),
                                                  child: Container(
                                                    height: 1.h,
                                                    width: Get.width * 0.4,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade100,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
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
                                return GridView.builder(
                                    physics: const ClampingScrollPhysics(),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 5,
                                            mainAxisSpacing: 5,
                                            childAspectRatio: 1.7 / 2),
                                    itemCount: snapShot.data!.docs.length,
                                    itemBuilder: (BuildContext context, index) {
                                      double productLat = double.parse(
                                          snapShot.data?.docs[index]['lat']);
                                      double productLong = double.parse(
                                          snapShot.data?.docs[index]['long']);
                                      double buyerLat = double.parse(
                                          PreferenceManager.getLat());
                                      double buyerLong = double.parse(
                                          PreferenceManager.getLong());

                                      double distanceInMeters =
                                          Geolocator.distanceBetween(productLat,
                                              productLong, buyerLat, buyerLong);

                                      var distanceBetween =
                                          distanceInMeters.toStringAsFixed(2);

                                      var distance = Distance();

                                      final km = distance.as(
                                        LengthUnit.Kilometer,
                                        LatLng(buyerLat, buyerLong),
                                        LatLng(productLat, productLong),
                                      );

                                      final m = distance.as(
                                        LengthUnit.Meter,
                                        LatLng(buyerLat, buyerLong),
                                        LatLng(productLat, productLong),
                                      );
                                      if (_dropdownvalue.selected.value ==
                                          '2 KM') {}
                                      return GestureDetector(
                                        onTap: () {
                                          print(
                                              'imageProfile==${snapShot.data!.docs[index]['imageProfile']}');
                                          print(
                                              "['prdName']--${snapShot.data!.docs[index]['prdName']}");
                                          print(
                                              'DATA OF ID==${snapShot.data!.docs[index]}');
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
                                              sellerLat: snapShot
                                                  .data!.docs[index]['lat'],
                                              sellerLong: snapShot
                                                  .data!.docs[index]['long'],
                                              name: snapShot.data!.docs[index]
                                                  ['prdName'],
                                              price: snapShot.data!.docs[index]
                                                  ['price'],
                                              image: snapShot.data!.docs[index]
                                                  ['imageProfile'],
                                              desc: snapShot.data!.docs[index]
                                                  ['dsc'],
                                              category: snapShot.data!
                                                  .docs[index]['category'],
                                              productID:
                                                  snapShot.data!.docs[index].id,
                                              sellerID: snapShot.data!
                                                  .docs[index]['sellerID'],
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            width: Get.width * 0.4,
                                            height: Get.height * 0.26,
                                            decoration: BoxDecoration(
                                                color: AppColors
                                                    .commonWhiteTextColor,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Get.width * 0.05),
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 1,
                                                    color:
                                                        SColorPicker.fontGrey,
                                                  )
                                                ]),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Get.width * 0.02),
                                                      child: Image.network(
                                                        snapShot.data!
                                                                .docs[index]
                                                            ['imageProfile'],
                                                        height:
                                                            Get.height * 0.1,
                                                        width: Get.width * 0.4,
                                                        fit: BoxFit.cover,
                                                        errorBuilder:
                                                            (BuildContext
                                                                    context,
                                                                Object
                                                                    exception,
                                                                StackTrace?
                                                                    stackTrace) {
                                                          return Image.asset(
                                                            BImagePick.cartIcon,
                                                            height: Get.height *
                                                                0.1,
                                                            width:
                                                                Get.width * 0.4,
                                                            fit: BoxFit.cover,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.01,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.sp),
                                                  child: CustomText(
                                                    max: 1,
                                                    textOverflow:
                                                        TextOverflow.ellipsis,
                                                    text: snapShot.data!
                                                        .docs[index]['prdName'],
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.sp,
                                                    color: SColorPicker.purple,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.01,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.sp),
                                                  child: CustomText(
                                                    text: snapShot
                                                            .data!.docs[index]
                                                        ['category'],
                                                    textOverflow:
                                                        TextOverflow.ellipsis,
                                                    fontWeight: FontWeight.w600,
                                                    max: 1,
                                                    fontSize: 12.sp,
                                                    color: SColorPicker.black,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.01,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.sp),
                                                  child: CustomText(
                                                    text: snapShot.data!
                                                        .docs[index]['price'],
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12.sp,
                                                    color: SColorPicker.black,
                                                    alignment:
                                                        Alignment.centerLeft,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.01,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10.sp),
                                                  child: CustomText(
                                                    text: '(${km} KM away)',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 9.sp,
                                                    color: SColorPicker.black,
                                                    alignment:
                                                        Alignment.centerLeft,
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
                          )
                        : (_dropdownvalue.selected.value == '10 KM')
                            ? StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('Products')
                                    .where('createdOn',
                                        isLessThan: DateTime.now())
                                    .where('distanceBetweenInKM',
                                        isEqualTo: '10 KM')
                                    .snapshots(),
                                builder: (context, snapShot) {
                                  if (!snapShot.hasData) {
                                    return GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 5,
                                                mainAxisSpacing: 5,
                                                childAspectRatio: 1.7 / 2),
                                        itemCount: snapShot.data?.docs.length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          return Shimmer.fromColors(
                                            baseColor: Colors.grey.shade100,
                                            highlightColor:
                                                Colors.grey.shade200,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: Get.width * 0.4,
                                                height: Get.height * 0.26,
                                                decoration: BoxDecoration(
                                                    color: AppColors
                                                        .commonWhiteTextColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Get.width * 0.05),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 0,
                                                        color: SColorPicker
                                                            .fontGrey,
                                                      )
                                                    ]),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Container(
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      Get.width *
                                                                          0.02),
                                                          child: Container(
                                                            height: Get.height *
                                                                0.12,
                                                            width:
                                                                Get.width * 0.4,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.grey
                                                                  .shade100,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
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
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  10.sp),
                                                      child: Container(
                                                        height: 1.h,
                                                        width: Get.width * 0.4,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .grey.shade100,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * 0.01,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  10.sp),
                                                      child: Container(
                                                        height: 1.h,
                                                        width: Get.width * 0.4,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .grey.shade100,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * 0.01,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  10.sp),
                                                      child: Container(
                                                        height: 1.h,
                                                        width: Get.width * 0.4,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .grey.shade100,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
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
                                    return GridView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 5,
                                                mainAxisSpacing: 5,
                                                childAspectRatio: 1.7 / 2),
                                        itemCount: snapShot.data!.docs.length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          double productLat = double.parse(
                                              snapShot.data?.docs[index]
                                                  ['lat']);
                                          double productLong = double.parse(
                                              snapShot.data?.docs[index]
                                                  ['long']);
                                          double buyerLat = double.parse(
                                              PreferenceManager.getLat());
                                          double buyerLong = double.parse(
                                              PreferenceManager.getLong());

                                          double distanceInMeters =
                                              Geolocator.distanceBetween(
                                                  productLat,
                                                  productLong,
                                                  buyerLat,
                                                  buyerLong);

                                          var distanceBetween = distanceInMeters
                                              .toStringAsFixed(2);

                                          var distance = Distance();

                                          final km = distance.as(
                                            LengthUnit.Kilometer,
                                            LatLng(buyerLat, buyerLong),
                                            LatLng(productLat, productLong),
                                          );

                                          final m = distance.as(
                                            LengthUnit.Meter,
                                            LatLng(buyerLat, buyerLong),
                                            LatLng(productLat, productLong),
                                          );
                                          if (_dropdownvalue.selected.value ==
                                              '2 KM') {}
                                          return GestureDetector(
                                            onTap: () {
                                              // widget.pID = snapShot.data!.docs[index].id;

                                              print(
                                                  'imageProfile==${snapShot.data!.docs[index]['imageProfile']}');
                                              print(
                                                  "['prdName']--${snapShot.data!.docs[index]['prdName']}");
                                              print(
                                                  'DATA OF ID==${snapShot.data!.docs[index]}');
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
                                                  sellerLat: snapShot
                                                      .data!.docs[index]['lat'],
                                                  sellerLong: snapShot.data!
                                                      .docs[index]['long'],
                                                  name: snapShot.data!
                                                      .docs[index]['prdName'],
                                                  price: snapShot.data!
                                                      .docs[index]['price'],
                                                  image:
                                                      snapShot.data!.docs[index]
                                                          ['imageProfile'],
                                                  desc: snapShot
                                                      .data!.docs[index]['dsc'],
                                                  category: snapShot.data!
                                                      .docs[index]['category'],
                                                  productID: snapShot
                                                      .data!.docs[index].id,
                                                  sellerID: snapShot.data!
                                                      .docs[index]['sellerID'],
                                                ),
                                              );
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: Get.width * 0.4,
                                                height: Get.height * 0.26,
                                                decoration: BoxDecoration(
                                                    color: AppColors
                                                        .commonWhiteTextColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Get.width * 0.05),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 1,
                                                        color: SColorPicker
                                                            .fontGrey,
                                                      )
                                                    ]),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      Get.width *
                                                                          0.02),
                                                          child: Image.network(
                                                            snapShot.data!
                                                                    .docs[index]
                                                                [
                                                                'imageProfile'],
                                                            height: Get.height *
                                                                0.1,
                                                            width:
                                                                Get.width * 0.4,
                                                            fit: BoxFit.cover,
                                                            errorBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    Object
                                                                        exception,
                                                                    StackTrace?
                                                                        stackTrace) {
                                                              return Image
                                                                  .asset(
                                                                BImagePick
                                                                    .cartIcon,
                                                                height:
                                                                    Get.height *
                                                                        0.1,
                                                                width:
                                                                    Get.width *
                                                                        0.4,
                                                                fit: BoxFit
                                                                    .cover,
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * 0.01,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  10.sp),
                                                      child: CustomText(
                                                        max: 1,
                                                        textOverflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                        text: snapShot.data!
                                                                .docs[index]
                                                            ['prdName'],
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14.sp,
                                                        color:
                                                            SColorPicker.purple,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * 0.01,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  10.sp),
                                                      child: CustomText(
                                                        text: snapShot.data!
                                                                .docs[index]
                                                            ['category'],
                                                        textOverflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        max: 1,
                                                        fontSize: 12.sp,
                                                        color:
                                                            SColorPicker.black,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * 0.01,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  10.sp),
                                                      child: CustomText(
                                                        text: snapShot.data!
                                                                .docs[index]
                                                            ['price'],
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12.sp,
                                                        color:
                                                            SColorPicker.black,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * 0.01,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  10.sp),
                                                      child: CustomText(
                                                        text: '($km KM away)',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 9.sp,
                                                        color:
                                                            SColorPicker.black,
                                                        alignment: Alignment
                                                            .centerLeft,
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
                              )
                            : StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('Products')
                                    .where('createdOn',
                                        isLessThan: DateTime.now())
                                    .snapshots(),
                                builder: (context, snapShot) {
                                  if (!snapShot.hasData) {
                                    return GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 5,
                                                mainAxisSpacing: 5,
                                                childAspectRatio: 1.7 / 2),
                                        itemCount: snapShot.data?.docs.length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          return Shimmer.fromColors(
                                            baseColor: Colors.grey.shade100,
                                            highlightColor:
                                                Colors.grey.shade200,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: Get.width * 0.4,
                                                height: Get.height * 0.26,
                                                decoration: BoxDecoration(
                                                    color: AppColors
                                                        .commonWhiteTextColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Get.width * 0.05),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 0,
                                                        color: SColorPicker
                                                            .fontGrey,
                                                      )
                                                    ]),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5.0),
                                                      child: Container(
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      Get.width *
                                                                          0.02),
                                                          child: Container(
                                                            height: Get.height *
                                                                0.12,
                                                            width:
                                                                Get.width * 0.4,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.grey
                                                                  .shade100,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
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
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  10.sp),
                                                      child: Container(
                                                        height: 1.h,
                                                        width: Get.width * 0.4,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .grey.shade100,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * 0.01,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  10.sp),
                                                      child: Container(
                                                        height: 1.h,
                                                        width: Get.width * 0.4,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .grey.shade100,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * 0.01,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  10.sp),
                                                      child: Container(
                                                        height: 1.h,
                                                        width: Get.width * 0.4,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .grey.shade100,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
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
                                    return GridView.builder(
                                        physics: const BouncingScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 5,
                                                mainAxisSpacing: 5,
                                                childAspectRatio: 1.7 / 2),
                                        itemCount: snapShot.data!.docs.length,
                                        itemBuilder:
                                            (BuildContext context, index) {
                                          double productLat = double.parse(
                                              snapShot.data?.docs[index]
                                                  ['lat']);
                                          double productLong = double.parse(
                                              snapShot.data?.docs[index]
                                                  ['long']);
                                          double buyerLat = double.parse(
                                              PreferenceManager.getLat());
                                          double buyerLong = double.parse(
                                              PreferenceManager.getLong());

                                          double distanceInMeters =
                                              Geolocator.distanceBetween(
                                                  productLat,
                                                  productLong,
                                                  buyerLat,
                                                  buyerLong);

                                          var distanceBetween = distanceInMeters
                                              .toStringAsFixed(2);

                                          var distance = Distance();

                                          final km = distance.as(
                                            LengthUnit.Kilometer,
                                            LatLng(buyerLat, buyerLong),
                                            LatLng(productLat, productLong),
                                          );

                                          final m = distance.as(
                                            LengthUnit.Meter,
                                            LatLng(buyerLat, buyerLong),
                                            LatLng(productLat, productLong),
                                          );
                                          if (_dropdownvalue.selected.value ==
                                              '2 KM') {}
                                          return GestureDetector(
                                            onTap: () {
                                              // widget.pID = snapShot.data!.docs[index].id;

                                              print(
                                                  'imageProfile==${snapShot.data!.docs[index]['imageProfile']}');
                                              print(
                                                  "['prdName']--${snapShot.data!.docs[index]['prdName']}");
                                              print(
                                                  'DATA OF ID==${snapShot.data!.docs[index]}');
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
                                                  sellerLat: snapShot
                                                      .data!.docs[index]['lat'],
                                                  sellerLong: snapShot.data!
                                                      .docs[index]['long'],
                                                  name: snapShot.data!
                                                      .docs[index]['prdName'],
                                                  price: snapShot.data!
                                                      .docs[index]['price'],
                                                  image:
                                                      snapShot.data!.docs[index]
                                                          ['imageProfile'],
                                                  desc: snapShot
                                                      .data!.docs[index]['dsc'],
                                                  category: snapShot.data!
                                                      .docs[index]['category'],
                                                  productID: snapShot
                                                      .data!.docs[index].id,
                                                  sellerID: snapShot.data!
                                                      .docs[index]['sellerID'],
                                                ),
                                              );
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: Get.width * 0.4,
                                                height: Get.height * 0.26,
                                                decoration: BoxDecoration(
                                                    color: AppColors
                                                        .commonWhiteTextColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Get.width * 0.05),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 1,
                                                        color: SColorPicker
                                                            .fontGrey,
                                                      )
                                                    ]),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      Get.width *
                                                                          0.02),
                                                          child: Image.network(
                                                            snapShot.data!
                                                                    .docs[index]
                                                                [
                                                                'imageProfile'],
                                                            height: Get.height *
                                                                0.1,
                                                            width:
                                                                Get.width * 0.4,
                                                            fit: BoxFit.cover,
                                                            errorBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    Object
                                                                        exception,
                                                                    StackTrace?
                                                                        stackTrace) {
                                                              return Image
                                                                  .asset(
                                                                BImagePick
                                                                    .cartIcon,
                                                                height:
                                                                    Get.height *
                                                                        0.1,
                                                                width:
                                                                    Get.width *
                                                                        0.4,
                                                                fit: BoxFit
                                                                    .cover,
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * 0.01,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  10.sp),
                                                      child: CustomText(
                                                        max: 1,
                                                        textOverflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                        text: snapShot.data!
                                                                .docs[index]
                                                            ['prdName'],
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14.sp,
                                                        color:
                                                            SColorPicker.purple,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * 0.01,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  10.sp),
                                                      child: CustomText(
                                                        text: snapShot.data!
                                                                .docs[index]
                                                            ['category'],
                                                        textOverflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        max: 1,
                                                        fontSize: 12.sp,
                                                        color:
                                                            SColorPicker.black,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * 0.01,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  10.sp),
                                                      child: CustomText(
                                                        text: snapShot.data!
                                                                .docs[index]
                                                            ['price'],
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12.sp,
                                                        color:
                                                            SColorPicker.black,
                                                        alignment: Alignment
                                                            .centerLeft,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: Get.height * 0.01,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  10.sp),
                                                      child: CustomText(
                                                        text: '($km KM away)',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 9.sp,
                                                        color: SColorPicker
                                                            .fontGrey,
                                                        alignment: Alignment
                                                            .centerLeft,
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
              )),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        return true;
      },
    );
  }
}

class CustomTitleText extends StatelessWidget {
  CustomTitleText(
      {Key? key,
      required this.text,
      required this.fontWeight,
      required this.fontSize,
      required this.alignment})
      : super(key: key);

  String text;
  double fontSize;
  FontWeight fontWeight;
  Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text,
            style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                  color: AppColors.secondaryBlackColor,
                  fontSize: fontSize,
                  fontWeight: fontWeight),
            ),
          ),
          alignment: alignment,
        ),
      ],
    );
  }
}
