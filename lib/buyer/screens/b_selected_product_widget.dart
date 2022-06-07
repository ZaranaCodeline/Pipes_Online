import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/seller/view_model/s_edit_product_controller.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:url_launcher/url_launcher.dart';

import '../app_constant/app_colors.dart';
import 'b_selected_product_build_top_widget.dart';
import 'b_seller_review_widget.dart';
import 'custom_widget/custom_text.dart';

class SelectedProductWidget extends StatefulWidget {
  final String? name, image, desc, price, category, productID, sellerID;

  SelectedProductWidget({
    Key? key,
    this.name,
    this.price,
    this.image,
    this.category,
    this.desc,
    this.sellerID,
    this.productID,
  }) : super(key: key);

  @override
  State<SelectedProductWidget> createState() => _SelectedProductWidgetState();
}

class _SelectedProductWidgetState extends State<SelectedProductWidget> {
  var rating = 3.0;

  String? firstname;
  String? email;
  String? address;
  String? phoneno;
  String? Img;
  String? sellerAddress;
  String? sellerPhone;
  String? sellerName;
  EditProductContoller editProductContoller = Get.find();

  Future<void> getData() async {
    DocumentReference profileCollection =
        bFirebaseStore.collection("SProfile").doc(widget.sellerID);
    print('============profileCollection==========${profileCollection}');

    print('=======SELLER ID___${widget.sellerID}.');
    final user = await profileCollection.get();
    print('zzz-11-${user}');
    var m = user.data();
    print('--SelectedProductWidget--------m-- $m');
    dynamic getUserData = m;

    setState(() {
      email = getUserData?['email'];
      address = getUserData?['address'];
      phoneno = getUserData?['phoneno'];
      Img = getUserData?['imageProfile'];
      sellerAddress = getUserData?['address'];
      sellerPhone = getUserData?['phoneno'];
      sellerName = getUserData?['user_name'];
    });
    print('========SelectedProductWidget===========${getUserData}');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    print('demo.b selected products...${PreferenceManager.getUId()}.');
    print('demo.b seller_id...${widget.sellerID}.');
    print('firstname-------${firstname}.');
    print('Img-------${Img}.');
    print('sellerIMAGE-------${Img.toString()}.');
    print('sellerAddress-------${sellerAddress.toString()}.');
    print('sellerPhone-------${sellerPhone.toString()}.');
    print('sellerName-------${sellerName.toString()}.');
  }

  @override
  Widget build(BuildContext context) {
    print(' category:  category:  category: ${widget.category}');
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 200.sp,
                        child: Image.network(
                          widget.image.toString(),
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.sp),
                        child: BackButton(
                          color: AppColors.commonWhiteTextColor,
                        ),
                      )
                    ],
                  ),
                  _buileSecondWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buileSecondWidget() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 0.sp,
        vertical: 15.sp,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 0.1,
              child: Padding(
                padding: EdgeInsets.all(8.0.sp),
                child: CustomSelectedProductBuildTopWidget(
                  name: widget.name.toString(),
                  price: widget.price.toString(),
                  desc: widget.desc.toString(),
                  image: widget.image.toString(),
                  category: widget.category,
                  productID: widget.productID,
                ),
              ),
            ),
            Card(
              elevation: 0.2,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.sp),
                child: InkWell(
                  onTap: () {
                    print('selectedProduct===========>${widget.category}');
                    print('widget.category===========>${widget.category}');
                    print('widget.sellerID===========>${widget.sellerID}');
                    print('Img.toString()===========>${Img.toString()}');
                    print('address===========>${address}');
                    print('phoneno===========>${phoneno}');
                    // print('selectedProduct===========>${widget.category}');
                    Get.to(
                      () => SellerReviewWidget(
                        id: widget.productID,
                        category: widget.category,
                        sellerID: widget.sellerID,
                        serllerImg: Img,
                        sellerAddress: address,
                        sellerPhone: phoneno,
                        sellerName: sellerName,
                      ),
                    );
                  },
                  child: SingleChildScrollView(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Img != null
                              ? Container(
                                  height: 35.sp,
                                  width: 35.sp,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                      Img.toString(),
                                      width: 30.sp,
                                      height: 30.sp,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )
                              : Image.network(
                                  "https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png",
                                  width: 30.sp,
                                  height: 30.sp,
                                  fit: BoxFit.fill,
                                ),
                        ),
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: Get.height * 0.03,
                                // width: Get.width * 0.2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: sellerName != null
                                          ? sellerName.toString()
                                          : 'John',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15.sp,
                                      color: AppColors.secondaryBlackColor,
                                      textOverflow: TextOverflow.ellipsis,
                                      max: 1,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.1,
                                    ),
                                    StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('Products')
                                          .snapshots(),
                                      builder: (context, snapShot) {
                                        if (snapShot.hasData) {
                                          var proLength = snapShot
                                              .data?.docs.length
                                              .toString();
                                          print('--length--${proLength}');
                                          return CustomText(
                                              text:
                                                  '${proLength.toString()} Listings',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10.sp,
                                              color: AppColors.hintTextColor);
                                        }
                                        return SizedBox();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.sp),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    CustomText(
                                      text: rating.toString(),
                                      color: AppColors.secondaryBlackColor,
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
                                        // rating: rating,
                                        size: 18.0.sp,
                                        rating: rating,
                                        filledIconData: Icons.star,
                                        halfFilledIconData: Icons.blur_on,
                                        color: AppColors.starRatingColor,
                                        borderColor: AppColors.starRatingColor,
                                        spacing: 0.0),
                                    StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection("Reviews")
                                          .doc(PreferenceManager.getUId()
                                              .toString())
                                          .collection('ReviewID')
                                          .snapshots(),
                                      builder: (context, snapShot) {
                                        if (snapShot.hasData) {
                                          print(
                                              'selected_product_length=====${snapShot.data!.docs.length}');
                                          return CustomText(
                                              text:
                                                  '${snapShot.data!.docs.length} Reviews ',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12.sp,
                                              color: AppColors
                                                  .secondaryBlackColor);
                                        }
                                        return CustomText(
                                            text: '(Reviews)',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp,
                                            color:
                                                AppColors.secondaryBlackColor);
                                      },
                                    )
                                    /* CustomText(
                                        text: '(14 reviews)',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12.sp,
                                        color: AppColors.secondaryBlackColor),*/
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
            ),
            Card(
              elevation: 0.2,
              child: Container(
                height: Get.height / 15,
                width: double.infinity,
                padding: EdgeInsets.all(10.sp),
                child: CustomText(
                  text: widget.desc.toString(),
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  color: AppColors.secondaryBlackColor,
                ),
              ),
            ),
            Card(
              elevation: 0.2,
              child: TextButton(
                onPressed: () {},
                child: CustomRichTextSpanWidget(
                  name1: 'Status :',
                  color1: AppColors.secondaryBlackColor,
                  name2: ' For Sale',
                  color2: AppColors.secondaryBlackColor,
                  fontsize: 12.sp,
                ),
              ),
            ),
            Card(
              elevation: 0.2,
              child: Container(
                height: Get.height / 15,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: ' Share This Listing',
                        fontWeight: FontWeight.w400,
                        fontSize: 12.sp,
                        color: AppColors.secondaryBlackColor,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _launchWhatsapp();
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(50.sp),
                                ),
                                child: Image.asset(
                                  'assets/images/icon/what_up_icon.png',
                                  width: 20.sp,
                                  height: 20.sp,
                                )),
                          ),
                          SizedBox(
                            width: 10.sp,
                          ),
                          IconButton(
                              onPressed: () async {
                                print('hii..');
                                Share.share(
                                    'https://pipesonline012.page.link/productPage');
                              },
                              icon: SvgPicture.asset(
                                  'assets/images/icon/share_icon.svg')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _launchWhatsapp() async {
    const url =
        "https://wa.me/?text=Deal of the day, https://pipesonline012.page.link/productPage";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class CustomRichTextSpanWidget extends StatelessWidget {
  CustomRichTextSpanWidget({
    Key? key,
    required this.color1,
    required this.color2,
    required this.fontsize,
    required this.name1,
    required this.name2,
  }) : super(key: key);
  Color color1, color2;
  String name1, name2;
  double fontsize;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(
          children: [
            TextSpan(
              text: name1,
              style: TextStyle(
                fontSize: fontsize,
                color: color1,
                wordSpacing: 1,
              ),
            ),
            TextSpan(
              text: name2,
              style: TextStyle(
                  fontSize: fontsize,
                  fontWeight: FontWeight.w400,
                  color: color2),
            ),
          ],
        ),
      ),
    );
  }
}
