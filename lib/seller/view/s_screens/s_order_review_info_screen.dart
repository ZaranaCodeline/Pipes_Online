import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/app_constant/b_image.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:pipes_online/seller/view/s_screens/s_seller_review_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_earning_screen.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../../../buyer/screens/custom_widget/custom_text.dart';
import '../../common/s_common_button.dart';

class SorderReviewInfoScreen extends StatefulWidget {
  SorderReviewInfoScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SorderReviewInfoScreen> createState() => _SorderReviewInfoScreenState();
}

class _SorderReviewInfoScreenState extends State<SorderReviewInfoScreen> {
  var rating = 3.0;
  var orderDocID = Get.arguments;

  CollectionReference profileCollection = bFirebaseStore.collection('Orders');

  String? buyerName,
      orderID,
      proName,
      productId,
      payment,
      size,
      length,
      weigth,
      oil,
      address,
      createdOn,
      Img;
  String? formattedDateTime;

  Future<void> getData() async {
    print('demo.....');
    final user = await profileCollection.doc(orderDocID).get();
    Map<String, dynamic>? getUserData = user.data() as Map<String, dynamic>?;
    print('=========firstname===============${getUserData}');
    setState(() {
      orderID = getUserData?['orderID'];
      buyerName = getUserData?['buyerName'];
      proName = getUserData?['prdName'];
      productId = getUserData?['productID'];
      payment = getUserData?['price'];
      size = getUserData?['size'];
      length = getUserData?['length'];
      weigth = getUserData?['weight'];
      oil = getUserData?['oil'];
      address = getUserData?['address'];
      Img = getUserData?['productImage'];
      createdOn = getUserData?['createdOn'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderDocID = Get.arguments;
    print('---ORDERID----${orderDocID}');
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                          child: Img != null
                              ? Image.network(
                                  Img.toString(),
                                  height: Get.height / 4,
                                  width: double.infinity,
                                )
                              : CircularProgressIndicator() /*Image.asset(
                                BImagePick.proIcon,
                                fit: BoxFit.cover,
                                width: Get.width * 1,
                                height: Get.height / 5,
                              ),*/
                          ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.sp),
                        child: IconButton(
                          onPressed: () async {
                            print('----BACK');
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: AppColors.secondaryBlackColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 5.sp,
                      vertical: 15.sp,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [],
                                ),
                                SizedBox(
                                  height: Get.height * 0.05,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            text:
                                                'Ordered on ${formattedDateTime.toString()}',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.sp,
                                            color:
                                                AppColors.secondaryBlackColor),
                                        CustomText(
                                            text: 'Order ID ${orderDocID} ',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.sp,
                                            color: SColorPicker.fontGrey),
                                        CustomText(
                                            text: proName.toString(),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16.sp,
                                            color: AppColors.primaryColor),
                                        CustomText(
                                            text: 'Product ID:- $productId',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.sp,
                                            color: SColorPicker.fontGrey),
                                      ],
                                    ),
                                    CustomText(
                                        text: payment.toString(),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                        color: AppColors.secondaryBlackColor),
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.03,
                                ),
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 10.sp),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          CustomText(
                                            text: 'Size',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp,
                                            color: SColorPicker.fontGrey,
                                            alignment: Alignment.centerLeft,
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.008,
                                          ),
                                          CustomText(
                                            text: size.toString(),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp,
                                            color:
                                                AppColors.secondaryBlackColor,
                                            alignment: Alignment.centerLeft,
                                          ),
                                        ],
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            CustomText(
                                              text: 'Length',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.sp,
                                              color: SColorPicker.fontGrey,
                                              alignment: Alignment.topLeft,
                                            ),
                                            SizedBox(
                                              height: Get.height * 0.008,
                                            ),
                                            CustomText(
                                              text: length.toString(),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.sp,
                                              color:
                                                  AppColors.secondaryBlackColor,
                                              alignment: Alignment.centerLeft,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          CustomText(
                                            text: 'Weight',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp,
                                            color: SColorPicker.fontGrey,
                                            alignment: Alignment.centerLeft,
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.008,
                                          ),
                                          CustomText(
                                            text: weigth.toString(),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp,
                                            color:
                                                AppColors.secondaryBlackColor,
                                            alignment: Alignment.centerLeft,
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          CustomText(
                                            text: 'Oil',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp,
                                            color: SColorPicker.fontGrey,
                                            alignment: Alignment.centerLeft,
                                          ),
                                          CustomText(
                                            text: oil.toString(),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp,
                                            color:
                                                AppColors.secondaryBlackColor,
                                            alignment: Alignment.centerLeft,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          GestureDetector(
                            onTap: () {
                              print('SellerReviewPage--');
                              //ScustomerReviewScreen
                              Get.to(SSellerReviewScreen());
                            },
                            child: Card(
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(10.sp),
                                    child: CustomText(
                                      text: 'Customer Details',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.sp,
                                      color: AppColors.secondaryBlackColor,
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        CustomText(
                                            text: buyerName.toString(),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.sp,
                                            color:
                                                AppColors.secondaryBlackColor),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5.sp),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                width: Get.width * 0.005.sp,
                                              ),
                                              CustomText(
                                                text: '5.0',
                                                color: AppColors
                                                    .secondaryBlackColor,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.005.sp,
                                              ),
                                              SmoothStarRating(
                                                  allowHalfRating: false,
                                                  onRatingChanged: (v) {
                                                    rating = v;
                                                  },
                                                  starCount: 5,
                                                  rating: rating,
                                                  size: 18.0.sp,
                                                  filledIconData: Icons.star,
                                                  halfFilledIconData:
                                                      Icons.blur_on,
                                                  color:
                                                      AppColors.starRatingColor,
                                                  borderColor:
                                                      AppColors.starRatingColor,
                                                  spacing: 0.0),
                                              CustomText(
                                                  text: '(14 reviews)',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.sp,
                                                  color: AppColors
                                                      .secondaryBlackColor),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.sp),
                                    child: CustomText(
                                        text:
                                            ' A-00, Abc Soc, Abc \n Road, Area,City, State, \n country -pincode',
                                        alignment: Alignment.topLeft,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: AppColors.secondaryBlackColor),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.03,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          InkWell(
                            onTap: () {
                              print('Get Contatc Detail');
                            },
                            child: FittedBox(
                              child: Container(
                                padding: EdgeInsets.all(8.sp),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 0.10,
                                      color: SColorPicker.fontGrey),
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 1,
                                        color: AppColors.offWhiteColor)
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: 27,
                                      height: 27,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2,
                                            color: AppColors.starRatingColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: SvgPicture.asset(
                                        BImagePick.ReviewsIcon,
                                        color: SColorPicker.purple,
                                      ),
                                      // SvgPicture.asset('assets/images/folder_icon.svg'),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    CustomText(
                                        text: 'Get contact details',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color: AppColors.secondaryBlackColor),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Get.height * 0.03,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 70.sp),
                            child: SCommonButton().sCommonPurpleButton(
                              name: 'Continue',
                              onTap: () {
                                Get.to(() => SEarningsScreen());
                                print('edit product seller side');
                                // Get.toNamed(SRoutes.SSubmitProfileScreen);
                              },
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
        ),
      ),
    );
  }

  Widget buildMiddleWidget(String name, String price, String desc) {
    return Container(
      child: Column(
        children: [
          CustomText(
            text: 'Test',
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
            color: AppColors.primaryColor,
            alignment: Alignment.topLeft,
          ),
          // SizedBox(height: Get.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                  text: "Desc",
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: AppColors.secondaryBlackColor),
              Container(
                height: Get.height / 12.sp,
                decoration: BoxDecoration(
                    color: AppColors.commonWhiteTextColor,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      new BoxShadow(
                          blurRadius: 1, color: AppColors.hintTextColor),
                    ]),
                child: TextButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("Products")
                          .where(PreferenceManager.getTime(),
                              isEqualTo: "createdOn")
                          .get()
                          .then((value) {
                        value.docs.forEach((element) {
                          FirebaseFirestore.instance
                              .collection("Products")
                              .doc(element.id)
                              .delete()
                              .then((value) {
                            print("Success!");
                          });
                        });
                      });
                    },
                    child:
                        SvgPicture.asset('assets/images/svg/delete_icon.svg')),
              ),
            ],
          ),
          CustomText(
            text: "Price",
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            color: AppColors.secondaryBlackColor,
            alignment: Alignment.topLeft,
          ),
          const Divider(
            height: 10,
          ),
        ],
      ),
    );
  }
}
