import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
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

  CollectionReference profileCollection = bFirebaseStore.collection('BProfile');
  BProfileViewModel _model = Get.find();
  DropdownValue _dropdownvalue = DropdownValue();
  TextEditingController searchController = TextEditingController();
  double? distanceInKM;
  String? buyerID, productID;
  String? sellerLat, sellerLong, buyerLat, buyerLong;
  String? category, pID;
  String searchText = '';
  List search = [];
  List<String> items = [];
  List<String> onSearchItem = [];

  String? name;
  String? phoneNo;
  String? Img;
  String? address;

  void onSearchtextChanged() {
    search.clear();
    if (searchController.text.isEmpty) {
      setState(() {
        return;
      });
    }

    onSearchItem.forEach((searchKey) {
      if (searchKey.toLowerCase().contains(searchController.text)) {
        search.add(searchKey);
        print('SEARCH METHOD-------${search}');
      }
    });
  }

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
      productID = getUserData?['productID'];
      sellerLong = getUserData?['sellerLong'];
      sellerLat = getUserData?['sellerLat'];
      buyerLat = getUserData?['buyerLat'];
      buyerLong = getUserData?['productID'];
    });
    print('getUserData:---${getUserData}');
  }

  Future<void> getUserData() async {
    print('demo buyer.....');
    final user = await profileCollection.doc(PreferenceManager.getUId()).get();
    Map<String, dynamic>? getUserData = user.data() as Map<String, dynamic>?;
    setState(() {
      name = getUserData?['user_name'];
      phoneNo = getUserData?['phoneno'];
      Img = getUserData?['imageProfile'];
      address = getUserData?['address'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    getSellerData();
  }

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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => DropdownButton(
                          value: _dropdownvalue.selected.value,
                          items: <String>['2.0 KM', '5.0 KM', '10.0 KM', 'All']
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

                            _dropdownvalue.setSelected(val!);
                            print(
                                'DROP VALUE -${_dropdownvalue.selected.value}');
                            print(_dropdownvalue.selected.value);
                            setState(
                              () {
                                if (_dropdownvalue.selected.value
                                    .contains(_dropdownvalue.selected.value)) {
                                  print('yes-----');
                                  print(
                                      '>>Yes>>${_dropdownvalue.selected.value}');
                                } else {
                                  print('NO-----');
                                  print('>>NO${_dropdownvalue.selected.value}');
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
        ),
      );
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
                          // CustomHomeSearchWidget(),
                          Container(
                            height: Get.height / 15,
                            width: Get.width / 1.5,
                            child: CupertinoTextField(
                              controller: searchController,
                              onChanged: (value) {
                                setState(() {
                                  // searchText = value;
                                  onSearchtextChanged();
                                });
                              },
                              // onTap: () {
                              //   Get.to(SearchScreen());
                              // },
                              keyboardType: TextInputType.text,
                              placeholder: 'Search items here',
                              placeholderStyle: TextStyle(
                                color: SColorPicker.fontGrey,
                                fontSize: 12.sp,
                                fontFamily: 'Brutal',
                              ),
                              prefix: Padding(
                                padding:
                                    EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
                                child: Icon(
                                  Icons.search,
                                  color: SColorPicker.fontGrey,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                                color: Color(0xffF0F1F5),
                              ),
                            ),
                          ),
                          FutureBuilder<QuerySnapshot>(
                            future: FirebaseFirestore.instance
                                .collection('Cart')
                                .doc(PreferenceManager.getUId())
                                .collection('MyCart')
                                .get(),
                            builder: (BuildContext context, snapshot) {
                              return GestureDetector(
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
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          drawer: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: CustomDrawerWidget(
                  name: name.toString(),
                  phoneNo: phoneNo.toString(),
                  address: address.toString(),
                  Img: Img.toString())),
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
                padding: EdgeInsets.symmetric(horizontal: 8.sp),
                child: _dropdownvalue.selected.value == '2.0 KM'
                    ? StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('Products')
                            .where('distanceBetweenInKM', isEqualTo: '2.0 KM')
                            .snapshots(),
                        builder: (context, snapShot) {
                          print(
                              '>>>>VALUE>>>>${_dropdownvalue.selected.value}');

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
                            ///search
                            List<DocumentSnapshot> info = snapShot.data!.docs;
                            // print("length======>${info.length}");
                            if (searchText.isNotEmpty) {
                              info = info.where((element) {
                                return element
                                    .get('prdName')
                                    .toString()
                                    .toLowerCase()
                                    .contains(searchText.toLowerCase());
                              }).toList();
                            }

                            ///
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
                                  print(
                                      'PreferenceManager.getLong()>>>> ${PreferenceManager.getLong()}');
                                  print(
                                      'PreferenceManager.getLat()>>>> ${PreferenceManager.getLat()}');
                                  print('productLong ${productLong}');
                                  print('productLat ${productLat}');
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
                                  CollectionReference ProfileCollection =
                                      bFirebaseStore.collection('Products');

                                  ProfileCollection.doc(
                                          snapShot.data?.docs[index].id)
                                      .update(
                                          {'distanceBetweenInKM': '$km KM'});

                                  return GestureDetector(
                                    onTap: () {
                                      // widget.pID = snapShot.data!.docs[index].id;

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
                                                    /*snapShot.data!
                                  .docs[index]
                              [
                              'imageProfile']*/
                                                    '${info[index].get('imageProfile')}',
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
                                                text: /*snapShot.data!
                              .docs[index]
                          ['prdName']*/
                                                    '${info[index].get('prdName')}',
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
                                                text: /*snapShot.data!
                              .docs[index]
                          ['category']*/
                                                    '${info[index].get('category')}',
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
                                                text: /*snapShot.data!
                              .docs[index]
                          ['price']*/
                                                    '${info[index].get('price')}',
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
                                                text: '($km KM away)',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 9.sp,
                                                color: SColorPicker.fontGrey,
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
                    : (_dropdownvalue.selected.value == '5.0 KM')
                        ? StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Products')
                                .where('distanceBetweenInKM',
                                    isEqualTo: '5.0 KM')
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
                                      CollectionReference ProfileCollection =
                                          bFirebaseStore.collection('Products');

                                      ProfileCollection.doc(
                                              snapShot.data?.docs[index].id)
                                          .update({
                                        'distanceBetweenInKM': '$km KM'
                                      });
                                      return GestureDetector(
                                        onTap: () {
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
                                                    text: '($km KM away)',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 9.sp,
                                                    color:
                                                        SColorPicker.fontGrey,
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
                        : (_dropdownvalue.selected.value == '10.0 KM')
                            ? StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('Products')
                                    .where('distanceBetweenInKM',
                                        isEqualTo: '10.0 KM')
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
                                          CollectionReference
                                              ProfileCollection = bFirebaseStore
                                                  .collection('Products');

                                          ProfileCollection.doc(
                                                  snapShot.data?.docs[index].id)
                                              .update({
                                            'distanceBetweenInKM': '$km KM'
                                          });

                                          return GestureDetector(
                                            onTap: () {
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
                              )
                            : searchController.text.isEmpty
                                ? StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('Products')
                                        .where("prdName",
                                            isGreaterThanOrEqualTo:
                                                searchController.text)
                                        .snapshots()
                                    /*FirebaseFirestore.instance
                                  .collection('Products')
                                  .where('createdOn',
                                  isLessThan: DateTime.now())
                                  .snapshots()*/
                                    ,
                                    builder: (context, snapShot) {
                                      if (!snapShot.hasData) {
                                        return GridView.builder(
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing: 5,
                                                    mainAxisSpacing: 5,
                                                    childAspectRatio: 1.7 / 2),
                                            itemCount:
                                                snapShot.data?.docs.length,
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
                                                            BorderRadius
                                                                .circular(
                                                                    Get.width *
                                                                        0.05),
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
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: Container(
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      Get.width *
                                                                          0.02),
                                                              child: Container(
                                                                height:
                                                                    Get.height *
                                                                        0.12,
                                                                width:
                                                                    Get.width *
                                                                        0.4,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .grey
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
                                                          height:
                                                              Get.height * 0.01,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10.sp),
                                                          child: Container(
                                                            height: 1.h,
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
                                                        SizedBox(
                                                          height:
                                                              Get.height * 0.01,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10.sp),
                                                          child: Container(
                                                            height: 1.h,
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
                                                        SizedBox(
                                                          height:
                                                              Get.height * 0.01,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10.sp),
                                                          child: Container(
                                                            height: 1.h,
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
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            });
                                      }
                                      if (snapShot.hasData) {
                                        return GridView.builder(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing: 5,
                                                    mainAxisSpacing: 5,
                                                    childAspectRatio: 1.7 / 2),
                                            itemCount:
                                                snapShot.data!.docs.length,
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
                                              print(
                                                  'PreferenceManager.getLong()>>>> ${PreferenceManager.getLong()}');
                                              print(
                                                  'PreferenceManager.getLat()>>>> ${PreferenceManager.getLat()}');
                                              print(
                                                  'productLong ${productLong}');
                                              print('productLat ${productLat}');
                                              double distanceInMeters =
                                                  Geolocator.distanceBetween(
                                                      productLat,
                                                      productLong,
                                                      buyerLat,
                                                      buyerLong);

                                              var distanceBetween =
                                                  distanceInMeters
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
                                              CollectionReference
                                                  ProfileCollection =
                                                  bFirebaseStore
                                                      .collection('Products');

                                              ProfileCollection.doc(snapShot
                                                      .data?.docs[index].id)
                                                  .update({
                                                'distanceBetweenInKM': '$km KM'
                                              });

                                              return GestureDetector(
                                                onTap: () {
                                                  // widget.pID = snapShot.data!.docs[index].id;

                                                  Get.to(
                                                    SelectedProductWidget(
                                                      sellerLat: snapShot.data!
                                                          .docs[index]['lat'],
                                                      sellerLong: snapShot.data!
                                                          .docs[index]['long'],
                                                      name: snapShot
                                                              .data!.docs[index]
                                                          ['prdName'],
                                                      price: snapShot.data!
                                                          .docs[index]['price'],
                                                      image: snapShot
                                                              .data!.docs[index]
                                                          ['imageProfile'],
                                                      desc: snapShot.data!
                                                          .docs[index]['dsc'],
                                                      category: snapShot
                                                              .data!.docs[index]
                                                          ['category'],
                                                      productID: snapShot
                                                          .data!.docs[index].id,
                                                      sellerID: snapShot
                                                              .data!.docs[index]
                                                          ['sellerID'],
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
                                                            BorderRadius
                                                                .circular(
                                                                    Get.width *
                                                                        0.05),
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
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      Get.width *
                                                                          0.02),
                                                              child:
                                                                  Image.network(
                                                                snapShot.data!
                                                                            .docs[
                                                                        index][
                                                                    'imageProfile'],
                                                                height:
                                                                    Get.height *
                                                                        0.1,
                                                                width:
                                                                    Get.width *
                                                                        0.4,
                                                                fit: BoxFit
                                                                    .cover,
                                                                errorBuilder: (BuildContext
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
                                                          height:
                                                              Get.height * 0.01,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
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
                                                            color: SColorPicker
                                                                .purple,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              Get.height * 0.01,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
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
                                                            color: SColorPicker
                                                                .black,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              Get.height * 0.01,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10.sp),
                                                          child: CustomText(
                                                            text: snapShot.data!
                                                                    .docs[index]
                                                                ['price'],
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 12.sp,
                                                            color: SColorPicker
                                                                .black,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              Get.height * 0.01,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10.sp),
                                                          child: CustomText(
                                                            text:
                                                                '($km KM away)',
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
                                  )
                                : StreamBuilder<QuerySnapshot>(
                                    stream: /*FirebaseFirestore.instance
                                  .collection('Products')
                                  .where('createdOn',
                                  isLessThan: DateTime.now())
                                  .snapshots()*/
                                        FirebaseFirestore.instance
                                            .collection('Products')
                                            .where("prdName",
                                                isGreaterThanOrEqualTo:
                                                    searchController.text)
                                            .where('prdName',
                                                isLessThan:
                                                    searchController.text + 'z')
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
                                            itemCount:
                                                snapShot.data?.docs.length,
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
                                                            BorderRadius
                                                                .circular(
                                                                    Get.width *
                                                                        0.05),
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
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: Container(
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      Get.width *
                                                                          0.02),
                                                              child: Container(
                                                                height:
                                                                    Get.height *
                                                                        0.12,
                                                                width:
                                                                    Get.width *
                                                                        0.4,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .grey
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
                                                          height:
                                                              Get.height * 0.01,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10.sp),
                                                          child: Container(
                                                            height: 1.h,
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
                                                        SizedBox(
                                                          height:
                                                              Get.height * 0.01,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10.sp),
                                                          child: Container(
                                                            height: 1.h,
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
                                                        SizedBox(
                                                          height:
                                                              Get.height * 0.01,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10.sp),
                                                          child: Container(
                                                            height: 1.h,
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
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            });
                                      }
                                      if (snapShot.hasData) {
                                        return GridView.builder(
                                            physics:
                                                const BouncingScrollPhysics(),
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    crossAxisSpacing: 5,
                                                    mainAxisSpacing: 5,
                                                    childAspectRatio: 1.7 / 2),
                                            itemCount:
                                                snapShot.data!.docs.length,
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
                                              print(
                                                  'PreferenceManager.getLong()>>>> ${PreferenceManager.getLong()}');
                                              print(
                                                  'PreferenceManager.getLat()>>>> ${PreferenceManager.getLat()}');
                                              print(
                                                  'productLong ${productLong}');
                                              print('productLat ${productLat}');
                                              double distanceInMeters =
                                                  Geolocator.distanceBetween(
                                                      productLat,
                                                      productLong,
                                                      buyerLat,
                                                      buyerLong);

                                              var distanceBetween =
                                                  distanceInMeters
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
                                              CollectionReference
                                                  ProfileCollection =
                                                  bFirebaseStore
                                                      .collection('Products');

                                              ProfileCollection.doc(snapShot
                                                      .data?.docs[index].id)
                                                  .update({
                                                'distanceBetweenInKM': '$km KM'
                                              });

                                              return GestureDetector(
                                                onTap: () {
                                                  // widget.pID = snapShot.data!.docs[index].id;

                                                  Get.to(
                                                    SelectedProductWidget(
                                                      sellerLat: snapShot.data!
                                                          .docs[index]['lat'],
                                                      sellerLong: snapShot.data!
                                                          .docs[index]['long'],
                                                      name: snapShot
                                                              .data!.docs[index]
                                                          ['prdName'],
                                                      price: snapShot.data!
                                                          .docs[index]['price'],
                                                      image: snapShot
                                                              .data!.docs[index]
                                                          ['imageProfile'],
                                                      desc: snapShot.data!
                                                          .docs[index]['dsc'],
                                                      category: snapShot
                                                              .data!.docs[index]
                                                          ['category'],
                                                      productID: snapShot
                                                          .data!.docs[index].id,
                                                      sellerID: snapShot
                                                              .data!.docs[index]
                                                          ['sellerID'],
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
                                                            BorderRadius
                                                                .circular(
                                                                    Get.width *
                                                                        0.05),
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
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      Get.width *
                                                                          0.02),
                                                              child:
                                                                  Image.network(
                                                                snapShot.data!
                                                                            .docs[
                                                                        index][
                                                                    'imageProfile'],
                                                                height:
                                                                    Get.height *
                                                                        0.1,
                                                                width:
                                                                    Get.width *
                                                                        0.4,
                                                                fit: BoxFit
                                                                    .cover,
                                                                errorBuilder: (BuildContext
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
                                                          height:
                                                              Get.height * 0.01,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
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
                                                            color: SColorPicker
                                                                .purple,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              Get.height * 0.01,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
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
                                                            color: SColorPicker
                                                                .black,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              Get.height * 0.01,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10.sp),
                                                          child: CustomText(
                                                            text: snapShot.data!
                                                                    .docs[index]
                                                                ['price'],
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 12.sp,
                                                            color: SColorPicker
                                                                .black,
                                                            alignment: Alignment
                                                                .centerLeft,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              Get.height * 0.01,
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10.sp),
                                                          child: CustomText(
                                                            text:
                                                                '($km KM away)',
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
