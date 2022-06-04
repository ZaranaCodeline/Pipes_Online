import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/convert_date_formate_chat.dart';
import 'package:pipes_online/seller/common/s_text_style.dart';
import 'package:pipes_online/seller/view/s_screens/s_color_picker.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';
import '../app_constant/app_colors.dart';
import '../app_constant/b_image.dart';
import 'b_chat_message_page.dart';
import 'bottom_bar_screen_page/widget/b_cart_bottom_bar_route.dart';
import 'custom_widget/custom_text.dart';

class BChatScreen extends StatefulWidget {
  const BChatScreen({Key? key}) : super(key: key);

  @override
  State<BChatScreen> createState() => _BChatScreenState();
}

class _BChatScreenState extends State<BChatScreen> {
  bool isselected = false;
  List<String> items = [];
  List<String> onSearchItem = [];
  TextEditingController searchController = TextEditingController();

  CollectionReference ProfileCollection = bFirebaseStore.collection('SProfile');
  String? Img;
  String? firstname, phone;
  bool? isStatus;
  Future<void> getData() async {
    print('SELLERID---${PreferenceManager.getUId()}');
    print('demo.....');
    final user = await ProfileCollection.doc(PreferenceManager.getUId()).get();
    Map<String, dynamic>? getUserData = user.data() as Map<String, dynamic>?;
    firstname = getUserData?['user_name'];
    phone = getUserData?['phoneno'];
    print('=========SProfile ChatScreen Data=============${getUserData}');
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
    print('Buyer PreferenceManager.getUId()====${PreferenceManager.getUId()}');
  }

  String chatId(String id1, String id2) {
    print('--------id1--id1--------$id1');

    print('id1 length => ${id1.length} id2 length=> ${id2.length}');
    return id1 + '-' + id2;
  }

  @override
  Widget build(BuildContext context) {
    var collection =
        FirebaseFirestore.instance.collection('SProfile').snapshots();
    print('--collection seller ${collection}');
    return WillPopScope(
      onWillPop: () async {
        bottomBarIndexController.setSelectedScreen(value: 'HomeScreen');
        bottomBarIndexController.bottomIndex.value = 0;
        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'CHAT'.toUpperCase(),
              style: STextStyle.bold700White14,
            ),
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                bottomBarIndexController.setSelectedScreen(value: 'HomeScreen');
                bottomBarIndexController.bottomIndex.value = 0;
              },
              icon: Icon(
                Icons.arrow_back,
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
          body: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('SProfile')
                .where('user_name',
                    isGreaterThanOrEqualTo: searchController.text)
                .get(),
            builder: (BuildContext context, snapShot) {
              if (snapShot.hasData) {
                print('prdName-${snapShot.data?.docs.length}');
                snapShot.data?.docs.forEach((proLength) {
                  items.add(proLength['user_name']);
                });
                print('products-name-${items}');
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                      Container(
                        height: Get.height / 15,
                        width: Get.width / 1,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor.withOpacity(0.2)),
                        child: CupertinoTextField(
                          padding: EdgeInsets.symmetric(horizontal: 10.sp),
                          onChanged: (proLength) {
                            setState(() {
                              print('kkkk');
                            });
                          },
                          controller: searchController,
                          keyboardType: TextInputType.text,
                          placeholder: 'Search products here...',
                          placeholderStyle: TextStyle(
                            color: SColorPicker.fontGrey,
                            fontSize: 12.sp,
                            fontFamily: 'Ubuntu-Regular',
                          ),
                          onTap: () {
                            print('custom search');
                            // Get.to(SearchScreen());
                          },
                          suffix: IconButton(
                            onPressed: () {
                              searchController.clear();
                            },
                            icon: searchController.text.isNotEmpty
                                ? Icon(
                                    Icons.clear,
                                    color: SColorPicker.fontGrey,
                                  )
                                : Icon(
                                    Icons.search,
                                    color: SColorPicker.fontGrey,
                                  ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0.0),
                            color: Color(0xffF0F1F5),
                          ),
                        ),
                      ),
                      Divider(),
                      searchController.text.isEmpty
                          ? StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('SProfile')
                                  .where('user_name',
                                      isGreaterThanOrEqualTo:
                                          searchController.text)
                                  /*.where('prdName',
                                      isLessThan: searchController.text + 'z')*/
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(),
                                  );
                                }
                                return Container(
                                  height: Get.height * 0.7,
                                  child: ListView.builder(
                                    itemCount: snapshot.data?.docs.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          print('===BUYER===');
                                          print(
                                              'SENDER ID ${PreferenceManager.getUId()}');
                                          print(
                                              'RECIEVER ID ${snapshot.data.docs[index]['sellerID']}');
                                          Get.to(
                                            ChatMessagePage(
                                              userImg: snapshot.data.docs[index]
                                                  ['imageProfile'],
                                              receiverId: snapshot
                                                      .data.docs[index][
                                                  'sellerID'] /*'100247364098702824893'*/,
                                              userName: snapshot.data
                                                  .docs[index]['user_name'],
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
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                Get.width *
                                                                    0.05),
                                                    child: Container(
                                                      child: Stack(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50.sp),
                                                            child: snapshot.data
                                                                            ?.docs[index]
                                                                        [
                                                                        'imageProfile'] ==
                                                                    null
                                                                ? Image.asset(
                                                                    BImagePick
                                                                        .PersonIcon,
                                                                    width: 50,
                                                                    height: 50,
                                                                  )
                                                                : Image.network(
                                                                    (snapshot
                                                                            .data
                                                                            ?.docs[index]['imageProfile'])
                                                                        .toString(),
                                                                    width:
                                                                        35.sp,
                                                                    height:
                                                                        35.sp,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                          ),
                                                          Positioned(
                                                            right: 0,
                                                            child: Container(
                                                              width: 10.sp,
                                                              height: 10.sp,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                                color: isStatus ==
                                                                        true
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .transparent,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        CustomText(
                                                            text: (snapshot.data
                                                                            ?.docs[
                                                                        index][
                                                                    'user_name'])
                                                                .toString(),
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 13.sp,
                                                            alignment:
                                                                Alignment
                                                                    .topLeft,
                                                            textOverflow:
                                                                TextOverflow
                                                                    .clip,
                                                            max: 1,
                                                            color: AppColors
                                                                .secondaryBlackColor),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                width: Get.width * 0.4,
                                                padding: EdgeInsets.only(
                                                    right: Get.width * 0.05),
                                                child: Column(
                                                  children: [
                                                    _time(
                                                        snapshot
                                                            .data
                                                            .docs[index]
                                                                ['sellerID']
                                                            .toString(),
                                                        index)
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            )
                          : StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('SProfile')
                                  .snapshots(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: SizedBox(),
                                  );
                                }
                                return Container(
                                  height: Get.height * 0.7,
                                  child: ListView.builder(
                                    itemCount: snapshot.data?.docs.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          print('===BUYER===');
                                          print(
                                              'SENDER ID ${PreferenceManager.getUId()}');
                                          print(
                                              'RECIEVER ID ${snapshot.data.docs[index]['sellerID']}');
                                          Get.to(
                                            ChatMessagePage(
                                              userImg: snapshot.data.docs[index]
                                                  ['imageProfile'],
                                              receiverId: snapshot
                                                      .data.docs[index][
                                                  'sellerID'] /*'100247364098702824893'*/,
                                              userName: snapshot.data
                                                  .docs[index]['user_name'],
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
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                Get.width *
                                                                    0.05),
                                                    child: Container(
                                                      child: Stack(
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50.sp),
                                                            child: snapshot.data
                                                                            ?.docs[index]
                                                                        [
                                                                        'imageProfile'] ==
                                                                    null
                                                                ? Image.asset(
                                                                    BImagePick
                                                                        .PersonIcon,
                                                                    width: 50,
                                                                    height: 50,
                                                                  )
                                                                : Image.network(
                                                                    (snapshot
                                                                            .data
                                                                            ?.docs[index]['imageProfile'])
                                                                        .toString(),
                                                                    width:
                                                                        35.sp,
                                                                    height:
                                                                        35.sp,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                          ),
                                                          Positioned(
                                                            right: 0,
                                                            child: Container(
                                                              width: 10.sp,
                                                              height: 10.sp,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            50),
                                                                color: isStatus ==
                                                                        true
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .transparent,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        CustomText(
                                                            text: (snapshot.data
                                                                            ?.docs[
                                                                        index][
                                                                    'user_name'])
                                                                .toString(),
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 13.sp,
                                                            alignment:
                                                                Alignment
                                                                    .topLeft,
                                                            textOverflow:
                                                                TextOverflow
                                                                    .clip,
                                                            max: 1,
                                                            color: AppColors
                                                                .secondaryBlackColor),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                width: Get.width * 0.4,
                                                padding: EdgeInsets.only(
                                                    right: Get.width * 0.05),
                                                child: Column(
                                                  children: [
                                                    _time(
                                                        snapshot
                                                            .data
                                                            .docs[index]
                                                                ['sellerID']
                                                            .toString(),
                                                        index)
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                    ],
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
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
    String senderId = PreferenceManager.getUId();
    String receiverId = id.toString();
    return FirebaseFirestore.instance
        .collection('Chat')
        .doc(chatId(senderId, receiverId))
        .collection('Data')
        .where('seen', isEqualTo: false)
        .snapshots();
  }

  Stream<QuerySnapshot> getLastMsgData(String id) {
    String senderId = PreferenceManager.getUId();
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
    String senderId = PreferenceManager.getUId();
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
