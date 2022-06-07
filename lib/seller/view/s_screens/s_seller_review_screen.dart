import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/seller/view/s_screens/s_customer_buy_review_screen.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../../../buyer/app_constant/app_colors.dart';
import '../../../buyer/app_constant/b_image.dart';
import '../../../buyer/screens/b_review_widgets.dart';
import '../../common/s_color_picker.dart';
import 's_add_review_screen.dart';

class SSellerReviewScreen extends StatefulWidget {
  final String? category, buyerID;
  const SSellerReviewScreen({
    Key? key,
    this.category,
    this.buyerID,
  }) : super(key: key);

  @override
  State<SSellerReviewScreen> createState() => _SSellerReviewScreenState();
}

class _SSellerReviewScreenState extends State<SSellerReviewScreen> {
  bool isShowContact = false;
  String? buyer_ID, buyerName, buyerAddress, buyerPhone, buyerImage;
  TextEditingController desc = TextEditingController();
  // FirebaseFirestore.instance.collection('Orders').snapshots()

  var rating = 3.0;
  String? formattedDateTime;
  Future<void> getData() async {
    DocumentReference profileCollection =
        bFirebaseStore.collection('Orders').doc();

    print('profileCollection.....${profileCollection}');
    final user = await profileCollection.get();
    var m = user.data();
    print('--SelectedProductWidget--------m-- $m');
    dynamic getUserData = m;

    // final user = await profileCollection.doc().get();
    // Map<String, dynamic>? getUserData = user.data() as Map<String, dynamic>?;
    setState(() {
      print('======ID=====${PreferenceManager.getUId()}');
      print('buyer_deatils_seller_review_screen=====${getUserData}');
      buyer_ID = getUserData?['orderID'];
      buyerAddress = getUserData?['buyerAddress'];
      buyerPhone = getUserData?['buyerPhone'];
      buyerName = getUserData?['buyerName'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    print('===widget_buyerID=====${widget.buyerID}--buyer_ID--${buyer_ID}');
    print('======ID=====${PreferenceManager.getUId()}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _showPopupMenu() {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      final offset = renderBox.localToGlobal(Offset.zero);
      //*calculate the start point in this case, below the button
      final left = offset.dx;
      final top = offset.dy + renderBox.size.height;
      //*The right does not indicates the width
      final right = left + renderBox.size.width;
      final bottom = offset.dx;
      showMenu<String>(
        context: context,
        color: AppColors.primaryColor,
        position: RelativeRect.fromLTRB(25, 0, 25, 25),
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
                    text: 'Contact to Buyer',
                    color: AppColors.commonWhiteTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
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
                // Get.to(ScustomerBuyReviewScreen());
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
                    fontSize: 18,
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
              height: Get.height * 0.008,
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
                    fontSize: 18,
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              ///BUYER DETAILS
              Container(
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
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: const BorderRadius.vertical(
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
                                height: 52,
                              ),
                            ),
                            Positioned(
                              top: 40.0,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  height: 80.0,
                                  width: 80.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Color(0xffE8E8E8), width: 1.0),
                                  ),
                                  child: /*snapshot.data
                                                                      ?.docs[index]
                                                                  ['buyerImg'] !=
                                                              null
                                                          ?*/
                                      ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                      /*   snapShot.data!.docs[index]
                            ['buyerImg'] ??*/
                                      'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png',
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                  /*: Image.network('https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png',
                                                              width: 30,
                                                              height: 30,
                                                              fit: BoxFit.cover, )*/
                                  ,
                                ),
                              ),
                            ),
                            Positioned(
                                top: 15,
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

                    /// BUYER Name
                    CustomText(
                        text: /* output?.docs[index]
                                                    ['buyerName'] ??*/
                            'John',
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
                            width: Get.width * 0.01,
                          ),
                          CustomText(
                              text: '(14 reviews)',
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: AppColors.secondaryBlackColor),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),

                    ///BUYER INFO
                    Container(
                      height: Get.height / 13,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: SColorPicker.lightGrey,
                          width: 0.8,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 4),
                      child: isShowContact == true
                          ? Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.chat_bubble_outline,
                                        size: 12.sp,
                                      )),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.call,
                                        size: 12.sp,
                                      )),
                                  CustomText(
                                      text: '+91 1122334455',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
                                      color: AppColors.secondaryBlackColor)
                                ],
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                print('Get Contatc Detail');
                                _showPopupMenu();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      width: 25.sp,
                                      height: 25.sp,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: AppColors.starRatingColor),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: SvgPicture.asset(
                                          BImagePick.ReviewsIcon,
                                          color: SColorPicker.purple)
                                      // SvgPicture.asset('assets/images/folder_icon.svg'),
                                      ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  CustomText(
                                      text: 'Get contact details',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                      color: AppColors.secondaryBlackColor),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              Container(
                color: AppColors.commonWhiteTextColor,
                child: Center(
                  child: Column(
                    children: [
                      Card(
                        margin: EdgeInsets.only(top: 0, bottom: 10),
                        child: Column(
                          children: [
                            // SizedBox(height: Get.height * 0.02,),
                            Card(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.02,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.1),
                                    child: CustomText(
                                      text: 'Summary',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                      color: AppColors.secondaryBlackColor,
                                      alignment: Alignment.topLeft,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.02,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        bottom: Get.height * 0.1),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        SizedBox(
                                          height: Get.height * 0.1,
                                        ),
                                        Container(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              CustomText(
                                                text: '5.0',
                                                color: AppColors
                                                    .secondaryBlackColor,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.02,
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
                                                  size: 20.0.sp,
                                                  filledIconData: Icons.star,
                                                  halfFilledIconData:
                                                      Icons.blur_on,
                                                  color:
                                                      AppColors.starRatingColor,
                                                  borderColor:
                                                      AppColors.starRatingColor,
                                                  spacing: 0.0),
                                              SizedBox(
                                                height: Get.height * 0.01,
                                              ),
                                              CustomText(
                                                  text: '(14 reviews)',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.sp,
                                                  color:
                                                      AppColors.hintTextColor),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            CustomRatingView('5',
                                                AppColors.primaryColor, '5'),
                                            CustomRatingView(
                                                '4',
                                                AppColors.starRatingLightColor,
                                                '0'),
                                            CustomRatingView(
                                                '3',
                                                AppColors.starRatingLightColor,
                                                '0'),
                                            CustomRatingView(
                                                '2',
                                                AppColors.starRatingLightColor,
                                                '0'),
                                            CustomRatingView(
                                                '1',
                                                AppColors.starRatingLightColor,
                                                '0'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('SReviews')
                                  .doc(PreferenceManager.getUId())
                                  .collection('ReviewID')
                                  .snapshots(),
                              builder: (BuildContext context, snapShot) {
                                if (!snapShot.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (snapShot.hasData) {
                                  print(
                                      'length111-----${snapShot.data?.docs.length}');
                                  return Container(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: Get.height * 0.01,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.sp,
                                              vertical: 10.sp),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomText(
                                                  text:
                                                      '${snapShot.data?.docs.length} reviews',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 12.sp,
                                                  color: AppColors
                                                      .secondaryBlackColor),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.to(SAddReviewScreen(
                                                    buyerID: widget.buyerID,
                                                    category: widget.category,
                                                  ));
                                                },
                                                child: CustomText(
                                                    text: 'Review Now',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12.sp,
                                                    color:
                                                        AppColors.primaryColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          thickness: 1,
                                          color: SColorPicker.lightGrey,
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: snapShot.data?.docs.length,
                                          physics: BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            formattedDateTime =
                                                DateFormat.yMMMd().format(
                                                    DateTime.parse(snapShot.data
                                                        ?.docs[index]['time']));
                                            print(
                                                '--formattedDateTime-${formattedDateTime}');
                                            return Card(
                                              elevation: 0.1,
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 15),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 0.2,
                                                    ),
                                                    snapShot.data?.docs[index][
                                                                'imageProfile'] !=
                                                            null
                                                        ? ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            child:
                                                                Image.network(
                                                              snapShot.data
                                                                          ?.docs[
                                                                      index][
                                                                  'imageProfile'],
                                                              width: 25.sp,
                                                              height: 25.sp,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          )
                                                        : SvgPicture.asset(
                                                            'assets/images/svg/pro_icon.svg',
                                                            width: 25.sp,
                                                            height: 25.sp,
                                                            color: AppColors
                                                                .primaryColor,
                                                          ),
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            child: CustomText(
                                                              text: snapShot
                                                                          .data!
                                                                          .docs[index]
                                                                      [
                                                                      'user_name'] ??
                                                                  'John',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 12.sp,
                                                              color: AppColors
                                                                  .secondaryBlackColor,
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: Get.height *
                                                                0.01,
                                                          ),
                                                          Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                CustomText(
                                                                    text: snapShot.data!.docs[index]
                                                                            [
                                                                            'userType'] ??
                                                                        'Seller',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        12.sp,
                                                                    color: AppColors
                                                                        .secondaryBlackColor),
                                                                SizedBox(
                                                                  width:
                                                                      Get.width *
                                                                          0.03,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Container(
                                                                      width: 6,
                                                                      height: 6,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(50),
                                                                        color: AppColors
                                                                            .secondaryBlackColor,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: Get
                                                                              .width *
                                                                          0.03,
                                                                    ),
                                                                    CustomText(
                                                                        text: snapShot.data?.docs[index]['category'] ??
                                                                            'category',
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w400,
                                                                        fontSize: 12
                                                                            .sp,
                                                                        color: AppColors
                                                                            .secondaryBlackColor),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: Get.height *
                                                                0.01,
                                                          ),
                                                          Container(
                                                            margin: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        15),
                                                            width:
                                                                Get.width * 0.7,
                                                            child: SmoothStarRating(
                                                                allowHalfRating:
                                                                    false,
                                                                starCount: 5,
                                                                rating: snapShot
                                                                            .data!.docs[index]
                                                                        [
                                                                        'rating'] ??
                                                                    '3',
                                                                size: 20.0,
                                                                filledIconData:
                                                                    Icons.star,
                                                                halfFilledIconData:
                                                                    Icons
                                                                        .blur_on,
                                                                color: AppColors
                                                                    .starRatingColor,
                                                                borderColor:
                                                                    AppColors
                                                                        .starRatingColor,
                                                                spacing: 0.0),
                                                          ),
                                                          SizedBox(
                                                            height: Get.height *
                                                                0.01,
                                                          ),
                                                          Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            child: CustomText(
                                                              text: (snapShot
                                                                          .data!
                                                                          .docs[
                                                                      index]['dsc'])
                                                                  .toString(),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 12.sp,
                                                              color: AppColors
                                                                  .secondaryBlackColor,
                                                              alignment:
                                                                  Alignment
                                                                      .topLeft,
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                          ),
                                                          Divider(),
                                                          // SizedBox(
                                                          //   height: Get.height *
                                                          //       0.01,
                                                          // ),
                                                        ],
                                                      ),
                                                    ),
                                                    CustomText(
                                                        text: formattedDateTime
                                                            .toString(),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 12.sp,
                                                        color: AppColors
                                                            .secondaryBlackColor),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                }
                                return Center(
                                    child: CircularProgressIndicator());
                              },
                            ),
                          ],
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
    );
  }
}
