import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/screens/b_selected_product_widget.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:sizer/sizer.dart';
import '../../seller/view/s_screens/s_color_picker.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isSelected = false;
  List<String> items = [];
  List<String> onSearchItem = [];
  TextEditingController searchController = TextEditingController();
  List search = [];
  @override
  Widget build(BuildContext context) {
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

    var collection = FirebaseFirestore.instance
        .collection('Products')
        .where('prdName',
            isGreaterThanOrEqualTo: searchController.text.toLowerCase())
        .get();

    return FutureBuilder<QuerySnapshot>(
      future: collection,
      builder: (BuildContext context, snapShot) {
        if (!snapShot.hasData)
          return new Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          );
        if (!snapShot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapShot.hasData) {
          print('prdName-${snapShot.data?.docs.length}');
          snapShot.data?.docs.forEach((proLength) {
            items.add(proLength['prdName']);
          });
          print('products-name-${items}');
          return Scaffold(
            appBar: AppBar(
              actions: [],
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.arrow_back_rounded),
              ),
              title: Container(
                height: Get.height / 15,
                width: Get.width / 1,
                child: CupertinoTextField(
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                  onChanged: (proLength) {
                    setState(() {
                      print('kkkk');
                      // searchController.clear();
                      setState(() {
                        onSearchtextChanged();
                      });
                    });
                  },
                  controller: searchController,
                  keyboardType: TextInputType.text,
                  placeholder: 'Search products here...',
                  placeholderStyle: TextStyle(
                    color: SColorPicker.fontGrey,
                    fontSize: 12.sp,
                    fontFamily: 'Ubuntu-Regular',
                  ),
                  onTap: () {
                    print('custom search');
                    // Get.to(SearchScreen());
                  },
                  suffix: IconButton(
                    onPressed: () {
                      searchController.clear();
                    },
                    icon: searchController.text.isNotEmpty
                        ? Icon(
                            Icons.clear,
                            color: SColorPicker.fontGrey,
                          )
                        : Icon(
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
              centerTitle: true,
              backgroundColor: AppColors.primaryColor,
              toolbarHeight: Get.height * 0.15,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
            ),
            body: /*search.length != 0 || searchController.text.isNotEmpty*/ searchController
                    .text.isEmpty
                ? StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Products')
                        .where("prdName",
                            isGreaterThanOrEqualTo: searchController.text)
                        .snapshots(),
                    builder: (context, snapShot) {
                      if (!snapShot.hasData)
                        return new Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        );
                      if (snapShot.hasData) {
                        return ListView.builder(
                          itemCount: snapShot.data?.docs.length,
                          itemBuilder: (context, index) {
                            onSearchItem
                                .add(snapShot.data!.docs[index]['prdName']);
                            print(search);
                            print('bbbbb---');
                            return GestureDetector(
                              onTap: () {
                                print('clicked....');
                                Get.to(
                                  SelectedProductWidget(
                                    name: snapShot.data!.docs[index]['prdName'],
                                    image: snapShot.data!.docs[index]
                                        ['imageProfile'],
                                    desc: snapShot.data!.docs[index]['dsc'],
                                    price: snapShot.data!.docs[index]['price'],
                                    category: snapShot.data!.docs[index]
                                        ['category'],
                                    productID: snapShot.data!.docs[index].id,
                                    sellerID: snapShot.data!.docs[index]
                                        ['sellerID'],
                                  ),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.all(15.sp),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: Get.width * 0.35,
                                          height: Get.height / 7,
                                          // flex: 3,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Image.network(
                                              snapShot.data!.docs[index]
                                                  ['imageProfile'],
                                              fit: BoxFit.cover,
                                            ),
                                          ) /*: SizedBox()*/,
                                        ),
                                        Flexible(
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 15.sp),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  text: snapShot.data!
                                                      .docs[index]['prdName'],
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16.sp,
                                                  color: AppColors.primaryColor,
                                                  alignment: Alignment.topLeft,
                                                  textOverflow:
                                                      TextOverflow.ellipsis,
                                                  max: 1,
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.01.sp,
                                                ),
                                                CustomText(
                                                  text: snapShot.data!
                                                      .docs[index]['category'],
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.sp,
                                                  color: AppColors
                                                      .secondaryBlackColor,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.01.sp,
                                                ),
                                                CustomText(
                                                  text: snapShot.data!
                                                      .docs[index]['price'],
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.sp,
                                                  color: AppColors
                                                      .secondaryBlackColor,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return SizedBox();
                    },
                  )
                : StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('Products')
                        .where("prdName",
                            isGreaterThanOrEqualTo: searchController.text)
                        .where('prdName',
                            isLessThan: searchController.text + 'z')
                        .snapshots(),
                    builder: (context, snapShot) {
                      print('chatt---------');
                      if (!snapShot.hasData)
                        return new Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        );
                      if (snapShot.hasData) {
                        return ListView.builder(
                          itemCount: snapShot.data?.docs.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                print('clicked....');
                                Get.to(
                                  SelectedProductWidget(
                                    name: snapShot.data!.docs[index]['prdName'],
                                    image: snapShot.data!.docs[index]
                                        ['imageProfile'],
                                    desc: snapShot.data!.docs[index]['dsc'],
                                    price: snapShot.data!.docs[index]['price'],
                                    category: snapShot.data!.docs[index]
                                        ['category'],
                                    productID: snapShot.data!.docs[index].id,
                                    sellerID: snapShot.data!.docs[index]
                                        ['sellerID'],
                                  ),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.all(15.sp),
                                child: Column(
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: Get.width * 0.35,
                                          height: Get.height / 7,
                                          // flex: 3,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Image.network(
                                              snapShot.data!.docs[index]
                                                  ['imageProfile'],
                                              fit: BoxFit.cover,
                                            ),
                                          ) /*: SizedBox()*/,
                                        ),
                                        Flexible(
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 15.sp),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  text: snapShot.data!
                                                      .docs[index]['prdName'],
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 16.sp,
                                                  color: AppColors.primaryColor,
                                                  alignment: Alignment.topLeft,
                                                  textOverflow:
                                                      TextOverflow.ellipsis,
                                                  max: 1,
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.01.sp,
                                                ),
                                                CustomText(
                                                  text: snapShot.data!
                                                      .docs[index]['category'],
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.sp,
                                                  color: AppColors
                                                      .secondaryBlackColor,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.01.sp,
                                                ),
                                                CustomText(
                                                  text: snapShot.data!
                                                      .docs[index]['price'],
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.sp,
                                                  color: AppColors
                                                      .secondaryBlackColor,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return SizedBox();
                    },
                  ),
          );
        }
        return Container();
      },
    );
  }
}
