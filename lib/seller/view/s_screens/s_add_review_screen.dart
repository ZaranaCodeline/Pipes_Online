import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/register_repo.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../../buyer/app_constant/app_colors.dart';
import '../../../buyer/screens/custom_widget/custom_button.dart';
import '../../../buyer/screens/custom_widget/custom_text.dart';
import '../../bottombar/widget/category_bottom_bar_route.dart';
import '../../common/s_color_picker.dart';
import '../../common/s_text_style.dart';

class SAddReviewScreen extends StatefulWidget {
  const SAddReviewScreen({Key? key, this.category}) : super(key: key);
  final String? category;
  @override
  State<SAddReviewScreen> createState() => _SAddReviewScreenState();
}

class _SAddReviewScreenState extends State<SAddReviewScreen> {
  var rating = 3.0;

  String? Img;
  String? firstname;
  TextEditingController desc = TextEditingController();

  Future<void> getData() async {
    CollectionReference profileCollection =
        bFirebaseStore.collection('SProfile');
    final user = await profileCollection.doc().get();
    Map<String, dynamic>? getUserData = user.data() as Map<String, dynamic>?;
    setState(() {
      print('======ID=====${PreferenceManager.getUId()}');
      print('=========getUserData===============${getUserData}');
      firstname = getUserData?['user_name'];
      Img = getUserData?['imageProfile'];
    });
  }

  Future<void> addData() async {
    print(
        'seller addData Preference Id==============>${PreferenceManager.getUId().toString()}');
    print(
        'seller addData-getTime==============>${PreferenceManager.getTime().toString()}');

    SRegisterRepo.emailRegister()
        .then((value) async {
          print('==>category${widget.category}');
          CollectionReference ProfileCollection =
              bFirebaseStore.collection('SReviews');
          ProfileCollection.doc('${PreferenceManager.getUId()}')
              .collection('ReviewID')
              .add({
            'reviewID': ProfileCollection.doc().id,
            'userID': PreferenceManager.getUId(),
            'category': widget.category,
            'user_name': firstname,
            'imageProfile': Img,
            'dsc': desc.text,
            'rating': rating,
            'userType': PreferenceManager.getUserType(),
            'time': DateTime.now().toString(),
          });
        })
        .catchError((e) => print('Error ====buyer=====>>> $e'))
        .then((value) {
          print('seller review uploaded succefully');
          homeController.bottomIndex.value = 0;
          homeController.selectedScreen('SCatelogeHomeScreen');
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    addData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.commonWhiteTextColor,
        body: Container(
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
                                        height: Get.height / 7,
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
                                  top: 50.0.sp,
                                  child: Container(
                                    height: Get.height / 9,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Color(0xffE8E8E8),
                                        )),
                                    child: Image.asset(
                                      'assets/images/png/cat_1.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: 20.sp,
                                    left: 0,
                                    child: BackButton(
                                      color: AppColors.commonWhiteTextColor,
                                    )),
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
                          flex: 3,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 45.sp,
                                  ),
                                  child: CustomText(
                                      text: 'Jan Doe',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.sp,
                                      color: AppColors.secondaryBlackColor),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15.sp, horizontal: 0),
                                  child: CustomText(
                                      text: 'How was your experience?',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18.sp,
                                      color: AppColors.secondaryBlackColor),
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
                                    size: 22.sp,
                                    filledIconData: Icons.star,
                                    halfFilledIconData: Icons.blur_on,
                                    color: AppColors.hintTextColor,
                                    borderColor: AppColors.hintTextColor,
                                    spacing: 0.0),
                                SizedBox(
                                  height: Get.height * 0.02.sp,
                                ),
                                Divider(thickness: 1),
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
                                      child: TextField(
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
                                  name: 'Label',
                                  function: () {},
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
    );
  }
}
