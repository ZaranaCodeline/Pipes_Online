import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/screens/b_chat_message_page.dart';
import 'package:pipes_online/seller/common/s_text_style.dart';
import 'package:pipes_online/seller/view/s_screens/s_chat_message_screen.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';

import '../../../buyer/app_constant/app_colors.dart';
import '../../../buyer/app_constant/b_image.dart';
import '../../../buyer/screens/custom_widget/custom_text.dart';
import '../../../convert_date_formate_chat.dart';
import '../../bottombar/widget/category_bottom_bar_route.dart';

class SChatScreen extends StatefulWidget {
  const SChatScreen({Key? key}) : super(key: key);

  @override
  State<SChatScreen> createState() => _SChatScreenState();
}

class _SChatScreenState extends State<SChatScreen> {
  CollectionReference ProfileCollection = bFirebaseStore.collection('BProfile');
  String? Img;
  String? firstname, phone;
  bool? isStatus;

  Future<void> getData() async {
    print('buyer chat demo.....');
    final user =
        await ProfileCollection.doc('EVnjjmDYXgVp6KispydumRaS81l2').get();
    Map<String, dynamic>? getUserData = user.data() as Map<String, dynamic>?;
    firstname = getUserData?['user_name'];
    phone = getUserData?['phoneno'];
    print('=========BBProfile ChatScreen Data=============${getUserData}');
    setState(() {
      Img = getUserData?['imageProfile'];
    });
    print('============================${user.get('imageProfile')}');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getData();
    print('Seller PreferenceManager.getUId()====${PreferenceManager.getUId()}');
  }

  String chatId(String id1, String id2) {
    print('--------id1--id1--------$id1');

    print('id1 length => ${id1.length} id2 length=> ${id2.length}');
    return id2 + '-' + id1;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Chat'.toString(),
            style: STextStyle.bold700White14,
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              // Get.back();
              homeController.bottomIndex.value = 0;
              homeController.selectedScreen('SCatelogeHomeScreen');
            },
            icon: Icon(Icons.arrow_back),
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
          child: SingleChildScrollView(
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
                Divider(color: AppColors.primaryColor, thickness: 0.5.sp),
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('BProfile')
                      .snapshots(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Container(
                      height: Get.height * 0.7,
                      child: ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(
                              onTap: () {
                                print('=============SELLER=================');
                                print(
                                    'SENDER ID ${PreferenceManager.getUId()}');
                                print(
                                    'RECIEVER ID ${snapshot.data.docs[index]['buyerID']}');

                                FirebaseAuth _auth = FirebaseAuth.instance;
                                Get.to(
                                  () => ChatMessagePage(
                                    userImg: snapshot.data.docs[index]
                                        ['imageProfile'],
                                    receiverId: snapshot.data.docs[index]
                                        ['buyerID'] /*_auth.currentUser!.uid*/,
                                    userName: snapshot.data.docs[index]
                                        ['user_name'],
                                  ),
                                );
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: Get.height * 0.02),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Get.width * 0.05),
                                          child: Container(
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.sp),
                                                  // radius: 50,
                                                  child: snapshot.data
                                                                  ?.docs[index][
                                                              'imageProfile'] ==
                                                          null
                                                      ? Image.asset(
                                                          BImagePick.proIcon)
                                                      : Image.network(
                                                          snapshot.data
                                                                  ?.docs[index]
                                                              ['imageProfile'],
                                                          width: 35.sp,
                                                          height: 35.sp,
                                                          fit: BoxFit.cover,
                                                        ),
                                                ),
                                                Positioned(
                                                  right: 0,
                                                  child: Container(
                                                    width: 10.sp,
                                                    height: 10.sp,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: isStatus == true
                                                          ? Colors.green
                                                          : Colors.transparent,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: CustomText(
                                              text: (snapshot.data?.docs[index]
                                                      ['user_name'])
                                                  .toString(),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 13.sp,
                                              color: AppColors
                                                  .secondaryBlackColor),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          width: Get.width * 0.4,
                                          padding: EdgeInsets.only(
                                              right: Get.width * 0.05),
                                          child: _time(
                                              snapshot
                                                  .data!.docs[index]['buyerID']
                                                  .toString(),
                                              index),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _time(String id, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        StreamBuilder<QuerySnapshot>(
          stream: getLastMsgData(id),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return SizedBox();
            }
            String? lastMsg;
            List<DocumentSnapshot> docs = snapshot.data!.docs;
            if (docs.length == 1) {
              lastMsg = docs[0].get('msg');
            }
            print('last Msg :$lastMsg');
            return lastMsg == null
                ? SizedBox()
                : CustomText(
                    text: (lastMsg),
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: AppColors.secondaryBlackColor,
                    textOverflow: TextOverflow.ellipsis,
                    max: 1,
                  );
          },
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: getPendingSeenData(id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    int length = 0;
                    length = snapshot.data!.docs.fold(
                        0,
                        (previousValue, element) =>
                            previousValue +
                            (element.get('senderId') == id ? 1 : 0));
                    return length == 0
                        ? SizedBox()
                        : Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.primaryColor),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Center(
                                child: Text(
                                  '$length',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ));
                  } else {
                    return SizedBox();
                  }
                }),
            SizedBox(
              width: Get.width * 0.04,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: getLastMsgData(id),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return SizedBox();
                }
                DateTime? lastMsgTime;
                List<DocumentSnapshot> docs = snapshot.data!.docs;
                if (docs.length == 1) {
                  lastMsgTime = docs[0].get('date').toDate();
                }
                print('last Msg :$lastMsgTime');
                return lastMsgTime == null
                    ? SizedBox()
                    : MsgDate(
                        date: docs[0].get('date').toDate(),
                      );
              },
            ),
          ],
        ),
      ],
    );
  }

  Stream<QuerySnapshot> getPendingSeenData(String id) {
    String senderId = PreferenceManager.getUId().toString();
    String receiverId = id.toString();
    return FirebaseFirestore.instance
        .collection('Chat')
        .doc(chatId(senderId, receiverId))
        .collection('Data')
        .where('seen', isEqualTo: false)
        .snapshots();
  }

  Stream<QuerySnapshot> getLastMsgData(String id) {
    String senderId = PreferenceManager.getUId().toString();
    String receiverId = id.toString();
    return FirebaseFirestore.instance
        .collection('Chat')
        .doc(chatId(senderId, receiverId))
        .collection('Data')
        .orderBy('date')
        .limitToLast(1)
        .snapshots();
  }

  Stream<QuerySnapshot> getLastMsg(String id) {
    String senderId = PreferenceManager.getUId().toString();
    String receiverId = id.toString();
    return FirebaseFirestore.instance
        .collection('Chat')
        .doc(chatId(senderId, receiverId))
        .collection('Data')
        .orderBy('date')
        .limitToLast(1)
        .snapshots();
  }
}
