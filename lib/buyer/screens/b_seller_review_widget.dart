import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/screens/b_review_seller_contact_details_screen.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../../seller/view/s_screens/s_color_picker.dart';
import '../app_constant/app_colors.dart';
import 'b_listing_review_tab_bar.dart';
import 'custom_widget/custom_text.dart';

class SellerReviewWidget extends StatefulWidget {
  final String? id, category;
  const SellerReviewWidget({Key? key, this.id, this.category})
      : super(key: key);

  @override
  State<SellerReviewWidget> createState() => _SellerReviewWidgetState();
}

class _SellerReviewWidgetState extends State<SellerReviewWidget> {
  var rating = 3.0;

  CollectionReference ProfileCollection = bFirebaseStore.collection('SProfile');
  String? Img;
  String? firstname;

  Future<void> getData() async {
    print(
        '=======BUYER_SIDE_SELLER_ID========${FirebaseAuth.instance.currentUser!.uid}');
    final user =
        await ProfileCollection.doc('${FirebaseAuth.instance.currentUser!.uid}')
            .get();
    Map<String, dynamic>? getUserData = user.data() as Map<String, dynamic>?;
    firstname = getUserData?['user_name'];
    print('=========SellerReviewWidget===============${getUserData}');
    setState(() {
      Img = getUserData?['imageProfile'];
    });
    print('============================${user.get('imageProfile')}');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    print('=======BUYER_SIDE_SELLER_ID========${PreferenceManager.getUId()}');

    print('=========seller_reviewwidget_category---${widget.category}');
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
                Get.to(BReviewSellerContactDetailsScreen());
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
                                    height: 55,
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
                                height: 55.sp,
                                width: 55.sp,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: Img == null
                                      ? Image.network(
                                          'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png')
                                      : Image.network(
                                          Img.toString(),
                                          fit: BoxFit.cover,
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
                        text: firstname.toString(),
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
                            text: rating.toString(),
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
                          FutureBuilder<DocumentSnapshot>(
                            future: FirebaseFirestore.instance
                                .collection("BReviews")
                                .doc(PreferenceManager.getUId())
                                .collection('ReviewID')
                                .doc()
                                .get(),
                            builder: (context, snapShot) {
                              if (snapShot.hasData) {
                                print(
                                    'PreferenceManager.getUId()====${PreferenceManager.getUId()}');
                                return CustomText(
                                    text: 'Reviews ',
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
                          _showPopupMenu();
                        },
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
              )),
        ],
      ),
    ));
  }
}
