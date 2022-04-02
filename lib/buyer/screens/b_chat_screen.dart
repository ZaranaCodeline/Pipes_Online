import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/authentificaion/database.dart';
import 'package:pipes_online/buyer/authentificaion/b_functions.dart';
import 'package:pipes_online/convert_date_formate_chat.dart';
import 'package:pipes_online/reference_chat.dart';
import 'package:pipes_online/seller/common/s_text_style.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';
import '../../../buyer/app_constant/app_colors.dart';
import '../../../buyer/buyer_common/b_image.dart';
import '../custom_widget/widgets/custom_text.dart';
import 'bottom_bar_screen_page/widget/cart_bottom_bar_route.dart';
import 'b_chat_message_page.dart';

class BChatScreen extends StatefulWidget {
  const BChatScreen({Key? key}) : super(key: key);

  @override
  State<BChatScreen> createState() => _BChatScreenState();
}

class _BChatScreenState extends State<BChatScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  // TextEditingController? searchUserNameEditController;

  // bool isSearching = false;
  // Stream? usersStream;
  // late final String receiverId;

  // onSearchBtnClick() async {
  //   isSearching = true;
  //   setState(() {});
  //   usersStream = await DatabaseMethods()
  //       .getUserByUserName(searchUserNameEditController!.text);
  // }

  // Widget SearchUserList() {
  //
  //   return StreamBuilder(
  //       stream: FirebaseFirestore.instance
  //           .collection('Chat').doc('/xyz')
  //           .collection('Data')
  //           .orderBy('date', descending: false)
  //           .snapshots(),
  //       builder: (context, snapShot) {
  //         return snapShot.hasData
  //             ? ListView.builder(
  //                 itemCount:  snapShot.data.docs.length,
  //                 itemBuilder: (context, index) {
  //                   DocumentSnapshot ds = snapShot.data.docs[index];
  //                   return Image.network(ds["imgUrl"]);
  //                 })
  //             : Center(child: CircularProgressIndicator());
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'CHAT',
            style: STextStyle.bold700White14,
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              if (bottomBarIndexController.bottomIndex.value == 2) {
                bottomBarIndexController.setSelectedScreen(value: 'HomeScreen');
                bottomBarIndexController.bottomIndex.value = 0;
              } else {
                Get.back();
              }
            },
            icon: Icon(
              Icons.arrow_back,
              color: AppColors.commonWhiteTextColor,
            ),
          ),
          backgroundColor: AppColors.primaryColor,
          toolbarHeight: Get.height * 0.1,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25),
            ),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                child: CustomText(
                  text: 'Messages',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryColor,
                  textAlign: TextAlign.start,
                  alignment: Alignment.topLeft,
                ),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              Divider(color: AppColors.primaryColor, thickness: 1.sp),
              InkWell(
                onTap: () {
                  BAuthMethods().getCurrentUser();

                  Get.to(ChatMessagePage(
                    userImg:
                    // _auth.currentUser!.photoURL,
                    'https://firebasestorage.googleapis.com/v0/b/pipesonline-b2a41.appspot.com/o/cat_1.png?alt=media&token=a8b761df-c503-466b-baf3-d4ef73d5650d',
                    // receiverId: _auth.currentUser!.uid,
                    receiverId:'100247364098702824893' ,
                    // userName: _auth.currentUser!.displayName,
                    userName:'milan',
                  ));
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: Get.width * 0.05),
                            child: Container(
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    child: Image.asset(
                                      '${BImagePick.proIcon}',
                                      width: 50.sp,
                                      height: 50.sp,
                                      fit: BoxFit.fill,
                                    ),
                                    backgroundColor: AppColors.offWhiteColor,
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: Container(
                                      width: 10.sp,
                                      height: 10.sp,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                    text: 'John',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15.sp,
                                    color: AppColors.secondaryBlackColor),
                                CustomText(
                                  text: 'Hii',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.sp,
                                  color: AppColors.secondaryBlackColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: Get.width * 0.4,
                        padding: EdgeInsets.only(right: Get.width * 0.05),
                        child: Column(
                          children: [
                            CustomText(
                                text: '1 Minute ago',
                                fontWeight: FontWeight.w600,
                                fontSize: 13.sp,
                                color: AppColors.secondaryBlackColor),
                            CircleAvatar(
                              radius: 8.sp,
                              child: Center(
                                child: CustomText(
                                  text: '1',
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.commonWhiteTextColor,
                                  fontSize: 10.sp,
                                ),
                              ),
                              backgroundColor: AppColors.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(
                color: AppColors.hintTextColor,
                thickness: 1.sp,
                indent: Get.width * 0.05,
                endIndent: Get.width * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
