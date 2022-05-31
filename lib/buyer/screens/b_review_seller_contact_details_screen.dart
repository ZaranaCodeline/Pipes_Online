import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/screens/b_listing_review_tab_bar.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/seller/view/s_screens/s_color_picker.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:url_launcher/url_launcher.dart';

class BReviewSellerContactDetailsScreen extends StatefulWidget {
  final String? sellerPhone, sellerName, sellerImage, proID, category;
  const BReviewSellerContactDetailsScreen(
      {Key? key,
      this.sellerPhone,
      this.sellerName,
      this.sellerImage,
      this.proID,
      this.category})
      : super(key: key);

  @override
  State<BReviewSellerContactDetailsScreen> createState() =>
      _BReviewSellerContactDetailsScreenState();
}

class _BReviewSellerContactDetailsScreenState
    extends State<BReviewSellerContactDetailsScreen> {
  var rating = 3.0;

  CollectionReference ProfileCollection = bFirebaseStore.collection('BProfile');
  // String? Img;
  // String? firstname, phone;

  // Future<void> getData() async {
  //   print('BProfile============');
  //   final user =
  //       await ProfileCollection.doc('${PreferenceManager.getUId()}').get();
  //   Map<String, dynamic>? getUserData = user.data() as Map<String, dynamic>?;
  //   firstname = getUserData?['user_name'];
  //   phone = getUserData?['phoneno'];
  //   print('=========SellerReviewWidget===============${getUserData}');
  //   setState(() {
  //     Img = getUserData?['imageProfile'];
  //   });
  //   print('============================${user.get('imageProfile')}');
  //   print('phoneno============================${user.get('phoneno')}');
  // }

  @override
  void initState() {
    // TODO: implement initState
    // getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(top: 0, bottom: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        child: SingleChildScrollView(
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            overflow: Overflow.visible,
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
                                          )),
                                    ),
                                  )
                                ],
                              ),
                              Positioned(
                                top: 0.0,
                                child: Container(
                                  width: 200,
                                  height: 52,
                                ),
                              ),
                              Positioned(
                                top: 15.sp,
                                child: Container(
                                  height: 60.sp,
                                  width: 60.sp,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: widget.sellerImage != null
                                        ? Image.network(
                                            'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png',
                                            fit: BoxFit.cover,
                                            height: 30.sp,
                                            width: 30.sp)
                                        : Image.network(
                                            widget.sellerImage.toString(),
                                            fit: BoxFit.cover,
                                            height: 30.sp,
                                            width: 30.sp,
                                          ),
                                  )
                                  /*Image.asset(
                                          'assets/images/png/cat_1.png',
                                          fit: BoxFit.fill,
                                        )*/
                                  ,
                                ),
                              ),
                              Positioned(
                                  top: 3.sp,
                                  left: 0,
                                  child: BackButton(
                                    color: AppColors.commonWhiteTextColor,
                                  )),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: Get.height * 0.049,
                      ),
                      CustomText(
                          text: widget.sellerName == null
                              ? 'John'
                              : widget.sellerName.toString(),
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: AppColors.secondaryBlackColor),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: '5.0',
                              color: AppColors.secondaryBlackColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                            ),
                            SizedBox(
                              width: Get.width * 0.02,
                            ),
                            SmoothStarRating(
                                allowHalfRating: false,
                                onRatingChanged: (v) {
                                  setState(() {
                                    rating = v;
                                  });
                                },
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
                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("Reviews")
                                  .doc(PreferenceManager.getUId().toString())
                                  .collection('ReviewID')
                                  .snapshots(),
                              builder: (context, snapShot) {
                                if (snapShot.hasData) {
                                  print(
                                      'length=====${snapShot.data!.docs.length}');
                                  return CustomText(
                                      text:
                                          '${snapShot.data!.docs.length} Reviews ',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
                                      color: AppColors.secondaryBlackColor);
                                }
                                return CustomText(
                                    text: '(Reviews)',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: AppColors.secondaryBlackColor);
                              },
                            )
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
                            print('Get Contatc Detail');

                            // _showPopupMenu();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  width: 27,
                                  height: 27,
                                  decoration: BoxDecoration(
                                    /*border: Border.all(
                                        width: 1,
                                        color: AppColors.hintTextColor),*/
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Container(
                                      width: 30.sp,
                                      height: 30.sp,
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
                                      child: Icon(
                                        Icons.message_outlined,
                                        size: 15.sp,
                                        color: AppColors.secondaryBlackColor,
                                      ),
                                    ),
                                  )
                                  // SvgPicture.asset('assets/images/folder_icon.svg'),
                                  ),
                              const SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                onPressed: () {
                                  print('---PHONE---${widget.sellerPhone}');
                                  launch('tel:${widget.sellerPhone}');
                                },
                                icon: Container(
                                  width: 20.sp,
                                  height: 20.sp,
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
                                  child: Icon(
                                    Icons.call,
                                    size: 15.sp,
                                    color: AppColors.secondaryBlackColor,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CustomText(
                                  text: widget.sellerPhone != null
                                      ? widget.sellerPhone.toString()
                                      : '1234567891',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.sp,
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
                id: widget.proID,
                category: widget.category,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
