import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/app_constant/b_image.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:url_launcher/url_launcher.dart';
import '../app_constant/app_colors.dart';
import 'b_carousel_slider.dart';
import 'b_selected_product_build_top_widget.dart';
import 'custom_widget/custom_text.dart';
import 'b_seller_review_widget.dart';

class SelectedProductWidget extends StatefulWidget {

  final String? name, image, desc, price, category, id;


  SelectedProductWidget(
      {Key? key, this.name, this.price, this.image, this.category, this.desc,this.id})
      : super(key: key);


  @override
  State<SelectedProductWidget> createState() => _SelectedProductWidgetState();
}

class _SelectedProductWidgetState extends State<SelectedProductWidget> {
  var rating = 3.0;
  final List<String> imageList = [
    'https://firebasestorage.googleapis.com/v0/b/pipesonline-b2a41.appspot.com/o/cart_page.png?alt=media&token=6a4d6e9a-51b3-449a-a2bd-eb54dcec0803',
    'https://firebasestorage.googleapis.com/v0/b/pipesonline-b2a41.appspot.com/o/cart_page.png?alt=media&token=6a4d6e9a-51b3-449a-a2bd-eb54dcec0803',
  ];

  String? firstname;
  String? email;
  String? address;
  String? phoneno;
  String? Img;

  CollectionReference ProfileCollection = bFirebaseStore.collection('BProfile');

  Future<void> getData() async {
    print('demo....${PreferenceManager.getUId()}.');
    final user =
        await ProfileCollection.doc('${FirebaseAuth.instance.currentUser!.uid}')
            // await ProfileCollection.doc('${PreferenceManager.getUId()}')
            .get();
    var m = user.data();
    print('--SelectedProductWidget--------m-- $m');
    // Map<String, dynamic>? getUserData = user.data() as Map<String, dynamic>?;
    Map<String, dynamic>? getUserData = m as Map<String, dynamic>?;
    setState(() {
      firstname = getUserData!['firstname'];
      email = getUserData['email'];
      address = getUserData['address'];
      phoneno = getUserData['phoneno'];
      Img = getUserData['imageProfile'];
    });

    print('========SelectedProductWidget===========${getUserData}');
  }

  // SelectedProductController controller = Get.put(SelectedProductController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
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
                      CustomCarouselSliderWidget(
                        image: widget.image.toString(),
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
            Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: CustomSelectedProductBuildTopWidget(
                name: widget.name.toString(),
                price: widget.price.toString(),
                desc: widget.desc.toString(),
                image: widget.image.toString(),
                category: widget.category,
                id: widget.id,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.sp),
              child: InkWell(
                onTap: () {
                  Get.to(() => SellerReviewWidget());
                },
                child: SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.network(
                          Img == null
                              ? 'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'
                              : Img!,
                          fit: BoxFit.cover,
                        width: 30.sp,
                        height: 30.sp,
                        // color: AppColors.primaryColor,
                          ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomRichTextSpanWidget(
                            color1: AppColors.secondaryBlackColor,
                            name1: firstname.toString(),
                            name2: '  (6 listings)',
                            color2: AppColors.hintTextColor,
                            fontsize: 12.sp,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.sp),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                CustomText(
                                  text: '5.0',
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
                                CustomText(
                                    text: '(14 reviews)',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp,
                                    color: AppColors.secondaryBlackColor),
                              ],
                            ),
                          ),
                        ],
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
            Card(
              child: Container(
                height: Get.height/15,
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
              child: TextButton(
                onPressed: () {

                },
                child: CustomRichTextSpanWidget(
                  name1: 'Status :',
                  color1: AppColors.secondaryBlackColor,
                  name2: ' For Sale',
                  color2: AppColors.secondaryBlackColor,
                  fontsize: 12.sp,
                ),
              ),
            ),
            Container(
              height: Get.height/10,

              child: Card(

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
                                child: SvgPicture.asset(
                                    'assets/images/icon/what_up_icon.svg')),
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
                              icon: Icon(Icons.share_outlined)),
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

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: 'https://flutter.dev/',
        chooserTitle: 'Example Chooser Title');
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