import 'package:cloud_firestore/cloud_firestore.dart';import 'package:flutter/material.dart';import 'package:flutter_svg/svg.dart';import 'package:get/get.dart';import 'package:intl/intl.dart';import 'package:pipes_online/buyer/app_constant/auth.dart';import 'package:pipes_online/buyer/screens/b_add_reviews_page.dart';import 'package:pipes_online/seller/common/s_color_picker.dart';import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';import 'package:sizer/sizer.dart';import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';import '../app_constant/app_colors.dart';import 'b_review_widgets.dart';import 'bottom_bar_screen_page/widget/b_home_bottom_bar_route.dart';import 'custom_widget/custom_text.dart';import '../../seller/common/s_text_style.dart';class BReviewInfoScreen extends StatefulWidget {  const BReviewInfoScreen({Key? key}) : super(key: key);  @override  State<BReviewInfoScreen> createState() => _BReviewInfoScreenState();}class _BReviewInfoScreenState extends State<BReviewInfoScreen> {  // String? Img;  // String? firstname;  String? formattedDateTime;  String? sellerID;  String? Img;  String? firstname, phone;  // bool? isStatus;  Future<void> getData() async {    // print('SELLERID---${PreferenceManager.getUId()}');    CollectionReference ProfileCollection =        bFirebaseStore.collection('Products');    print('demo...${PreferenceManager.getUId()}');    final user = await ProfileCollection.doc().get();    print('user..${user}');    Map<String, dynamic>? getUserData = user.data() as Map<String, dynamic>?;    firstname = getUserData?['user_name'];    sellerID = getUserData?['sellerID'];    print('==user data======${getUserData}');    setState(() {      Img = getUserData?['imageProfile'];    });  }  void initState() {    // TODO: implement initState    super.initState();    getData();    print('PreferenceManager---> ${PreferenceManager.getUId()}');  }  var rating = 3.0;  @override  Widget build(BuildContext context) {    // var collection =    //     FirebaseFirestore.instance.collection('SProfile').snapshots();    // print('--collection seller ${collection}');    return Scaffold(      appBar: AppBar(        title: Text(          'REVIEWS',          style: STextStyle.bold700White14,        ),        backgroundColor: AppColors.primaryColor,        toolbarHeight: Get.height * 0.1,        leading: IconButton(            onPressed: () {              if (bottomBarIndexController.bottomIndex.value == 1) {                bottomBarIndexController.setSelectedScreen(value: 'HomeScreen');                bottomBarIndexController.bottomIndex.value = 0;              } else {                Get.back();              }            },            icon: Icon(Icons.arrow_back_rounded)),        shape: const RoundedRectangleBorder(          borderRadius: BorderRadius.vertical(            bottom: Radius.circular(25),          ),        ),      ),      body: SingleChildScrollView(        child: Column(          children: [            Card(              child: Column(                children: [                  SizedBox(                    height: Get.height * 0.02,                  ),                  Container(                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),                    child: CustomText(                      text: 'Summary',                      fontWeight: FontWeight.w600,                      fontSize: 20,                      color: AppColors.secondaryBlackColor,                      alignment: Alignment.topLeft,                    ),                  ),                  SizedBox(                    height: Get.height * 0.02,                  ),                  Container(                    padding: EdgeInsets.only(bottom: Get.height * 0.1),                    child: Row(                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,                      children: [                        SizedBox(                          height: Get.height * 0.1,                        ),                        Container(                          child: Column(                            mainAxisAlignment: MainAxisAlignment.spaceAround,                            children: [                              CustomText(                                text: '5.0',                                color: AppColors.secondaryBlackColor,                                fontSize: 16.sp,                                fontWeight: FontWeight.w600,                              ),                              SizedBox(                                height: Get.height * 0.02,                              ),                              SmoothStarRating(                                  allowHalfRating: false,                                  onRatingChanged: (v) {                                    setState(() {                                      rating = v;                                    });                                  },                                  starCount: 5,                                  rating: rating,                                  size: 20.0.sp,                                  filledIconData: Icons.star,                                  halfFilledIconData: Icons.blur_on,                                  color: AppColors.starRatingColor,                                  borderColor: AppColors.starRatingColor,                                  spacing: 0.0),                              SizedBox(                                height: Get.height * 0.02,                              ),                              CustomText(                                  text: '(14 reviews)',                                  fontWeight: FontWeight.w600,                                  fontSize: 12.sp,                                  color: AppColors.hintTextColor),                            ],                          ),                        ),                        Column(                          children: [                            CustomRatingView('5', AppColors.primaryColor, '5'),                            CustomRatingView(                                '4', AppColors.starRatingLightColor, '0'),                            CustomRatingView(                                '3', AppColors.starRatingLightColor, '0'),                            CustomRatingView(                                '2', AppColors.starRatingLightColor, '0'),                            CustomRatingView(                                '1', AppColors.starRatingLightColor, '0'),                          ],                        ),                      ],                    ),                  ),                ],              ),            ),            FutureBuilder<QuerySnapshot>(              future: /* FirebaseFirestore.instance.collection('Products').get()*/                  FirebaseFirestore.instance                      .collection('SReviews')                      .orderBy('time', descending: false)                      // .doc('fYNGgppbMiQTBMSAxpF74FFd0283')                      // .collection('ReviewID')                      .get(),              builder: (BuildContext context, snapShot) {                if (!snapShot.hasData) {                  return Center(                    child: CircularProgressIndicator(),                  );                }                if (snapShot.hasData) {                  return Column(                    children: [                      Padding(                        padding: EdgeInsets.symmetric(                            horizontal: 10.sp, vertical: 10.sp),                        child: Row(                          mainAxisAlignment: MainAxisAlignment.spaceBetween,                          children: [                            CustomText(                                text: '${snapShot.data?.docs.length} reviews',                                fontWeight: FontWeight.w600,                                fontSize: 12.sp,                                color: AppColors.secondaryBlackColor),                            GestureDetector(                              onTap: () {                                Get.to(() => AddReviewsPage());                              },                              child: CustomText(                                  text: 'Review Now',                                  fontWeight: FontWeight.w600,                                  fontSize: 12.sp,                                  color: AppColors.primaryColor),                            ),                          ],                        ),                      ),                      Divider(                        thickness: 1,                        color: SColorPicker.lightGrey,                      ),                      ListView.builder(                        shrinkWrap: true,                        physics: BouncingScrollPhysics(),                        itemCount: snapShot.data?.docs.length,                        itemBuilder: (context, index) {                          print('length---${snapShot.data?.docs.length}');                          print('data---${snapShot.data}');                          formattedDateTime = DateFormat.yMMMd()                              // .add_jm()                              .format(DateTime.parse(                                  snapShot.data?.docs[index]['time']));                          print('--formattedDateTime-${formattedDateTime}');                          return Container(                            margin: EdgeInsets.symmetric(horizontal: 15),                            child: Row(                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,                              children: [                                snapShot.data!.docs[index]['imageProfile'] !=                                        null                                    ? ClipRRect(                                        borderRadius: BorderRadius.circular(50),                                        child: Image.network(                                          snapShot.data!.docs[index]                                              ['imageProfile'],                                          width: 35.sp,                                          height: 35.sp,                                          fit: BoxFit.cover,                                        ))                                    : ClipRRect(                                        borderRadius: BorderRadius.circular(50),                                        child: SvgPicture.asset(                                          'assets/images/svg/pro_icon.svg',                                          width: 35.sp,                                          height: 35.sp,                                          fit: BoxFit.cover,                                        ),                                      ),                                Expanded(                                  child: Column(                                    children: [                                      Container(                                        padding: EdgeInsets.symmetric(                                            horizontal: 20),                                        child: CustomText(                                          text: snapShot.data!.docs[index]                                                  ['user_name'] ??                                              'John',                                          fontWeight: FontWeight.w600,                                          fontSize: 12.sp,                                          color: AppColors.secondaryBlackColor,                                          alignment: Alignment.topLeft,                                          textAlign: TextAlign.start,                                        ),                                      ),                                      SizedBox(                                        height: Get.height * 0.01,                                      ),                                      Container(                                        padding: EdgeInsets.symmetric(                                            horizontal: 20),                                        child: Row(                                          mainAxisAlignment:                                              MainAxisAlignment.start,                                          children: [                                            CustomText(                                                text: 'Seller',                                                fontWeight: FontWeight.w400,                                                fontSize: 10.sp,                                                color: AppColors                                                    .secondaryBlackColor),                                            SizedBox(                                              width: Get.width * 0.03,                                            ),                                            Row(                                              mainAxisAlignment:                                                  MainAxisAlignment                                                      .spaceBetween,                                              children: [                                                Container(                                                  width: 6,                                                  height: 6,                                                  decoration: BoxDecoration(                                                    borderRadius:                                                        BorderRadius.circular(                                                            50),                                                    color: AppColors                                                        .secondaryBlackColor,                                                  ),                                                ),                                                SizedBox(                                                  width: Get.width * 0.03,                                                ),                                                FittedBox(                                                    child: CustomText(                                                        textOverflow:                                                            TextOverflow.fade,                                                        max: 1,                                                        text: snapShot.data!                                                                    .docs[index]                                                                ['category'] ??                                                            'Category',                                                        fontWeight:                                                            FontWeight.w400,                                                        fontSize: 12.sp,                                                        color: AppColors                                                            .secondaryBlackColor)),                                              ],                                            ),                                          ],                                        ),                                      ),                                      SizedBox(                                        height: Get.height * 0.01,                                      ),                                      Container(                                        margin: EdgeInsets.symmetric(                                            horizontal: 15),                                        width: Get.width * 0.7,                                        child: SmoothStarRating(                                            allowHalfRating: false,                                            onRatingChanged: (v) {                                              setState(() {                                                rating = v;                                              });                                            },                                            starCount: 5,                                            rating: snapShot.data!.docs[index]                                                    ['rating'] ??                                                '3',                                            size: 20.0,                                            filledIconData: Icons.star,                                            halfFilledIconData: Icons.blur_on,                                            color: AppColors.starRatingColor,                                            borderColor:                                                AppColors.starRatingColor,                                            spacing: 0.0),                                      ),                                      SizedBox(                                        height: Get.height * 0.01,                                      ),                                      Container(                                        padding: EdgeInsets.symmetric(                                            horizontal: 20),                                        child: CustomText(                                            alignment: Alignment.topLeft,                                            text: snapShot.data!.docs[index]                                                    ['dsc'] ??                                                'Description',                                            fontWeight: FontWeight.normal,                                            fontSize: 10.sp,                                            max: 1,                                            textOverflow: TextOverflow.ellipsis,                                            color: AppColors.hintTextColor),                                      ),                                      SizedBox(                                        height: Get.height * 0.04,                                      )                                    ],                                  ),                                ),                                CustomText(                                    text: formattedDateTime ?? '3d',                                    fontWeight: FontWeight.w600,                                    fontSize: 10.sp,                                    color: AppColors.secondaryBlackColor),                              ],                            ),                          );                        },                      ),                    ],                  );                }                return Container();              },            ),            Divider(              thickness: 1,              color: SColorPicker.lightGrey,            ),          ],        ),      ),    );  }}