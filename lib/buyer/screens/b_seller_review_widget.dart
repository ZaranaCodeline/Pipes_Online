import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/app_constant/b_image.dart';
import 'package:pipes_online/buyer/screens/b_review_seller_contact_details_screen.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../seller/view/s_screens/s_color_picker.dart';
import '../app_constant/app_colors.dart';
import 'b_listing_review_tab_bar.dart';
import 'custom_widget/custom_text.dart';

class SellerReviewWidget extends StatefulWidget {
  final String? id,
      category,
      sellerID,
      serllerImg,
      sellerAddress,
      sellerPhone,
      sellerName;
  const SellerReviewWidget({
    Key? key,
    this.id,
    this.category,
    this.sellerID,
    this.serllerImg,
    this.sellerAddress,
    this.sellerName,
    this.sellerPhone,
  }) : super(key: key);

  @override
  State<SellerReviewWidget> createState() => _SellerReviewWidgetState();
}

class _SellerReviewWidgetState extends State<SellerReviewWidget> {
  var rating = 0.0;
  bool isShowContact = false;
  CollectionReference profileCollection = bFirebaseStore.collection('SProfile');
  var reviewID = Get.arguments;

  // String? Img;
  // String? firstname, sellerID;

  // Future<void> getData() async {
  //   print('=======BUYER_SIDE_SELLER_ID========${PreferenceManager.getUId()}');
  //   final user =
  //       await profileCollection.doc('${PreferenceManager.getUId()}').get();
  //   Map<String, dynamic>? getUserData = user.data() as Map<String, dynamic>?;
  //
  //   print('=========SellerReviewWidget===============${getUserData}');
  //   setState(() {
  //     firstname = getUserData?['user_name'];
  //     sellerID = getUserData?['sellerID'];
  //     Img = getUserData?['imageProfile'];
  //   });
  //   print('============================${user.get('imageProfile')}');
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    reviewID = Get.arguments;

    // getData();
    print('=======BUYER_SIDE_SELLER_ID========${PreferenceManager.getUId()}');
    print('==widget.serllerImg---${widget.serllerImg}');
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
      showMenu<String>(
        context: context,
        color: AppColors.primaryColor,
        position: RelativeRect.fromLTRB(25, -2, 25, 25),
        //position where you want to show the menu on screen
        items: [
          PopupMenuItem<String>(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  CustomText(
                    text: 'Contact to seller',
                    color: AppColors.commonWhiteTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                  ),
                ],
              ),
            ),
            value: '1',
          ),
          PopupMenuItem<String>(
            child: Column(
              children: [
                SizedBox(
                  height: Get.height * 0.008,
                ),
                Center(
                  child: CustomText(
                    text: '\$5',
                    color: AppColors.commonWhiteTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 35,
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.008,
                ),
              ],
            ),
            value: '2',
          ),
          PopupMenuItem<String>(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isShowContact = true;
                });
                Get.back();
              },
              child: Container(
                height: Get.height * 0.08,
                width: Get.width * 1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.commonWhiteTextColor,
                  ),
                  child: CustomText(
                    textAlign: TextAlign.center,
                    text: 'Get Contact details',
                    alignment: Alignment.center,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    color: AppColors.secondaryBlackColor,
                  ),
                ),
              ),
            ),
            value: '3',
          ),
          PopupMenuItem<String>(
            child: Center(
                child: SizedBox(
              height: Get.height * 0,
            )),
            value: '4',
          ),
          PopupMenuItem<String>(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: AppColors.commonWhiteTextColor,
                    ),
                  ),
                  CustomText(
                    text:
                        ' By this subscription\n you can call and chat\n with seller at any time.',
                    color: AppColors.commonWhiteTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
              value: '5'),
          PopupMenuItem<String>(
            child: Center(
                child: SizedBox(
              height: Get.height * 0.01,
            )),
            value: '6',
          ),
        ],
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(top: 0, bottom: 5),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              child: SingleChildScrollView(
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  alignment: Alignment.bottomCenter,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            height: 60,
                                            decoration: BoxDecoration(
                                              color: AppColors.primaryColor,
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                bottom: Radius.circular(25),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Positioned(
                                      top: 0.0,
                                      child: Container(
                                        width: 200,
                                        height: 55,
                                      ),
                                    ),
                                    Positioned(
                                      top: 20.sp,
                                      child: Container(
                                        height: 50.sp,
                                        width: 50.sp,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          child: widget.serllerImg != null
                                              ? Image.network(
                                                  widget.serllerImg.toString(),
                                                  fit: BoxFit.cover,
                                                  width: 30.sp,
                                                  height: 30.sp,
                                                  errorBuilder: (BuildContext
                                                          context,
                                                      Object exception,
                                                      StackTrace? stackTrace) {
                                                    return Image.asset(
                                                      BImagePick.proIcon,
                                                      height: Get.height * 0.1,
                                                      width: Get.width * 0.4,
                                                      fit: BoxFit.cover,
                                                    );
                                                  },
                                                )
                                              : Image.asset(
                                                  BImagePick.proIcon,
                                                  height: Get.height * 0.1,
                                                  width: Get.width * 0.4,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 5.sp,
                                      left: 0,
                                      child: IconButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        icon: Icon(
                                          Icons.arrow_back,
                                          color: AppColors.commonWhiteTextColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.049,
                            ),
                            CustomText(
                                text: widget.sellerName != null
                                    ? widget.sellerName.toString()
                                    : 'John',
                                fontWeight: FontWeight.w600,
                                fontSize: 24,
                                color: AppColors.secondaryBlackColor),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            reviewID != null
                                ? CustomText(
                                    text: reviewID.toString(),
                                    color: AppColors.secondaryBlackColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  )
                                : CustomText(
                                    text: '0',
                                    color: AppColors.secondaryBlackColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                            SizedBox(
                              width: Get.width * 0.02,
                            ),
                            reviewID != null
                                ? SmoothStarRating(
                                    allowHalfRating: false,
                                    // onRatingChanged: (v) {
                                    //   setState(() {
                                    //     rating = v;
                                    //   });
                                    // },
                                    starCount: 5,
                                    rating: reviewID.toDouble(),
                                    size: 20.0,
                                    filledIconData: Icons.star,
                                    halfFilledIconData: Icons.blur_on,
                                    color: AppColors.starRatingColor,
                                    borderColor: AppColors.starRatingColor,
                                    spacing: 0.0)
                                : SmoothStarRating(
                                    allowHalfRating: false,
                                    // onRatingChanged: (v) {
                                    //   setState(() {
                                    //     rating = v;
                                    //   });
                                    // },
                                    starCount: 5,
                                    rating: rating,
                                    size: 20.0,
                                    filledIconData: Icons.star,
                                    halfFilledIconData: Icons.blur_on,
                                    color: AppColors.starRatingColor,
                                    borderColor: AppColors.starRatingColor,
                                    spacing: 0.0),
                            SizedBox(
                              width: Get.width * 0.02,
                            ),
                            reviewID != null
                                ? CustomText(
                                    text: '(${reviewID.toString()} reviews)',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: AppColors.secondaryBlackColor)
                                : CustomText(
                                    text: '( reviews)',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: AppColors.secondaryBlackColor),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: SColorPicker.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 0.5,
                                blurRadius: 1),
                          ],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        margin:
                            EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                        child: InkWell(
                          onTap: () {
                            print('Get Contatc Detail...');
                            _showPopupMenu();
                          },
                          child: isShowContact == true
                              ? Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            ///TODO CHAT MESSAGE
                                            Share.share(
                                                'https://pipedeals.page.link/products');
                                          },
                                          icon: Icon(
                                            Icons.chat_bubble_outline,
                                            size: 12.sp,
                                          )),
                                      IconButton(
                                          onPressed: () {
                                            ///TODO CALL
                                            print(
                                                '---PHONE---${widget.sellerPhone}');
                                            launch(
                                                'tel:${widget.sellerPhone ?? '1234567891'}');
                                          },
                                          icon: Icon(
                                            Icons.call,
                                            size: 12.sp,
                                          )),
                                      CustomText(
                                          text: widget.sellerPhone ??
                                              '+91 1122334455',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.sp,
                                          color: AppColors.secondaryBlackColor)
                                    ],
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        width: 27,
                                        height: 27,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2,
                                              color: AppColors.starRatingColor),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Icon(
                                          Icons.folder,
                                          color: AppColors.primaryColor,
                                        )
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
                      // SizedBox(height: Get.height * 0.02,),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: ListingReviewTabBarWidget(
                id: widget.id,
                category: widget.category,
                sellerAddress: widget.sellerAddress,
                sellerImage: widget.sellerName,
                sellerName: widget.serllerImg,
                sellerPhone: widget.sellerPhone,
                sellerID: widget.sellerID,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
