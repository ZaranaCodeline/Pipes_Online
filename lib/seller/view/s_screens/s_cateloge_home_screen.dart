import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/buyer/view_model/geolocation_controller.dart';

import 'package:pipes_online/seller/view/s_screens/s_color_picker.dart';

import 'package:pipes_online/seller/view/s_screens/s_drawer_screen.dart';

import 'package:pipes_online/seller/view_model/s_edit_product_controller.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import '../../../buyer/app_constant/app_colors.dart';
import '../../../buyer/app_constant/auth.dart';
import '../../../buyer/app_constant/b_image.dart';

import '../../../routes/bottom_controller.dart';
import '../../common/s_text_style.dart';
import '../../view_model/profile_view_model.dart';
import '../../view_model/s_add_product_controller.dart';

class SCatelogeHomeScreen extends StatefulWidget {
  const SCatelogeHomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SCatelogeHomeScreen> createState() => _SCatelogeHomeScreenState();
}

class _SCatelogeHomeScreenState extends State<SCatelogeHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  BottomController homeController = Get.find();
  bool isLoading = false;
  AddProductController addProductController = Get.put(AddProductController());

  CollectionReference ProfileCollection = bFirebaseStore.collection('SProfile');
  GeolocationController geolocationController = Get.find();
  TextEditingController searchController = TextEditingController();

  String searchText = '';
  List search = [];
  List<String> items = [];
  List<String> onSearchItem = [];
  String? name;
  String? phoneNo;
  String? Img;
  String? address;

  Future<void> getUserData() async {
    print('demo seller.....');
    final user =
        await ProfileCollection.doc('${PreferenceManager.getUId()}').get();
    Map<String, dynamic>? getUserData = user.data() as Map<String, dynamic>?;

    setState(() {
      name = getUserData?['user_name'];
      phoneNo = getUserData?['phoneno'];
      Img = getUserData?['imageProfile'];
      address = getUserData?['address'];
    });
  }

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

  @override
  void initState() {
    print('sellerName: ${PreferenceManager.getName()}');
    // TODO: implement initState
    super.initState();
    print('Seller User Name ${PreferenceManager.getName()}');
    getUserData();
    print(
        'LAT-Controller>>>>>  ${geolocationController.latitude.value.toString()}-LONG-Controller>>>> ${geolocationController.longitude.value.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            padding: EdgeInsets.only(bottom: Get.height / 9.sp, left: 15.sp),
            icon: SvgPicture.asset(
              'assets/images/svg/drawer_icon.svg',
              width: 15.sp,
              height: 15.sp,
            ),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                padding:
                    EdgeInsets.only(bottom: Get.height / 9.sp, left: 15.sp),
                icon: SvgPicture.asset(
                  'assets/images/svg/s_add_pro_icon.svg',
                  width: 23.sp,
                  height: 23.sp,
                ),
                onPressed: () {
                  homeController.selectedScreen('SOrdersScreen');
                  homeController.bottomIndex.value = 1;
                },
              ),
            ),
          ],
          flexibleSpace: FlexibleSpaceBar(
            background: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.07,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.sp),
                  child: GestureDetector(
                    onTap: () {
                      isLoading = true;
                    },
                    child: Container(
                      height: Get.height / 15,
                      width: Get.width / 1.2,
                      child: CupertinoTextField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {
                            onSearchtextChanged();
                          });
                        },
                        keyboardType: TextInputType.text,
                        placeholder: 'Search items here',
                        placeholderStyle: TextStyle(
                          color: SColorPicker.fontGrey,
                          fontSize: 12.sp,
                          fontFamily: 'Ubuntu',
                        ),
                        prefix: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
                          child: Icon(
                            Icons.search,
                            color: SColorPicker.fontGrey,
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: const Color(0xffF0F1F5),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          foregroundColor: AppColors.commonWhiteTextColor,
          backgroundColor: AppColors.primaryColor,
          title: Container(
              padding: EdgeInsets.only(top: 0.sp),
              margin: EdgeInsets.only(bottom: Get.height / 9.sp),
              child: Image.asset(
                'assets/images/png/pipe_logo.png',
                fit: BoxFit.fill,
                height: 35,
              )),
          centerTitle: true,
          toolbarHeight: Get.height * 0.13.sp,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25),
            ),
          ),
        ),
        drawer: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: SDrawerScreen(
            address: address.toString(),
            Img: Img.toString(),
            phoneNo: phoneNo.toString(),
            name: name.toString(),
          ),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * 0.02.sp,
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'My Products',
                        style: STextStyle.bold700Purple16,
                      )),
                  SizedBox(
                    height: Get.height * 0.01.sp,
                  ),
                  // SCustomProductCard(),
                  Container(
                    height: Get.height * 0.7,
                    child: searchController.text.isEmpty
                        ? StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Products')
                                .where('createdOn', isLessThan: DateTime.now())
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
                                if (snapShot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (snapShot.connectionState ==
                                    ConnectionState.done) {}
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
                                    return GestureDetector(
                                      onTap: () {
                                        print('gfvf');
                                        print(
                                            'DATA OF ID${snapShot.data!.docs[index].id}');

                                        EditProductContoller
                                            editProductContoller =
                                            Get.put(EditProductContoller());
                                        print(
                                            'prdName==>${editProductContoller.selectedName = snapShot.data!.docs[index]['prdName']}');
                                        print(
                                            'selectedPrice==>${editProductContoller.selectedPrice = editProductContoller.selectedPrice}');
                                        print(
                                            'selectedPrice====>${editProductContoller.selectedPrice = (snapShot.data!.docs[index]['price'])}');

                                        editProductContoller.selectedID(
                                            snapShot.data!.docs[index].id);

                                        homeController.selectedScreen(
                                            'SSelectedProductScreen');
                                        homeController.bottomIndex.value = 0;
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
                                                    child: snapShot.data!.docs[
                                                                        index][
                                                                    'imageProfile'] ==
                                                                null ||
                                                            snapShot.data!.docs[
                                                                        index][
                                                                    'imageProfile'] ==
                                                                ''
                                                        ? const Center(
                                                            child:
                                                                CircularProgressIndicator())
                                                        : Image.network(
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
                                                      .data!.docs[index]['dsc'],
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
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primaryColor,
                                  ),
                                );
                              }
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
                                        isLessThan: searchController.text + 'z')
                                    .snapshots()
                            /* FirebaseFirestore.instance
                                        .collection('Products')
                                        .where('createdOn',
                                            isLessThan: DateTime.now())
                                        .where("prdName",
                                            isGreaterThanOrEqualTo:
                                                searchController.text)
                                        .where('prdName',
                                            isLessThan:
                                                searchController.text + 'z')
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
                                if (snapShot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (snapShot.connectionState ==
                                    ConnectionState.done) {}
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
                                    return GestureDetector(
                                      onTap: () {
                                        print('gfvf');
                                        print(
                                            'DATA OF ID${snapShot.data!.docs[index].id}');

                                        EditProductContoller
                                            editProductContoller =
                                            Get.put(EditProductContoller());
                                        print(
                                            'prdName==>${editProductContoller.selectedName = snapShot.data!.docs[index]['prdName']}');
                                        print(
                                            'selectedPrice==>${editProductContoller.selectedPrice = editProductContoller.selectedPrice}');
                                        print(
                                            'selectedPrice====>${editProductContoller.selectedPrice = (snapShot.data!.docs[index]['price'])}');

                                        editProductContoller.selectedID(
                                            snapShot.data!.docs[index].id);

                                        homeController.selectedScreen(
                                            'SSelectedProductScreen');
                                        homeController.bottomIndex.value = 0;
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
                                                    child: snapShot.data!.docs[
                                                                        index][
                                                                    'imageProfile'] ==
                                                                null ||
                                                            snapShot.data!.docs[
                                                                        index][
                                                                    'imageProfile'] ==
                                                                ''
                                                        ? const Center(
                                                            child:
                                                                CircularProgressIndicator())
                                                        : Image.network(
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
                                                      .data!.docs[index]['dsc'],
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
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.primaryColor,
                                  ),
                                );
                              }
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('hello');
            if (PreferenceManager.getSubscribeCategory() != null ||
                PreferenceManager.getSubscribeCategory() != '' &&
                    PreferenceManager.getSubscribeTime() != null ||
                PreferenceManager.getSubscribeTime() != null) {
              print(
                  '---subscribe category----->${PreferenceManager.getSubscribeCategory()}');
              print('else if if part');
              homeController.selectedScreen('SShowSubcriptionValueScreen');
              homeController.bottomIndex.value = 0;
            } else if (PreferenceManager.getSubscribeCategory() == null ||
                PreferenceManager.getSubscribeCategory() == '' &&
                    PreferenceManager.getSubscribeTime() == null ||
                PreferenceManager.getSubscribeTime() == null) {
              print('else if part');
              homeController.selectedScreen('SSubscribeScreen');
              homeController.bottomIndex.value = 0;
            }
          },
          child: Container(
            width: Get.width * 0.15.sp,
            height: Get.height / 9.sp,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(50.sp),
            ),
            child: Icon(
              Icons.add,
              color: AppColors.commonWhiteTextColor,
              size: 20.sp,
            ),
          ),
        ),
      ),
    );
  }
}
