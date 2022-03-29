import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';
import '../app_constant/app_colors.dart';
import '../custom_widget/widgets/custom_widget/custom_text.dart';

class ChatMessagePage extends StatefulWidget {
  final String uid;
  final String name;
  final String image;

  ChatMessagePage({required this.uid, required this.name, required this.image});

  @override
  State<ChatMessagePage> createState() => _ChatMessagePageState();
}

class _ChatMessagePageState extends State<ChatMessagePage> {


  String statusText = "";
  bool isComplete = false;
  String? recordFilePath;
  String? documentName;

  List<Map<String, dynamic>> iconData = [
    {
      'icon': Icons.camera_alt,
      'name': 'Camera',
    },
    {
      'icon': Icons.video_call,
      'name': 'Video',
    },
    {
      'icon': Icons.image,
      'name': 'Gallery',
    },
    {
      'icon': Icons.video_call,
      'name': 'Gallery',
    },
    {
      'icon': Icons.insert_drive_file_outlined,
      'name': 'document',
    },
  ];
  //bNTkJEQTHVMsHA0CmtLndeqpSzp1
  final TextEditingController _msg = TextEditingController();

  // VideoPlayerController? _controllerVideos;
  // VideoPlayerController? videoPlayerController;
  String
  chatId(String id1, String id2) {
    print('--------id1--id1--------$id1');

    print('id1 length => ${id1.length} id2 length=> ${id2.length}');
    if (id1.compareTo(id2) > 0) {
      return id1 + '-' + id2;
    } else {
      return id2 + '-' + id1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 40.sp,
                        width: 40.sp,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            widget.image,
                            fit: BoxFit.cover,
                          ),
                        ),
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
                  SizedBox(width: Get.width * 0.05),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        alignment: Alignment.center,
                        text: '${widget.name}',
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                        color: AppColors.commonWhiteTextColor,
                      ),
                      CustomText(
                        alignment: Alignment.center,
                        text: 'Online',
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: Colors.green,
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                width: 35.sp,
                height: 35.sp,
                // padding: EdgeInsets,
                decoration: BoxDecoration(
                  color: AppColors.commonWhiteTextColor,
                  borderRadius: BorderRadius.circular(8.sp),
                  border:
                      Border.all(color: AppColors.hintTextColor, width: 2.sp),
                ),
                child: TextButton(
                    onPressed: () {
                      _callNumber;
                    },
                    child: Icon(
                      Icons.call,
                      color: AppColors.secondaryBlackColor,
                    )),
              )
            ],
          ),
          backgroundColor: AppColors.primaryColor,
          toolbarHeight: Get.height * 0.1,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(Get.width * 0.05),
          child: Column(
            children: [
              Text('Today'),
              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  reverse: true,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('chat')
                            .doc(chatId(
                                PreferenceManager.getTokenId().toString(),
                                widget.uid))
                            .collection('Data')
                            .orderBy('date', descending: false)
                            .snapshots(),
                        builder: (context, snapShot) {
                          if (snapShot.hasData) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: snapShot.data!.docs.length,
                              itemBuilder: (context, index) {
                                if (snapShot.data!.docs[index]['Type'] ==
                                    'Video') {
                                  print(
                                      'firebasevideo${snapShot.data!.docs[index]['video']}');
                                }
                                // _controllerVideos = VideoPlayerController.network(
                                //     snapShot.data!.docs[index]['video']);
                                // final chewieController = ChewieController(
                                //   videoPlayerController: _controllerVideos!,
                                //   aspectRatio: 3 / 2,
                                //   autoPlay: false,
                                //   autoInitialize: true,
                                //   looping: false,
                                // );
                                // final playerWidget = Chewie(
                                //   controller: chewieController,
                                // );
                                return snapShot.data!.docs[index]['Type'] ==
                                        'Text'
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: snapShot.data!.docs[index]
                                                    ['senderId'] ==
                                                PreferenceManager.getTokenId()
                                                    .toString()
                                            ? Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: Get.width / 5,
                                                      right: 10),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Flexible(
                                                        child: Card(
                                                          margin:
                                                              EdgeInsets.zero,
                                                          color:
                                                              Color(0xFF777794),
                                                          shape:
                                                              const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(15),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          15),
                                                              bottomLeft: Radius
                                                                  .circular(15),
                                                            ),
                                                          ),
                                                          elevation: 1,
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .end,
                                                            children: [
                                                              Flexible(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "${snapShot.data!.docs[index]['msg']}",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: Colors
                                                                          .white,
                                                                      fontFamily:
                                                                          'Ubuntu-Regular',
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              // Padding(
                                                              //   padding:
                                                              //       const EdgeInsets.only(
                                                              //           right: 10, bottom: 5),
                                                              //   child: MsgDate(
                                                              //     date: (snapShot.data!
                                                              //                     .docs[index]
                                                              //                 ['date']
                                                              //             as Timestamp)
                                                              //         .toDate(),
                                                              //   ),
                                                              // )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      /*    PreferenceManager.getCustomerPImg() == null ||
                                              PreferenceManager.getCustomerPImg() ==
                                                  ''
                                          ? imageNotFound()
                                          : ClipOval(
                                              child: commonProfileOctoImage(
                                                image: PreferenceManager
                                                    .getCustomerPImg(),
                                                height: Get.height * 0.05,
                                                width: Get.height * 0.05,
                                              ),
                                            ),*/
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : Align(
                                                alignment: Alignment.centerLeft,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Flexible(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right:
                                                                      Get.width /
                                                                          3),
                                                          child: Card(
                                                            color: AppColors
                                                                .primaryColor.withOpacity(0.5),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          15),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          15),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          15)),
                                                            ),
                                                            elevation: 1,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  Flexible(
                                                                    child: Text(
                                                                      snapShot
                                                                          .data!
                                                                          .docs[index]['msg'],
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        color: Colors
                                                                            .white,
                                                                        fontFamily:
                                                                            'Ubuntu',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  // Padding(
                                                                  //   padding:
                                                                  //       const EdgeInsets.only(
                                                                  //           top: 10),
                                                                  //   child: MsgDate(
                                                                  //     date: (snapShot.data.docs[
                                                                  //                     index]
                                                                  //                 ['date']
                                                                  //             as Timestamp)
                                                                  //         .toDate(),
                                                                  //   ),
                                                                  // )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                      )
                                    : snapShot.data!.docs[index]['Type'] ==
                                            'Image'
                                        ? snapShot.data!.docs[index]
                                                    ['senderId'] ==
                                                PreferenceManager.getTokenId()
                                                    .toString()
                                            ? Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  /* PreferenceManager.getCustomerPImg() == null ||
                                      PreferenceManager.getCustomerPImg() == ''
                                  ? imageNotFound()
                                  : ClipOval(
                                      child: commonProfileOctoImage(
                                        image: PreferenceManager.getCustomerPImg(),
                                        height: Get.height * 0.05,
                                        width: Get.height * 0.05,
                                      ),
                                    ),*/
                                                ],
                                              )
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  /*   widget.userImg == null || widget.userImg == ''
                                  ? imageNotFound()
                                  : ClipOval(
                                      child: commonProfileOctoImage(
                                        image: widget.userImg,
                                        height: Get.height * 0.05,
                                        width: Get.height * 0.05,
                                      ),
                                    ),*/
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10, top: 10),
                                                    child: Column(
                                                      children: (snapShot.data!
                                                                  .docs[index]
                                                              ['image'] as List)
                                                          .map(
                                                            (e) => Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          5),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    // Get.to(ZoomImage(
                                                                    //   img: e,
                                                                    // ));
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                          .toList(),
                                                    ),
                                                  ),
                                                  // Padding(
                                                  //   padding: const EdgeInsets.only(left: 10),
                                                  //   child: MsgDate(
                                                  //     date: (snapShot.data.docs[index]['date']
                                                  //             as Timestamp)
                                                  //         .toDate(),
                                                  //   ),
                                                  // )
                                                ],
                                              )
                                        // : snapShot.data!.docs[index]['Type'] ==
                                        //         'Video'
                                        //     ? snapShot.data!.docs[index]
                                        //                 ['senderId'] ==
                                        //             PreferenceManager.getTokenId()
                                        //         ? Row(
                                        //             mainAxisAlignment:
                                        //                 MainAxisAlignment.end,
                                        //             children: [
                                        //               Container(
                                        //                 height: 250,
                                        //                 width: 250,
                                        //                 padding:
                                        //                     EdgeInsets.symmetric(
                                        //                   horizontal: 20,
                                        //                 ),
                                        //                 child: playerWidget,
                                        //               ),
                                        //             ],
                                        //           )
                                        //         : Row(
                                        //             mainAxisAlignment:
                                        //                 MainAxisAlignment.start,
                                        //             children: [
                                        //               Container(
                                        //                 height: 250,
                                        //                 width: 250,
                                        //                 padding:
                                        //                     EdgeInsets.symmetric(
                                        //                   horizontal: 20,
                                        //                 ),
                                        //                 child: playerWidget,
                                        //               ),
                                        //             ],
                                        //           )
                                        : snapShot.data!.docs[index]['Type'] ==
                                                PreferenceManager.getTokenId()
                                                    .toString()
                                            ? Padding(
                                                padding: EdgeInsets.only(
                                                    right: Get.width / 5),
                                                child: Card(
                                                  color: Colors.grey[200],
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    15),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    15),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    15)),
                                                  ),
                                                  elevation: 1,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Icon(
                                                          Icons.description,
                                                          color: Colors.black,
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            snapShot.data!
                                                                    .docs[index]
                                                                [
                                                                'documentName'],
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: AppColors
                                                                  .primaryColor.withOpacity(0.5),
                                                              fontFamily:
                                                                  'Ubuntu-Regular',
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        // Padding(
                                                        //   padding:
                                                        //       const EdgeInsets.only(
                                                        //           top: 10),
                                                        //   child: MsgDate(
                                                        //     date: (snapShot.data.docs[
                                                        //                     index]
                                                        //                 ['date']
                                                        //             as Timestamp)
                                                        //         .toDate(),
                                                        //   ),
                                                        // )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Padding(
                                                padding: EdgeInsets.only(
                                                    left: Get.width / 5),
                                                child: Align(
                                                  child: Card(
                                                    color: Color(0xFF222744),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(15),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          15),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      15)),
                                                    ),
                                                    elevation: 1,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Icon(Icons
                                                              .description),
                                                          Flexible(
                                                            child: Text(
                                                              snapShot.data!
                                                                          .docs[
                                                                      index][
                                                                  'documentName'],
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    'Ubuntu-Regular',
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          // Padding(
                                                          //   padding:
                                                          //       const EdgeInsets.only(
                                                          //           top: 10),
                                                          //   child: MsgDate(
                                                          //     date: (snapShot.data.docs[
                                                          //                     index]
                                                          //                 ['date']
                                                          //             as Timestamp)
                                                          //         .toDate(),
                                                          //   ),
                                                          // )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                              },
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 80,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: TextField(
                  controller: _msg,
                  decoration: InputDecoration(
                    fillColor: AppColors.offWhiteColor,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 20),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                        width: 1,
                        color: AppColors.offLightPurpalColor,
                        style: BorderStyle.solid,
                      ),
                    ),
                    hintText: 'Message...',
                    hintStyle: TextStyle(color: AppColors.hintTextColor),
                    prefixIcon: IconButton(
                        onPressed: () async {
                          _pickFile;
                        },
                        icon: Icon(
                          Icons.insert_link_outlined,
                          color: AppColors.primaryColor,
                        )),
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: IconButton(
                        onPressed: () {
                          addMsg();
                        },
                        icon: Icon(Icons.send,
                            size: 21.sp, color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                ),
              ),
              // Container(
              //   height: 55,
              //   width: Get.width,
              //   alignment: Alignment.centerRight,
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     children: [
              //       Container(
              //         padding: EdgeInsets.symmetric(horizontal: 10.sp),
              //         height: Get.height * 0.06,
              //         width: Get.width * 0.4,
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           children: [
              //             Icon(Icons.check),
              //             Text(
              //               'Hii',
              //             ),
              //             SizedBox(),
              //           ],
              //         ),
              //         alignment: Alignment.center,
              //         decoration: BoxDecoration(
              //             color: AppColors.lightBlackColor,
              //             borderRadius: BorderRadius.only(
              //                 topRight: Radius.circular(10.sp),
              //                 bottomLeft: Radius.circular(10.sp),
              //                 topLeft: Radius.circular(10.sp))),
              //       ),
              //       Padding(
              //         padding: EdgeInsets.symmetric(vertical: 8.sp),
              //         child: Text(
              //           '01:05',
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
  _callNumber() async{
    const number = '1122334455'; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }
  Future<void> addMsg() async {
    if (_msg.text.isEmpty) {
      log('Please first write meaage..');
      print('------widget.uid----   ${widget.uid}');
    } else {
      FirebaseFirestore.instance
          .collection('chat')
          .doc(chatId(PreferenceManager.getTokenId().toString(), widget.uid))
          .collection('Data')
          .add({
            'date': DateTime.now(),
            'Type': 'Text',
            'senderId': PreferenceManager.getTokenId().toString(),
            'receiveId': widget.uid,
            'seen': false,
            'video': '',
            'msg': _msg.text,
            'image': '',
            'document': '',
            'voiceNote': '',
        'time':DateTime.now(),
          })
          .then((value) => _msg.clear())
          .catchError((e) => print(e));
      print('------widget.uid----   ${widget.uid}');
    }
  }

  int i = 0;

  void _pickFile() async {

    final result = await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result == null) return;

    final file = result.files.first;

    _openFile(file);
  }

  void _openFile(PlatformFile file) {
    OpenFile.open(file.path);
  }
}
