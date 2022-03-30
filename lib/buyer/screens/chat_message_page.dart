import 'dart:developer';
import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:open_file/open_file.dart';
import 'package:pipes_online/seller/controller/chat_controller.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../reerence_chat_msgData.dart';
import '../../reference_chat.dart';
import '../app_constant/app_colors.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../controller/chat_local_file_controller.dart';
import '../controller/image.dart';
import '../custom_widget/widgets/custom_widget/custom_text.dart';
import 'package:video_player/video_player.dart';

final FirebaseStorage kFirebaseStorage = FirebaseStorage.instance;
final FirebaseFirestore kFireStore = FirebaseFirestore.instance;
CollectionReference chatCollection = kFireStore.collection('Chat');

class ChatMessagePage extends StatefulWidget {
  final String receiverId;
  final String userName;
  final String userImg;

  ChatMessagePage(
      {required this.receiverId,
      required this.userName,
      required this.userImg});

  @override
  State<ChatMessagePage> createState() => _ChatMessagePageState();
}

class _ChatMessagePageState extends State<ChatMessagePage> {
  final LocalFileController con = LocalFileController();

  ChatController chatController = Get.put(ChatController());
  String statusText = "";
  bool isComplete = false;
  String? recordFilePath;
  String? documentName;
  final File? file1 = File('');
  final String? type = '';

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

  final TextEditingController _msg = TextEditingController();

  VideoPlayerController? _controllerVideos;
  VideoPlayerController? videoPlayerController;

  String chatId(String id1, String id2) {
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
                            widget.userImg,
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
                  SizedBox(width: Get.width * 0.03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        alignment: Alignment.center,
                        text: '${widget.userName}',
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
                      print('click...');
                      launch('tel:1234567892');
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
        body: Column(
          children: [
            Center(
              child: Container(
                child: type == 'image'
                    ? Image.file(file1!)
                    : type == 'pdf'
                        ? SfPdfViewer.file(file1!)
                        : SizedBox(),
              ),
            ),
            Expanded(
              flex: 7,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                reverse: true,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('chat')
                            .doc(chatId(PreferenceManager.getTokenId().toString(),
                                widget.receiverId))
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
                                // if (snapShot.data!.docs[index]['Type'] ==
                                //     'Video') {
                                //   print(
                                //       'firebasevideo${snapShot.data!.docs[index]['video']}');
                                // }video
                                // _controllerVideos = VideoPlayerController.network(
                                //     snapShot.data!.docs[index]['Video']);
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
                                        padding: const EdgeInsets.only(bottom: 8),
                                        child: snapShot.data!.docs[index]
                                                    ['senderId'] ==
                                                'payal'
                                            ? Align(
                                                alignment: Alignment.centerRight,
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
                                                          margin: EdgeInsets.zero,
                                                          color: AppColors
                                                              .primaryColor,
                                                          shape:
                                                              const RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.only(
                                                              topLeft:
                                                                  Radius.circular(
                                                                      15),
                                                              bottomRight:
                                                                  Radius.circular(
                                                                      15),
                                                              bottomLeft:
                                                                  Radius.circular(
                                                                      15),
                                                            ),
                                                          ),
                                                          elevation: 1,
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize.min,
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
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        right: 10,
                                                                        bottom:
                                                                            5),
                                                                child: MsgDate(
                                                                  date: (snapShot
                                                                              .data!
                                                                              .docs[index]['date']
                                                                          as Timestamp)
                                                                      .toDate(),
                                                                ),
                                                              )
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
                                                  padding: const EdgeInsets.only(
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
                                                                .primaryColor
                                                                .withOpacity(0.5),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          15),
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
                                                                      snapShot.data!
                                                                              .docs[index]
                                                                          ['msg'],
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
                                                                            'Ubuntu',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .only(
                                                                        top: 10),
                                                                    child:
                                                                        MsgDate(
                                                                      date: (snapShot
                                                                              .data!
                                                                              .docs[index]['date'] as Timestamp)
                                                                          .toDate(),
                                                                    ),
                                                                  )
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
                                                'payal'
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
                                                   PreferenceManager.getCustomerPImg() == null ||
                                      PreferenceManager.getCustomerPImg() == ''
                                  ? imageNotFound()
                                  : ClipOval(
                                      child: commonProfileOctoImage(
                                        image: PreferenceManager.getCustomerPImg().toString(),
                                        height: Get.height * 0.09,
                                        width: Get.height * 0.09
                                      ),
                                    ),
                                                ],
                                              )
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  widget.userImg == null ||
                                                          widget.userImg == ''
                                                      ? imageNotFound()
                                                      : ClipOval(
                                                          child:
                                                              commonProfileOctoImage(
                                                            image: widget.userImg,
                                                            height:
                                                                Get.height * 0.05,
                                                            width:
                                                                Get.height * 0.05,
                                                          ),
                                                        ),
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
                                                                      bottom: 5),
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
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: MsgDate(
                                                      date: (snapShot.data!
                                                                      .docs[index]
                                                                  ['date']
                                                              as Timestamp)
                                                          .toDate(),
                                                    ),
                                                  ),
                                                ],
                                              ):Text('ud');
                                       /* : snapShot.data!.docs[index]['Type'] ==
                                                'Video'
                                            ? snapShot.data!.docs[index]
                                                        ['senderId'] ==
                                                    'uorKvVoRJzOeYCMYT1vwjkrFKxz2'
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      // Container(
                                                      //   height: 250,
                                                      //   width: 250,
                                                      //   padding:
                                                      //       EdgeInsets.symmetric(
                                                      //     horizontal: 20,
                                                      //   ),
                                                      //   child: playerWidget,
                                                      // ),
                                                    ],
                                                  )
                                                : Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      // Container(
                                                      //   height: 250,
                                                      //   width: 250,
                                                      //   padding:
                                                      //       EdgeInsets.symmetric(
                                                      //     horizontal: 20,
                                                      //   ),
                                                      //   child: playerWidget,
                                                      // ),
                                                    ],
                                                  )
                                            : snapShot.data!.docs[index]
                                                        ['Type'] ==
                                                    PreferenceManager.getTokenId()
                                                        .toString()
                                                ? Padding(
                                                    padding: EdgeInsets.only(
                                                        right: Get.width / 5),
                                                    child: Card(
                                                      color: Colors.grey[200],
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
                                                            Icon(
                                                              Icons.description,
                                                              color: Colors.black,
                                                            ),
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
                                                                  color: AppColors
                                                                      .primaryColor
                                                                      .withOpacity(
                                                                          0.5),
                                                                  fontFamily:
                                                                      'Ubuntu-Regular',
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 10),
                                                              child: MsgDate(
                                                                date: (snapShot
                                                                            .data!
                                                                            .docs[index]['date']
                                                                        as Timestamp)
                                                                    .toDate(),
                                                              ),
                                                            )
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
                                                        color: AppColors
                                                            .primaryColor,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topRight:
                                                                      Radius
                                                                          .circular(
                                                                              15),
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
                                                              const EdgeInsets
                                                                  .all(8.0),
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
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        14.sp,
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
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        top: 10),
                                                                child: MsgDate(
                                                                  date: (snapShot
                                                                              .data!
                                                                              .docs[index]['date']
                                                                          as Timestamp)
                                                                      .toDate(),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );*/
                              },
                            );
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryColor.withOpacity(0.5),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //bottom sheet
            Container(
              height: 55,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: SizedBox(
                            height: 50,
                            child: TextFormField(
                              cursorColor: Colors.white,
                              controller: _msg,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                prefixIcon: InkWell(
                                  onTap:(){} ,
                                  child:Icon(Icons.link_outlined) ,
                                ),
                                suffixIcon: InkWell(
                                  onTap: () {
                                    print('it camara');
                                    pickFile();
                                    // _pickImageFromCamera();
                                  },
                                  child: Icon(Icons.image),
                                ),
                                fillColor: AppColors.backGroudColor,
                                filled: true,
                                hintText: 'Message',
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: BorderSide.none),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 15),
                              ),
                            ))),
                    // GestureDetector(
                    //   onTap: () {
                    //     print('on tap');
                    //   },
                    //   onLongPressStart: (_) async {
                    //     print('on long tap');
                    //     // startRecord();
                    //   },
                    //   // onLongPressCancel: () {
                    //   //   cancelPress();
                    //   // },
                    //   onLongPressEnd: (_) {
                    //     // stopRecord();
                    //
                    //     print('on long end');
                    //   },
                    //   child: Icon(
                    //     Icons.mic,
                    //     color: Colors.grey.shade400,
                    //     size: 30,
                    //   ),
                    // ),
                    // InkWell(
                    //   onTap: () {
                    //     showModalBottomSheet(
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.only(
                    //         topLeft: Radius.circular(30),
                    //         topRight: Radius.circular(30),
                    //       )),
                    //       context: context,
                    //       builder: (context) {
                    //         return Container(
                    //           height: 350,
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.only(
                    //               topLeft: Radius.circular(30),
                    //               topRight: Radius.circular(30),
                    //             ),
                    //           ),
                    //           child: GridView.builder(
                    //             padding: EdgeInsets.symmetric(
                    //                 vertical: 20, horizontal: 25),
                    //             gridDelegate:
                    //                 SliverGridDelegateWithFixedCrossAxisCount(
                    //               crossAxisCount: 4,
                    //               mainAxisSpacing: 15,
                    //               crossAxisSpacing: 15,
                    //               childAspectRatio: 1,
                    //             ),
                    //             itemCount: iconData.length,
                    //             itemBuilder: (context, index) {
                    //               return GestureDetector(
                    //                 onTap: () async {
                    //                   performTask(index);
                    //                   Get.back();
                    //                 },
                    //                 child: Column(
                    //                   children: [
                    //                     Icon(
                    //                       iconData[index]['icon'],
                    //                       size: 30,
                    //                       color: Colors.grey,
                    //                     ),
                    //                     SizedBox(
                    //                       height: 10,
                    //                     ),
                    //                     Text('${iconData[index]['name']}')
                    //                   ],
                    //                 ),
                    //               );
                    //             },
                    //           ),
                    //         );
                    //       },
                    //     );
                    //   },
                    //   child: Icon(
                    //     Icons.attachment_rounded,
                    //     color: Colors.grey.shade400,
                    //     size: 30,
                    //   ),
                    // ),
                    // SizedBox(width: 10),

                    IconButton(
                      onPressed: () {

                        addMsg();
                      },
                      icon: Icon(Icons.send,
                          size: 21.sp, color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),
            ),
            // Container(
            //   height: 80,
            //   padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            //   child: TextField(
            //     controller: _msg,
            //     decoration: InputDecoration(
            //       fillColor: AppColors.offWhiteColor,
            //       contentPadding:
            //           const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            //       filled: true,
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(30),
            //         borderSide: BorderSide(
            //           width: 1,
            //           color: AppColors.primaryColor,
            //           style: BorderStyle.solid,
            //         ),
            //       ),
            //       hintText: 'Message...',
            //       hintStyle: TextStyle(color: AppColors.hintTextColor),
            //       prefix: InkWell(
            //         onTap: () {
            //           showModalBottomSheet(
            //             shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.only(
            //               topLeft: Radius.circular(30),
            //               topRight: Radius.circular(30),
            //             )),
            //             context: context,
            //             builder: (context) {
            //               return Container(
            //                 height: 270,
            //                 decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.only(
            //                     topLeft: Radius.circular(30),
            //                     topRight: Radius.circular(30),
            //                   ),
            //                 ),
            //                 child: Column(
            //                   children: [
            //                     SizedBox(
            //                       height: 10,
            //                     ),
            //                     GestureDetector(
            //                       child: Padding(
            //                         padding: const EdgeInsets.all(8.0),
            //                         child: Row(
            //                           children: [
            //                             Icon(
            //                               Icons.camera_alt,
            //                               size: 30,
            //                               color: Colors.grey,
            //                             ),
            //                             SizedBox(
            //                               width: 10,
            //                             ),
            //                             Text('Camera')
            //                           ],
            //                         ),
            //                       ),
            //                       onTap: () async {
            //                         _pickVideoFromCamera();
            //                       },
            //                     ),
            //                     Divider(),
            //                     GestureDetector(
            //                       child: Padding(
            //                         padding: const EdgeInsets.all(8.0),
            //                         child: Row(
            //                           children: [
            //                             Icon(
            //                               Icons.video_call,
            //                               size: 30,
            //                               color: Colors.grey,
            //                             ),
            //                             SizedBox(
            //                               width: 10,
            //                             ),
            //                             Text('Video')
            //                           ],
            //                         ),
            //                       ),
            //                       onTap: () {
            //                         _pickVideoFromGallary();
            //                       },
            //                     ),
            //                     Divider(),
            //                     GestureDetector(
            //                       child: Padding(
            //                         padding: const EdgeInsets.all(8.0),
            //                         child: Row(
            //                           children: [
            //                             Icon(
            //                               Icons.image,
            //                               size: 30,
            //                               color: Colors.grey,
            //                             ),
            //                             SizedBox(
            //                               width: 10,
            //                             ),
            //                             Text('Image')
            //                           ],
            //                         ),
            //                       ),
            //                       onTap: () {
            //                         _pickImageFromCamera();
            //                       },
            //                     ),
            //                     Divider(),
            //                     GestureDetector(
            //                       child: Padding(
            //                         padding: const EdgeInsets.all(8.0),
            //                         child: Row(
            //                           children: [
            //                             Icon(
            //                               Icons.file_copy,
            //                               size: 30,
            //                               color: Colors.grey,
            //                             ),
            //                             SizedBox(
            //                               width: 10,
            //                             ),
            //                             Text('Document')
            //                           ],
            //                         ),
            //                       ),
            //                       onTap: () {
            //                         pickFile();
            //                       },
            //                     ),
            //                   ],
            //                 ),
            //               );
            //             },
            //           );
            //         },
            //         child: Icon(
            //           Icons.attachment_rounded,
            //           color: AppColors.primaryColor,
            //           size: 30,
            //         ),
            //       ),
            //       prefixIcon: IconButton(
            //           onPressed: () async {
            //             print('Open Share Option');
            //
            //             // pickFile();
            //             //  final result = await FilePicker.platform.pickFiles();
            //             //  if(result == null) return;
            //             //  //open single file
            //             // final file = result.files.first;
            //             // openFile(file);
            //             //chatController.getImage();
            //           },
            //           icon: Icon(
            //             Icons.image_outlined,
            //             color: AppColors.primaryColor,
            //           )),
            //       // prefixIcon: IconButton(
            //       //     onPressed: () async {
            //       //       print('Open Share Option');
            //       //       // pickFile();
            //       //       //  final result = await FilePicker.platform.pickFiles();
            //       //       //  if(result == null) return;
            //       //       //  //open single file
            //       //       // final file = result.files.first;
            //       //       // openFile(file);
            //       //       //chatController.getImage();
            //       //     },
            //       //     icon: Icon(
            //       //       Icons.insert_link_outlined,
            //       //       color: AppColors.primaryColor,
            //       //     )),
            //       suffixIcon: Padding(
            //         padding: EdgeInsets.all(8.0),
            //         child: IconButton(
            //           onPressed: () {
            //             addMsg();
            //           },
            //           icon: Icon(Icons.send,
            //               size: 21.sp, color: AppColors.primaryColor),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  CollectionReference chatCollection = kFireStore.collection('chat');

  Future<void> addMsg() async {
    if (_msg.text.isEmpty) {
      log('Please first write meaage..');
      print('------widget.uid----   ${widget.receiverId}');
    } else {
      FirebaseFirestore.instance
          .collection('chat')
          .doc(chatId(
              'payal', widget.receiverId))
          .collection('Data')
          .add({
            'date': DateTime.now(),
            'Type': 'Text',
            'senderId': 'payal',
            'receiveId': 'milan',
            'seen': false,
            'video': '',
            'msg': _msg.text,
            'image': '',
            'document': '',
            'voiceNote': '',
            'time': DateTime.now(),
          })
          .then((value) => _msg.clear())
          .catchError((e) => print(e));
      print('------widget.uid----   ${widget.receiverId}');
    }
  }

  File? path;

  Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg'],
    );
    String? splites = result!.paths[0];
    path = File(splites!);
    print('PATH::::$path');
    String attach = splites.split('.').last;
    print('PATH  ${attach}');
    if (path != null) {
      Get.to(ShowDocument(
        receiverId: 'payal',
        senderId:widget.receiverId,
        file: path,
        type: attach == 'jpg' ||
                attach == 'png' ||
                attach == 'PNG' ||
                attach == 'JPG' ||
                attach == ' jpeg'
            ? 'image'
            : attach == 'mp3' || attach == 'opus'
                ? 'Audio'
                : attach == 'pdf'
                    ? 'pdf'
                    : '',
      ));
    } else {
      SizedBox();
    }
    //file=File(file!.path);
    //return uploadDocumentFirebaseStorage(file: File(path!));
  }

  int i = 0;

  _pickVideoFromCamera() async {
    ImagePicker videoPicker = ImagePicker();
    PickedFile? file = await videoPicker.getVideo(source: ImageSource.camera);
    if (file != null) {
      // con.addFileImageArray(File(file.path));
      uploadVideoFirebaseStorage(file: File(file.path));
    }
  }

  uploadVideoFirebaseStorage({File? file}) async {
    var snapshot = await kFirebaseStorage
        .ref()
        .child('chatVideo/${DateTime.now().microsecondsSinceEpoch}')
        .putFile(file!);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    print('url=$downloadUrl');
    // print('path=$fileImageArray');
    chatCollection
        .doc(chatId(PreferenceManager.getTokenId().toString(),
            'uorKvVoRJzOeYCMYT1vwjkrFKxz2'))
        .collection('Data')
        .add({
      'date': DateTime.now(),
      'type': 'Video',
      'Audio': '',
      'senderId': 'uorKvVoRJzOeYCMYT1vwjkrFKxz2',
      'receiveId': PreferenceManager.getTokenId().toString(),
      'seen': false,
      'text': false,
      'msg': '',
      'image': '',
      'Video': downloadUrl,
      'pdf': ''
    }).then((value) {
      print('success add');
      con.clearImage();
    }).catchError((e) => print('upload error'));
  }

  _pickVideoFromGallary() async {
    ImagePicker videoPicker = ImagePicker();
    PickedFile? file = await videoPicker.getVideo(source: ImageSource.gallery);
    if (file != null) {
      //con.addFileImageArray(File(file.path));
      String attach = file.path.split('.').last;

      Get.to(ShowDocument(
        receiverId: PreferenceManager.getTokenId().toString(),
        senderId: 'uorKvVoRJzOeYCMYT1vwjkrFKxz2',
        file: path,
        type: attach == 'jpg' ||
                attach == 'png' ||
                attach == 'PNG' ||
                attach == 'JPG' ||
                attach == ' jpeg'
            ? 'image'
            : 'pdf',
      ));
      uploadVideoFirebaseStorage(file: File(file.path));
    }
  }

  _pickImageFromCamera() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile? file = await imagePicker.getImage(source: ImageSource.camera);

    if (file != null) {
      con.addFileImageArray(File(file.path));
      String attach = file.path.split('.').last;

      Get.to(ShowDocument(
          receiverId: PreferenceManager.getTokenId().toString(),
          senderId: 'uorKvVoRJzOeYCMYT1vwjkrFKxz2',
          file: path,
          type: attach == 'jpg' ||
                  attach == 'png' ||
                  attach == 'PNG' ||
                  attach == 'JPG' ||
                  attach == ' jpeg'
              ? 'image'
              : attach == 'mp3'
                  ? 'Audio'
                  : attach == 'pdf'
                      ? 'pdf'
                      : ''));
      // uploadImgFirebaseStorage(file: File(file.path));
    }
  }

  void openFile(PlatformFile file) async {
    OpenFile.open(file.path!);
  }

  Future uploadMultiImage() async {
    try {
      final resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
        cupertinoOptions: const CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: const MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
      print('result ${resultList}');
      if (resultList.isNotEmpty) {
        resultList.forEach((imageAsset) async {
          final filePath =
              await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier!);

          File tempFile = File(filePath!);
          if (tempFile.existsSync()) {
            con.addFileImageArray(tempFile);
          }
          await uploadImgFirebaseStorage(file: tempFile);
          print('success');
        });
      }
    } on Exception catch (e) {
      print('error $e');
    }
  }

  uploadImgFirebaseStorage({File? file}) async {
    var snapshot = await kFirebaseStorage
        .ref()
        .child('ChatImage/${DateTime.now().microsecondsSinceEpoch}')
        .putFile(file!);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    print('url=$downloadUrl');
    // print('path=$fileImageArray');
    FirebaseFirestore.instance
        .collection('chat')
        .doc(chatId('payal'.toString(),widget.receiverId))
        .collection('Data')
        .add({
      'date': DateTime.now(),
      'Type': 'Image',
      'senderId': 'payal',
      'receiveId': 'milan',
      'seen': false,
      'msg': '',
      'video': '',
      'image': [downloadUrl],
      'document': '',
      'voiceNote': ''
    }).then((value) {
      print('success add');
      con.clearImage();
    }).catchError((e) => print('upload error'));
  }
}

class ShowDocument extends StatelessWidget {
  final String? senderId, receiverId;
  final String? type;

  final File? file;

  TextEditingController textEditingController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  ShowDocument({Key? key, this.senderId, this.receiverId, this.type, this.file})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('RECEVERID: $receiverId');
    return Scaffold(
      appBar: AppBar(
        title: Text('DOCUMENT'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Center(
              child: Container(
                child: type == 'image'
                    ? Image.file(file!)
                    : type == 'pdf'
                        ? SfPdfViewer.file(file!)
                        : SizedBox(),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      hintText: "Write your message...",
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Color(0xFFA2A2A2),
                        fontWeight: FontWeight.w400,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () async {
                    uploadDocumentFirebaseStorage(
                        file: file, msg: textEditingController.text);
                    Get.back();
                  },
                  icon: Icon(Icons.send)),
            ],
          )
        ],
      ),
    );
  }

  uploadDocumentFirebaseStorage({File? file, String? msg}) async {
    var snapshot = await kFirebaseStorage
        .ref()
        .child('document/${DateTime.now().microsecondsSinceEpoch}')
        .putFile(file!);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    print('url=$downloadUrl');
    // print('path=$fileImageArray');
    chatCollection.doc(chatId('payal',receiverId!)).collection('Data').add({
      'date': DateTime.now(),
      'type': type,
      'senderId':'payal' ,
      'receiveId': 'milan',
      'seen': false,
      'msg': msg,
      'text': true,
      'Video': '',
      'image': type == 'image' ? downloadUrl : '',
      'pdf': type == 'pdf' ? downloadUrl : '',
      'Audio': type == 'Audio' ? downloadUrl : '',
    }).then((value) {
      print('success add');
      //con.clearImage();
    }).catchError((e) => print('upload error'));
  }

  String chatId(String id1, String id2) {
    print('--------id1--id1--------$id1');

    print('id1 length => ${id1.length} id2 length=> ${id2.length}');
    if (id1.compareTo(id2) > 0) {
      return id1 + '-' + id2;
    } else {
      return id2 + '-' + id1;
    }
  }

  File? imagegetFile;

  Future getImage1() async {
    ImagePicker _piker = ImagePicker();
    await _piker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        imagegetFile = File(value.path);
      }
    });
  }
// Future uploadImage()async{
//   if()
// }
}
