import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/screens/b_image.dart';
import 'package:pipes_online/buyer/screens/b_payment_page.dart';
import 'package:pipes_online/payment_service/payment_key.dart';
import 'package:pipes_online/payment_service/paypal_payment.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';
import '../../seller/common/s_text_style.dart';
import '../app_constant/app_colors.dart';
import 'custom_widget/custom_text.dart';
import 'bottom_bar_screen_page/widget/b_home_bottom_bar_route.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  final String? name, image, desc, price, category, productID, cartID, sellerID;

  const CartPage(
      {Key? key,
      this.price,
      this.desc,
      this.name,
      this.image,
      this.category,
      this.productID,
      this.sellerID,
      this.cartID})
      : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String? dropdownValueSize;
  String? dropdownValueLength;
  String? dropdownValueWeight;
  String? dropdownValueOil;
  String? dropdownValueFootage;
  String? dropdownValueOD;
  String? dropdownValueWall;
  String? dropdownValueWTperft;
  String? dropdownValuePipeTagColor;

  var sizeItems = [
    'select',
    '1 mm',
    '2 mm',
    '3 mm',
    '4 mm',
    '5 mm',
    '6 mm',
    '7 mm',
    '8 mm',
    '9 mm',
    '10 mm',
  ];
  bool isLoading = false;
  CollectionReference profileCollection = bFirebaseStore.collection('BProfile');
  String? firstname, buyerImage, buyerID, buyerAddress, buyerPhone, buyerName;
  String? Img;
  Map<String, dynamic>? paymentIntentData;
  TextEditingController? address;

  Future<void> getData() async {
    print('demo.....');
    final user = await profileCollection
        .doc('${FirebaseAuth.instance.currentUser!.uid}')
        .get();
    Map<String, dynamic>? getUserData = user.data() as Map<String, dynamic>?;
    setState(() {
      address = TextEditingController(text: getUserData?['address']);
      buyerImage = getUserData?['imageProfile'];
      buyerID = PreferenceManager.getUId();
      buyerAddress = getUserData?['address'];
      buyerPhone = getUserData?['phoneno'];
      buyerName = getUserData?['user_name'];
    });

    print('=========firstname===============${buyerName}');
    print('======address======${buyerAddress}');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('address--${address}');
    print('==address==${PreferenceManager.getAddress()}');
    print('=========firstname===============${firstname}');
    print('<<<<<SELLER_ID>>>>>>${widget.sellerID}');
    print('<<<<<productID>>>>>>${widget.productID}');
    getData();
  }

  @override
  Widget build(BuildContext context) {
    print('widget.category================>${widget.category}');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
          title: Text(
            'YOUR CART',
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
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15.0.sp),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(widget.image.toString(),
                                    // BImagePick.cartIcon,
                                    fit: BoxFit.cover,
                                    height: Get.height / 5.sp, errorBuilder:
                                        (BuildContext context, Object exception,
                                            StackTrace? stackTrace) {
                                  return Image.asset(
                                    BImagePick.cartIcon,
                                    height: Get.height / 5.sp,
                                    // width: Get.width * 0.4,
                                    fit: BoxFit.cover,
                                  );
                                }),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 20.sp),
                                child: Column(
                                  children: [
                                    CustomText(
                                      text: widget.name.toString(),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16.sp,
                                      color: AppColors.primaryColor,
                                      alignment: Alignment.topLeft,
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01.sp,
                                    ),
                                    CustomText(
                                      text: widget.desc.toString(),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
                                      color: AppColors.secondaryBlackColor,
                                      alignment: Alignment.centerLeft,
                                    ),
                                    SizedBox(
                                      height: Get.height * 0.01.sp,
                                    ),
                                    CustomText(
                                      text: widget.price.toString(),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
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
                      CustomDropDownWidget(
                        keyName: 'Size :      ',
                        dropDownValue: dropdownValueSize,
                        onChange: (String? newValue) {
                          dropdownValueSize = newValue!;
                          print('dropdownValueSize:-$dropdownValueSize');
                          setState(() {});
                        },
                      ),
                      CustomDropDownWidget(
                        keyName: 'Length : ',
                        dropDownValue: dropdownValueLength,
                        onChange: (String? newValue) {
                          dropdownValueLength = newValue!;
                          print('dropdownValueLength:-$dropdownValueLength');
                          setState(() {});
                        },
                      ),
                      CustomDropDownWidget(
                        keyName: 'Weight :',
                        dropDownValue: dropdownValueWeight,
                        onChange: (String? newValue) {
                          dropdownValueWeight = newValue!;
                          print('dropdownValueWeight:-$dropdownValueWeight');
                          setState(() {});
                        },
                      ),
                      CustomDropDownWidget(
                        keyName: 'Oil :        ',
                        dropDownValue: dropdownValueOil,
                        onChange: (String? newValue) {
                          dropdownValueOil = newValue!;
                          print('dropdownValueOil:-$dropdownValueOil');
                          setState(() {});
                        },
                      ),
                      CustomDropDownWidget(
                        keyName: 'Footage:      ',
                        dropDownValue: dropdownValueFootage,
                        onChange: (String? newValue) {
                          dropdownValueFootage = newValue!;
                          print('dropdownValueSize:-$dropdownValueFootage');
                          setState(() {});
                        },
                      ),
                      CustomDropDownWidget(
                        keyName: 'O.D.:      ',
                        dropDownValue: dropdownValueOD,
                        onChange: (String? newValue) {
                          dropdownValueOD = newValue!;
                          print('dropdownValueSize:-$dropdownValueOD');
                          setState(() {});
                        },
                      ),
                      CustomDropDownWidget(
                        keyName: 'Wall:      ',
                        dropDownValue: dropdownValueWall,
                        onChange: (String? newValue) {
                          dropdownValueWall = newValue!;
                          print('dropdownValueSize:-$dropdownValueWall');
                          setState(() {});
                        },
                      ),
                      CustomDropDownWidget(
                        keyName: 'WT. per ft:      ',
                        dropDownValue: dropdownValueWTperft,
                        onChange: (String? newValue) {
                          dropdownValueWTperft = newValue!;
                          print('dropdownValueSize:-$dropdownValueWTperft');
                          setState(() {});
                        },
                      ),
                      widget.category == 'Gas' || widget.category == 'Oil'
                          ? CustomDropDownWidget(
                              keyName: 'Pipe Tag Color:      ',
                              dropDownValue: dropdownValuePipeTagColor,
                              onChange: (String? newValue) {
                                dropdownValuePipeTagColor = newValue!;
                                print(
                                    'dropdownValueSize:-$dropdownValuePipeTagColor');
                                setState(() {});
                              },
                            )
                          : Container(),
                    ],
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15.sp),
                        child: Column(
                          children: [
                            CustomText(
                              text: 'Address : ',
                              fontWeight: FontWeight.w600,
                              fontSize: 14.sp,
                              color: AppColors.secondaryBlackColor,
                              alignment: Alignment.topLeft,
                            ),
                            SizedBox(
                              height: Get.height * 0.01.sp,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              width: Get.width * 5,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.sp, vertical: 10.sp),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: AppColors.commonWhiteTextColor),
                              child: Container(
                                child: TextField(
                                  controller: address,
                                  decoration: InputDecoration(
                                    suffixIcon: Icon(
                                      Icons.edit,
                                      size: 15.sp,
                                    ),
                                    hintText: 'Enter Your Address',
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                  ),
                                  maxLines: 2,
                                  keyboardType: TextInputType.multiline,
                                  // minLines: 1,
                                ),
                              ),
                            ),
                            FutureBuilder<DocumentSnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection('Products')
                                  .doc(widget.productID)
                                  .get(),
                              builder: (BuildContext context, snapShot) {
                                if (snapShot.hasData) {
                                  var output = snapShot.data;
                                  // var sellerID = snapShot.data?['sellerID'];
                                  // print('SELLER ID>>>>> $sellerID');
                                  return Card(
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              CustomText(
                                                  text: 'Cart total :',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.sp,
                                                  color: AppColors
                                                      .secondaryBlackColor),
                                              CustomText(
                                                  text: widget.price.toString(),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.sp,
                                                  color: AppColors
                                                      .secondaryBlackColor),
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            /*await profileCollection
                                                  .doc(PreferenceManager
                                                      .getUId())
                                                  .update({
                                                'address': address?.text,
                                              }).then((value) {
                                                */
                                            Get.to(PaymentWidget(
                                              cartID: widget.cartID,
                                              proOilPipe: 'oil',
                                              pLength: '2 Km',
                                              pSize: '10 mm',
                                              pWeight: '10',
                                              bAddress: address!.text,
                                              bID: buyerID,
                                              category: widget.category,
                                              proID: widget.productID,
                                              desc: widget.desc,
                                              bName: buyerName,
                                              bPhone: buyerPhone,
                                              proName: widget.name,
                                              proPrice: widget.price,
                                              bImage: buyerImage,
                                              proImage: widget.image,
                                              sellerID: output?['sellerID'],
                                              sellerLong: output?['long'],
                                              sellerLat: output?['lat'],
                                              sellerAddress:
                                                  output?['sellerAddress'],
                                              sellerImage: output?['sellerImg'],
                                              sellerPhone:
                                                  output?['sellerPhone'],
                                              sellerName: output?['sellerName'],
                                            ));
                                            // });

                                            // showModalBottomSheet<void>(
                                            //   elevation: 0.5,
                                            //   shape: const RoundedRectangleBorder(
                                            //       borderRadius: BorderRadius.only(
                                            //           topLeft:
                                            //               Radius.circular(20.0),
                                            //           topRight:
                                            //               Radius.circular(20.0))),
                                            //   backgroundColor: Colors.white,
                                            //   context: context,
                                            //   builder: (context) =>
                                            //       FractionallySizedBox(
                                            //     heightFactor: 0.5.sp,
                                            //     child: Padding(
                                            //       padding: const EdgeInsets.all(15),
                                            //       child: Column(
                                            //         mainAxisAlignment:
                                            //             MainAxisAlignment
                                            //                 .spaceEvenly,
                                            //         children: [
                                            //           Container(
                                            //             width: 35.sp,
                                            //             height: 5.sp,
                                            //             decoration: BoxDecoration(
                                            //                 borderRadius:
                                            //                     BorderRadius
                                            //                         .circular(15),
                                            //                 color: AppColors
                                            //                     .primaryColor),
                                            //           ),
                                            //           const SizedBox(
                                            //             height: 0.2,
                                            //           ),
                                            //           CustomText(
                                            //               alignment:
                                            //                   Alignment.topLeft,
                                            //               text: 'Payment Options',
                                            //               fontWeight:
                                            //                   FontWeight.w400,
                                            //               fontSize: 14.sp,
                                            //               color: AppColors
                                            //                   .secondaryBlackColor),
                                            //           Container(
                                            //             child: MaterialButton(
                                            //               child: Row(
                                            //                 mainAxisAlignment:
                                            //                     MainAxisAlignment
                                            //                         .start,
                                            //                 children: [
                                            //                   Icon(
                                            //                     Icons
                                            //                         .paypal_outlined,
                                            //                     color: AppColors
                                            //                         .primaryColor,
                                            //                   ),
                                            //                   SizedBox(
                                            //                     width: Get.width *
                                            //                         0.05,
                                            //                   ),
                                            //                   Text(
                                            //                     'Pay with Paypal',
                                            //                     style: TextStyle(
                                            //                         color: AppColors
                                            //                             .primaryColor,
                                            //                         fontSize:
                                            //                             14.sp),
                                            //                   ),
                                            //                 ],
                                            //               ),
                                            //               onPressed: () {
                                            //                 payWithPaypal();
                                            //               },
                                            //             ),
                                            //           ),
                                            //           Container(
                                            //             child: MaterialButton(
                                            //               child: Row(
                                            //                 mainAxisAlignment:
                                            //                     MainAxisAlignment
                                            //                         .start,
                                            //                 children: [
                                            //                   Icon(
                                            //                     Icons
                                            //                         .payment_outlined,
                                            //                     color: AppColors
                                            //                         .primaryColor,
                                            //                   ),
                                            //                   SizedBox(
                                            //                     width: Get.width *
                                            //                         0.05,
                                            //                   ),
                                            //                   Text(
                                            //                     'Pay With Stripe',
                                            //                     style: TextStyle(
                                            //                         color: AppColors
                                            //                             .primaryColor,
                                            //                         fontSize:
                                            //                             14.sp),
                                            //                   ),
                                            //                 ],
                                            //               ),
                                            //               onPressed: () {
                                            //                 payWithStrip();
                                            //               },
                                            //             ),
                                            //           ),
                                            //         ],
                                            //       ),
                                            //     ),
                                            //   ),
                                            // );
                                            // print('success add');
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: AppColors.primaryColor,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                CustomText(
                                                    text: 'Checkout Now : ',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.sp,
                                                    color: AppColors
                                                        .commonWhiteTextColor),
                                                CustomText(
                                                    text:
                                                        widget.price.toString(),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.sp,
                                                    color: AppColors
                                                        .commonWhiteTextColor),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return Container();
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget CustomDropDownWidget(
      {String? keyName, dynamic onChange, String? dropDownValue}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.sp),
      child: Row(
        children: [
          CustomText(
              text: keyName!,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: AppColors.secondaryBlackColor),
          SizedBox(
            width: Get.width * .1,
          ),
          Card(
            elevation: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 5.sp,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(blurRadius: 1, color: AppColors.offWhiteColor),
                  ]),
              child: DropdownButton(
                  hint: Text('Select'),
                  value: dropDownValue,
                  icon: Icon(
                    Icons.arrow_drop_down_outlined,
                    color: AppColors.secondaryBlackColor,
                    size: 18.sp,
                  ),
                  items: sizeItems.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: CustomText(
                        text: items,
                        color: AppColors.secondaryBlackColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        textDecoration: TextDecoration.none,
                      ),
                    );
                  }).toList(),
                  onChanged: onChange),
            ),
          ),
          // CustomDropDownWidget(),
        ],
      ),
    );
  }
}
