import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/register_repo.dart';
import 'package:pipes_online/buyer/screens/b_home_screen_widget.dart';
import 'package:pipes_online/buyer/screens/b_seller_review_widget.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../../seller/common/s_text_style.dart';
import '../app_constant/app_colors.dart';
import 'bottom_bar_screen_page/widget/b_home_bottom_bar_route.dart';
import 'custom_widget/custom_button.dart';
import 'custom_widget/custom_text.dart';

class AddReviewsPage extends StatefulWidget {
  const AddReviewsPage({Key? key, this.category}) : super(key: key);
  final String? category;
  @override
  State<AddReviewsPage> createState() => _AddReviewsPageState();
}

class _AddReviewsPageState extends State<AddReviewsPage> {
  double rating = 3.0;
  TextEditingController desc = TextEditingController();
  CollectionReference ProfileCollection = bFirebaseStore.collection('BProfile');
  String? Img;
  String? firstname;

  Future<void> getData() async {
    print('demo.....');
    final user =
        await ProfileCollection.doc('${FirebaseAuth.instance.currentUser!.uid}')
            .get();
    Map<String, dynamic>? getUserData = user.data() as Map<String, dynamic>?;
    firstname = getUserData!['user_name'];
    print('=========firstname===============${getUserData}');
    setState(() {
      Img = getUserData['imageProfile'];
    });
    print('============================${user.get('imageProfile')}');
  }

  Future<void> addData() async {
    print(
        'buyer addData Preference Id==============>${PreferenceManager.getUId().toString()}');
    print(
        'buyer addData-getTime==============>${PreferenceManager.getTime().toString()}');

    BRegisterRepo.emailRegister()
        .then((value) async {
          print('==>category${widget.category}');
          CollectionReference ProfileCollection =
              bFirebaseStore.collection('Reviews');
          ProfileCollection.doc('${PreferenceManager.getUId()}').set({
            'userID': PreferenceManager.getUId(),
            'category': widget.category,
            'user_name': firstname,
            'imageProfile': Img,
            'dsc': desc.text,
            'rating': rating,
            'userType': PreferenceManager.getUserType(),
            'time': DateTime.now().day,
          });
        })
        .catchError((e) => print('Error ====buyer=====>>> $e'))
        .then((value) {
          print('review uploaded succefully');
          bottomBarIndexController.setSelectedScreen(value: 'HomeScreen');
          bottomBarIndexController.bottomIndex.value = 0;
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('==>category===${widget.category}');

    getData();
    addData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.commonWhiteTextColor,
        body: SafeArea(
          child: Container(
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Card(
                      margin: EdgeInsets.only(top: 0, bottom: 15),
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
                                          height: Get.height / 9,
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
                                    top: 44.sp,
                                    child: Container(
                                      height: 50.sp,
                                      width: 50.sp,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(50.0),
                                        child: Image.network(
                                          Img == null
                                              ? 'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'
                                              : Img!,
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
                                    top: 10.sp,
                                    left: 0,
                                    child: BackButton(
                                      color: AppColors.commonWhiteTextColor,
                                    ),
                                  ),
                                  Positioned(
                                    top: 20.sp,
                                    child: Text(
                                      'ADD REVIEW',
                                      style: STextStyle.bold700White14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 40.sp,
                                    ),
                                    child: CustomText(
                                        text: firstname.toString(),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18.sp,
                                        color: AppColors.secondaryBlackColor),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.sp, horizontal: 0),
                                    child: CustomText(
                                        text: 'How was your experience?',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                        color: AppColors.secondaryBlackColor),
                                  ),
                                  SmoothStarRating(
                                      allowHalfRating: false,
                                      onRatingChanged: (v) {
                                        setState(
                                          () {
                                            rating = v;
                                            print('rating====>${rating}');
                                          },
                                        );
                                      },
                                      starCount: 5,
                                      rating: rating,
                                      size: 20.sp,
                                      filledIconData: Icons.star,
                                      halfFilledIconData: Icons.blur_on,
                                      color: AppColors.hintTextColor,
                                      borderColor: AppColors.hintTextColor,
                                      spacing: 0.0),
                                  SizedBox(
                                    height: Get.height * 0.02.sp,
                                  ),
                                  Divider(),
                                  SizedBox(
                                    height: Get.height * 0.02.sp,
                                  ),
                                  CustomText(
                                      text: 'Write your feedback (optional)',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                      color: AppColors.secondaryBlackColor),
                                  SizedBox(height: Get.height * 0.01.sp),
                                  Card(
                                    elevation: 1,
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0.sp),
                                      child: Container(
                                        child: TextFormField(
                                          controller: desc,
                                          decoration: InputDecoration(
                                            fillColor: SColorPicker.fontGrey,
                                            hintText: 'Enter your review',
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                          maxLines: 5,
                                          keyboardType: TextInputType.multiline,
                                          // minLines: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: Get.height * 0.02.sp),
                                  Custombutton(
                                    name: 'Submit'.toUpperCase(),
                                    function: () {
                                      addData();
                                      Get.to(SellerReviewWidget());
                                    },
                                    // Get.to(() => HomePage()),
                                    height: Get.height * 0.06.sp,
                                    width: Get.width / 1.2.sp,
                                  ),
                                ],
                              ),
                            ),
                          )
                          // SizedBox(height: Get.height * 0.02,),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
