import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/seller/bottombar/widget/category_bottom_bar_route.dart';
import 'package:pipes_online/seller/view/s_screens/s_review_screen.dart';
import 'package:pipes_online/seller/view_model/s_edit_product_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../../../buyer/app_constant/app_colors.dart';
import '../../../buyer/screens/b_carousel_slider.dart';
import '../../../buyer/screens/custom_widget/custom_text.dart';
import '../../common/s_common_button.dart';

class SSelectedProductScreen extends StatefulWidget {
  SSelectedProductScreen({

    Key? key,
  }) : super(key: key);


  @override
  State<SSelectedProductScreen> createState() => _SSelectedProductScreenState();
}

class _SSelectedProductScreenState extends State<SSelectedProductScreen> {
  var rating = 3.0;
  EditProductContoller editProductContoller = Get.find();
  String? uploadImage;
/*  File? _image;*/
  String? Img;
  String? cat;
  String? prdName;
  String? dsc;
  String? price;

  CollectionReference userCollection =
  FirebaseFirestore.instance.collection('Products');
  Future<void> getData(String id) async {
    print('demo.selected product seller....');
    final user = await userCollection
        .doc('${FirebaseAuth.instance.currentUser!.uid}')
        .collection('data')
        .doc(id)
        .get();
    Map<String, dynamic>? getUserData = user.data();
    setState(() {
      prdName = getUserData?['prdName'] ?? "";
      dsc = getUserData?['dsc'] ?? "";
      Img = getUserData?['imageProfile'] ?? "";
      price = getUserData?['price']?? "" ;
      cat = getUserData?['category'] ?? "";

    });


    print('prdName $prdName');
    print('dsc $dsc');
    print('price $price');
    print('imageProfile  $Img');

    // getUserData!.forEach((key, value) {
    //   print('=========================key value=================${key}--${value}');
    // });

  }

  @override
  void initState() {
    // TODO: implement initState
    print('ID:-${editProductContoller.id}');
    getData(editProductContoller.id);
    super.initState();
  }

  // SelectedProductController controller = Get.put(SelectedProductController());
  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        body: GetBuilder<EditProductContoller>(
          builder: (controller) {
            return Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CustomCarouselSliderWidget(
                          image:Img.toString(),
                        ),
                        // CarouselWirhDotsWidgets(imgList: imageList,),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5.sp),
                            child: IconButton(
                              onPressed: () {
                                homeController
                                    .selectedScreen('SCatelogeHomeScreen');
                                homeController.bottomIndex.value = 0;
                                // Get.back();
                              },
                              icon: Icon(Icons.arrow_back),
                            )
                          // BackButton(
                          //   color: AppColors.secondaryBlackColor,
                          // ),
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
                            Padding(
                              padding: EdgeInsets.all(8.0.sp),
                              child: Container(
                                child: Column(
                                  children: [
                                    CustomText(
                                      text: prdName.toString(),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.sp,
                                      color: AppColors.primaryColor,
                                      alignment: Alignment.topLeft,
                                    ),
                                    // SizedBox(height: Get.height * 0.01),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                            text:dsc.toString(), /*widget.price.toString()*/
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.sp,
                                            color: AppColors.secondaryBlackColor),
                                        Container(
                                          height: Get.height / 12.sp,
                                          decoration: BoxDecoration(
                                              color: AppColors.commonWhiteTextColor,
                                              borderRadius:
                                              BorderRadius.circular(5),
                                              boxShadow: [
                                                new BoxShadow(
                                                    blurRadius: 1,
                                                    color: AppColors.hintTextColor),
                                              ]),
                                          child: TextButton(
                                              onPressed: () {},
                                              child: SvgPicture.asset(
                                                  'assets/images/svg/delete_icon.svg')),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10.sp),
                                child: InkWell(
                                  onTap: () {
                                    Get.to(() => SReviewScreen());
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5.sp),
                                              child: Row(
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
                                                  SmoothStarRating(
                                                      allowHalfRating: false,
                                                      onRatingChanged: (v) {
                                                        setState(() {
                                                          rating = v;
                                                        });
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
                                      SizedBox(
                                        width: Get.width * 0.005.sp,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: AppColors.secondaryBlackColor,
                                        size: 18,
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.005.sp,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Card(
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(10.sp),
                                child: CustomText(
                                  text:dsc.toString(),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12.sp,
                                  color: AppColors.secondaryBlackColor,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.05,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 70.sp),
                              child: SCommonButton().sCommonPurpleButton(
                                name: 'Edit Product',
                                onTap: () {
                                  homeController.selectedScreen('SeditProductScreen');
                                  homeController.bottomIndex.value = 0;
                                  editProductContoller.selectedID(editProductContoller.id);
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
            );
          },
        ),
      ),
    );
  }

  Widget buildMiddleWidget(String name, String price, String desc) {
    return Container(
      child: Column(
        children: [
          CustomText(
            text: name,
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
                  text: price,
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
                    onPressed: () {},
                    child:
                        SvgPicture.asset('assets/images/svg/delete_icon.svg')),
              ),
            ],
          ),
          CustomText(
            text: desc,
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
