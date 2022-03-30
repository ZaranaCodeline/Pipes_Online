import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:octo_image/octo_image.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/controller/image.dart';
import 'package:pipes_online/buyer/controller/chat_local_file_controller.dart';
import 'package:pipes_online/reerence_chat_msgData.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:video_player/video_player.dart';

final FirebaseStorage kFirebaseStorage = FirebaseStorage.instance;
final FirebaseFirestore kFireStore = FirebaseFirestore.instance;

CollectionReference chatCollection = kFireStore.collection('Chat');

AppBar customAppBar(String title, {Function? leadingOnTap, Widget? action}) {
  final Function() leadingOnTap;

  return AppBar(
    backgroundColor: Colors.white,
    centerTitle: true,
    iconTheme: IconThemeData(color: Colors.green),
    /* leading: leadingOnTap == null
        ? SizedBox()
        : InkResponse(
            onTap: leadingOnTap, child: Icon(Icons.arrow_back_ios_outlined)),*/
    title: Text(
      title,
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 15),
        child: action ?? SizedBox(),
      )
    ],
  );
}

class NewChatScreen extends StatefulWidget {
  NewChatScreen({
    this.receiverId,
    this.userImg,
    this.userName,
    this.file,
  });

  final String? receiverId;
  final String? userImg;
  final String? userName;
  final File? file;

  @override
  State<NewChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<NewChatScreen> {
  // final timerController = TimerController();
  final LocalFileController con = LocalFileController();
  List<Reference> references = [];
  String? senderId, receiverId;
  Duration _duration = new Duration();
  Duration _position = new Duration();
  VideoPlayerController? videoPlayerController;
  VideoPlayerController? _controllerVideos;
  TextEditingController searchController = TextEditingController();

  // LocalFileController con = Get.find();
  bool emojiShowing = false;
  String statusText = "";
  File? path;

  // AudioPlayer? audioPlayer;
  bool isComplete = false;

  FilePickerResult? result;

  // _onEmojiSelected(Emoji emoji) {
  //   searchController
  //     ..text += emoji.emoji
  //     ..selection = TextSelection.fromPosition(
  //         TextPosition(offset: searchController.text.length));
  // }

  _onBackspacePressed() {
    searchController
      ..text = searchController.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: searchController.text.length));
  }

  @override
  void initState() {
    senderId = 's12';
    receiverId = 'r12';
    //admin id
    seenOldMessage();
    //getPdfBytes();
    super.initState();
    // audioPlayer = AudioPlayer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String chatId(String id1, String id2) {
    print('id1 length => ${id1.length} id2 length=> ${id2.length}');
    if (id1.compareTo(id2) > 0) {
      return id1 + '-' + id2;
    } else {
      return id2 + '-' + id1;
    }
  }

  Future<void> seenOldMessage() async {
    QuerySnapshot data = await FirebaseFirestore.instance
        .collection('Chat')
        .doc(chatId(senderId!, receiverId!))
        .collection('Data')
        .where('seen', isEqualTo: false)
        .get();

    data.docs.forEach((element) {
      if (receiverId == element.get('senderId')) {
        FirebaseFirestore.instance
            .collection('Chat')
            .doc(chatId(senderId!, receiverId!))
            .collection('Data')
            .doc(element.id)
            .update({'seen': true});
      }
    });
  }

  UploadTask? task;
  File? file;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        /*  appBar: customAppBar('N/A', leadingOnTap: () async {
          await seenOldMessage();
          Get.back();
        }),*/
        body: _chatScreen(),
      ),
    );
  }

  SizedBox _chatScreen() {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              reverse: true,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _chatField(),
                  _localFileImage(),
                ],
              ),
            ),
          ),
          Align(alignment: Alignment.bottomCenter, child: _bottomBar()),
        ],
      ),
    );
  }

  Widget _localFileImage() {
    return GetBuilder<LocalFileController>(
        builder: (LocalFileController contr) {
      print('list:${contr.fileImageArray.value}');
      return contr.fileImageArray.value.isEmpty
          ? SizedBox()
          : Align(
              alignment: Alignment.centerRight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: contr.fileImageArray.value
                    .map((e) => Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          margin: EdgeInsets.only(right: 10, top: 10),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image(
                                  image: FileImage(e),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.black26,
                                ),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            );
    });
  }

  StreamBuilder<QuerySnapshot> _chatField() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .doc(chatId(senderId!, receiverId!))
          .collection('Data')
          .orderBy('date', descending: true)
          .snapshots(),
      builder: (context, snapShot) {
        if (!snapShot.hasData) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return snapShot.data!.docs.length > 0 ? _chatMsg(snapShot) : SizedBox();
      },
    );
  }

  Widget _chatMsg(AsyncSnapshot<QuerySnapshot> snapShot) {
    return ListView.builder(
        reverse: true,
        padding: EdgeInsets.only(top: 20),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: snapShot.data!.docs.length,
        itemBuilder: (context, index) {
          if (snapShot.data!.docs[index]['type'] == 'Video') {
            print('firebasevideo${snapShot.data!.docs[index]['Video']}');
          }
          _controllerVideos = VideoPlayerController.network(
              snapShot.data!.docs[index]['Video']);
          final chewieController = ChewieController(
            videoPlayerController: _controllerVideos!,
            aspectRatio: 3 / 2,
            autoPlay: false,
            looping: false,
          );
          final playerWidget = Chewie(
            controller: chewieController,
          );
          return snapShot.data!.docs[index]['type'] == 'msg'
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: snapShot.data!.docs[index]['senderId'] == senderId
                      ? Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: Get.width / 5, right: 5, top: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  child: Card(
                                    margin: EdgeInsets.zero,
                                    color: Colors.blue.withOpacity(0.7),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(15))),
                                    elevation: 1,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "${snapShot.data!.docs[index]['msg']}",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10, bottom: 5),
                                          child: MsgDate(
                                            date: (snapShot.data!.docs[index]
                                                    ['date'] as Timestamp)
                                                .toDate(),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'https://www.whatsappprofiledpimages.com/wp-content/uploads/2021/08/Profile-Photo-Wallpaper.jpg'),
                                          fit: BoxFit.cover)),
                                ),
                                /*  PreferenceManager.getCustomerPImg() == null ||
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
                            padding: const EdgeInsets.only(left: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                widget.userImg == null || widget.userImg == ''
                                    ? imageNotFound()
                                    : ClipOval(
                                        child: commonProfileOctoImage(
                                          image: widget.userImg,
                                          height: Get.height * 0.05,
                                          width: Get.height * 0.05,
                                        ),
                                      ),
                                Flexible(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(right: Get.width / 5),
                                    child: Card(
                                      color: Colors.grey[200],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(15)),
                                      ),
                                      elevation: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                snapShot.data!.docs[index]
                                                    ['msg'],
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.black,
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: MsgDate(
                                                date: (snapShot
                                                            .data!.docs[index]
                                                        ['date'] as Timestamp)
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
              : snapShot.data!.docs[index]['type'] == 'image'
                  ? snapShot.data!.docs[index]['senderId'] == senderId
                      ? snapShot.data!.docs[index]['msg'] != ''
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: Get.height * 0.34,
                                        width: Get.width * 0.53,
                                        decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(0.7),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 5, top: 8),
                                              child: Center(
                                                child: InkWell(
                                                  // onTap: () {
                                                  //   Get.to(ZoomImage(
                                                  //     img: snapShot.data!
                                                  //         .docs[index]['image'],
                                                  //   ));
                                                  // },
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    child: OctoImage(
                                                      image:
                                                          CachedNetworkImageProvider(
                                                              snapShot.data!
                                                                          .docs[
                                                                      index]
                                                                  ['image']),
                                                      placeholderBuilder:
                                                          OctoPlaceholder
                                                              .blurHash(
                                                        'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                                                      ),
                                                      errorBuilder:
                                                          OctoError.icon(
                                                              color:
                                                                  Colors.red),
                                                      height: 200,
                                                      width: 200,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "${snapShot.data!.docs[index]['msg']}",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white,
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: MsgDate(
                                        date: (snapShot.data!.docs[index]
                                                ['date'] as Timestamp)
                                            .toDate(),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.primaryColor),
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  'https://www.whatsappprofiledpimages.com/wp-content/uploads/2021/08/Profile-Photo-Wallpaper.jpg'),
                                              fit: BoxFit.cover)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                /* PreferenceManager.getCustomerPImg() == null ||
                PreferenceManager.getCustomerPImg() == ''
                ? imageNotFound()
                : ClipOval(
              child: commonProfileOctoImage(
                image:
                PreferenceManager.getCustomerPImg(),
                height: Get.height * 0.05,
                width: Get.height * 0.05,
              ),
            ),*/
                              ],
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: Get.height * 0.27,
                                        width: Get.width * 0.53,
                                        decoration: BoxDecoration(
                                            color: Colors.blue.withOpacity(0.7),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 5, top: 5),
                                              child: Center(
                                                child: InkWell(
                                                  // onTap: () {
                                                  //   Get.to(ZoomImage(
                                                  //     img: snapShot.data!
                                                  //         .docs[index]['image'],
                                                  //   ));
                                                  // },
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    child: OctoImage(
                                                      image:
                                                          CachedNetworkImageProvider(
                                                              snapShot.data!
                                                                          .docs[
                                                                      index]
                                                                  ['image']),
                                                      placeholderBuilder:
                                                          OctoPlaceholder
                                                              .blurHash(
                                                        'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                                                      ),
                                                      errorBuilder:
                                                          OctoError.icon(
                                                              color:
                                                                  Colors.red),
                                                      height:
                                                          Get.height * 0.255,
                                                      width: Get.width * 0.5,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: MsgDate(
                                        date: (snapShot.data!.docs[index]
                                                ['date'] as Timestamp)
                                            .toDate(),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black),
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  'https://www.whatsappprofiledpimages.com/wp-content/uploads/2021/08/Profile-Photo-Wallpaper.jpg'),
                                              fit: BoxFit.cover)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                /* PreferenceManager.getCustomerPImg() == null ||
                PreferenceManager.getCustomerPImg() == ''
                ? imageNotFound()
                : ClipOval(
              child: commonProfileOctoImage(
                image:
                PreferenceManager.getCustomerPImg(),
                height: Get.height * 0.05,
                width: Get.height * 0.05,
              ),
            ),*/
                              ],
                            )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            widget.userImg == null || widget.userImg == ''
                                ? imageNotFound()
                                : ClipOval(
                                    child: commonProfileOctoImage(
                                      image: widget.userImg,
                                      height: Get.height * 0.05,
                                      width: Get.height * 0.05,
                                    ),
                                  ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 10),
                              child: Column(
                                children: (snapShot.data!.docs[index]['image']
                                        as List)
                                    .map(
                                      (e) => Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: InkWell(
                                            onTap: () {
                                              // Get.to(ZoomImage(
                                              //   img: e,
                                              // ));
                                            },
                                            child: OctoImage(
                                              image: CachedNetworkImageProvider(
                                                  '$e'),
                                              placeholderBuilder:
                                                  OctoPlaceholder.blurHash(
                                                'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
                                              ),
                                              errorBuilder: OctoError.icon(
                                                  color: Colors.red),
                                              height: 200,
                                              width: 200,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: MsgDate(
                                date: (snapShot.data!.docs[index]['date']
                                        as Timestamp)
                                    .toDate(),
                              ),
                            )
                          ],
                        )
                  : snapShot.data!.docs[index]['type'] == 'Video'
                      ? snapShot.data!.docs[index]['senderId'] == senderId
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            height: Get.height * 0.3,
                                            width: Get.width * 0.8,

                                            //padding: EdgeInsets.only(right: 253),
                                            child: playerWidget,
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: MsgDate(
                                          date: (snapShot.data!.docs[index]
                                                  ['date'] as Timestamp)
                                              .toDate(),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    width: Get.width * 0.01,
                                  ),
                                  Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                'https://www.whatsappprofiledpimages.com/wp-content/uploads/2021/08/Profile-Photo-Wallpaper.jpg'),
                                            fit: BoxFit.cover)),
                                  ),
                                ],
                              ),
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: Get.height * 0.3,
                                          width: Get.width * 0.8,
                                          //padding: EdgeInsets.only(right: 253),
                                          child: playerWidget,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: MsgDate(
                                        date: (snapShot.data!.docs[index]
                                                ['date'] as Timestamp)
                                            .toDate(),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: Get.width * 0.01,
                                ),
                                Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'https://www.whatsappprofiledpimages.com/wp-content/uploads/2021/08/Profile-Photo-Wallpaper.jpg'),
                                          fit: BoxFit.cover)),
                                ),
                              ],
                            )
                      : snapShot.data!.docs[index]['type'] == 'Audio'
                          ? snapShot.data!.docs[index]['senderId'] == senderId
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            height: Get.height * 0.07,
                                            width: Get.width * 0.65,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            child: Row(
                                              children: [
                                                /*  GestureDetector(
                                                    behavior:
                                                        HitTestBehavior.opaque,
                                                    onTap: () {
                                                      setState(() {
                                                        play();
                                                      });
                                                    },
                                                    child: */ /*recordFilePath !=
                                                            null
                                                        ?*/

                                                /*  : Container()*/
                                                // GestureDetector(
                                                //   child: RecordMp3.instance
                                                //       .status !=
                                                //       RecordStatus.PAUSE
                                                //       ? Icon(
                                                //     Icons.stop,
                                                //     color: Colors.red,
                                                //   )
                                                //       : Container(),
                                                //   onTap: () {
                                                //     setState(() {
                                                //       pauseRecord();
                                                //     });
                                                //   },
                                                // ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: MsgDate(
                                              date: (snapShot.data!.docs[index]
                                                      ['date'] as Timestamp)
                                                  .toDate(),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.01,
                                      ),
                                      Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    'https://www.whatsappprofiledpimages.com/wp-content/uploads/2021/08/Profile-Photo-Wallpaper.jpg'),
                                                fit: BoxFit.cover)),
                                      ),
                                    ],
                                  ),
                                )
                              : Container()
                          : snapShot.data!.docs[index]['type'] == 'pdf'
                              ? snapShot.data!.docs[index]['senderId'] ==
                                      senderId
                                  ? snapShot.data!.docs[index]['msg'] != ''
                                      ? Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    height: Get.height * 0.23,
                                                    width: 100,
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue
                                                          .withOpacity(0.7),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(15),
                                                              bottomLeft: Radius
                                                                  .circular(15),
                                                              topRight: Radius
                                                                  .circular(
                                                                      15)),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        GestureDetector(
                                                          child: Container(
                                                            height: 130,
                                                            width: 100,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.only(
                                                                    topLeft:
                                                                        Radius.circular(
                                                                            15),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            15),
                                                                    topRight:
                                                                        Radius.circular(
                                                                            15)),
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .blue
                                                                        .withOpacity(
                                                                            0.7),
                                                                    width: 2),
                                                                image: DecorationImage(
                                                                    image: NetworkImage(
                                                                        'https://thumbs.dreamstime.com/b/file-pdf-icon-white-isolated-blue-background-vector-illustration-96493432.jpg'),
                                                                    fit: BoxFit.cover)),
                                                          ),
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          PdfViewer(
                                                                    file: snapShot
                                                                            .data!
                                                                            .docs[index]
                                                                        ['pdf'],
                                                                  ),
                                                                ));
                                                          },
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            "${snapShot.data!.docs[index]['msg']}",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.white,
                                                              fontFamily:
                                                                  'Poppins',
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.008,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: MsgDate(
                                                      date:
                                                          (snapShot.data!.docs[
                                                                          index]
                                                                      ['date']
                                                                  as Timestamp)
                                                              .toDate(),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: Get.width * 0.01,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: Container(
                                                width: 35,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black),
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            'https://www.whatsappprofiledpimages.com/wp-content/uploads/2021/08/Profile-Photo-Wallpaper.jpg'),
                                                        fit: BoxFit.cover)),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  GestureDetector(
                                                    child: Container(
                                                      height: Get.height * 0.3,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.only(
                                                              topLeft:
                                                                  Radius.circular(
                                                                      15),
                                                              bottomLeft:
                                                                  Radius.circular(
                                                                      15),
                                                              topRight:
                                                                  Radius.circular(
                                                                      15)),
                                                          border: Border.all(
                                                              color: Colors.blue
                                                                  .withOpacity(
                                                                      0.7),
                                                              width: 2),
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  'https://thumbs.dreamstime.com/b/file-pdf-icon-white-isolated-blue-background-vector-illustration-96493432.jpg'),
                                                              fit: BoxFit.cover)),
                                                    ),
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    PdfViewer(
                                                              file: snapShot
                                                                      .data!
                                                                      .docs[
                                                                  index]['pdf'],
                                                            ),
                                                          ));
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.008,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: MsgDate(
                                                      date:
                                                          (snapShot.data!.docs[
                                                                          index]
                                                                      ['date']
                                                                  as Timestamp)
                                                              .toDate(),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: Get.width * 0.01,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: Container(
                                                width: 35,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black),
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            'https://www.whatsappprofiledpimages.com/wp-content/uploads/2021/08/Profile-Photo-Wallpaper.jpg'),
                                                        fit: BoxFit.cover)),
                                              ),
                                            ),
                                          ],
                                        )
                                  : Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                child: Container(
                                                  height: 120,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(15),
                                                              bottomLeft: Radius
                                                                  .circular(15),
                                                              topRight:
                                                                  Radius.circular(
                                                                      15)),
                                                      border: Border.all(
                                                          color: Colors.blue
                                                              .withOpacity(0.7),
                                                          width: 2),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              'https://thumbs.dreamstime.com/b/file-pdf-icon-white-isolated-blue-background-vector-illustration-96493432.jpg'),
                                                          fit: BoxFit.cover)),
                                                ),
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            PdfViewer(
                                                          file: snapShot.data!
                                                                  .docs[index]
                                                              ['pdf'],
                                                        ),
                                                      ));
                                                },
                                              ),
                                              SizedBox(
                                                height: Get.height * 0.008,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: MsgDate(
                                                  date: (snapShot
                                                              .data!.docs[index]
                                                          ['date'] as Timestamp)
                                                      .toDate(),
                                                ),
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.01,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Container(
                                            width: 35,
                                            height: 35,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black),
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        'https://www.whatsappprofiledpimages.com/wp-content/uploads/2021/08/Profile-Photo-Wallpaper.jpg'),
                                                    fit: BoxFit.cover)),
                                          ),
                                        ),
                                      ],
                                    )
                              : SizedBox();
        });
  }

  Widget _bottomBar() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  uploadMultiImage();
                },
                child: Icon(
                  Icons.image,
                  color: Colors.red,
                ),
              ),
              // SizedBox(width: kDefaultPadding / 3),
              //Timerwidget(controller: timerController),
              /*  InkWell(
                onLongPress: () {
                  startRecord();
                },
                onTap: () {
                  stopRecord();
                  Audio();
                },
                child: Icon(
                  Icons.mic,
                  color: kSuccessColor,
                ),
              ),*/

              // SizedBox(width: kDefaultPadding / 3),
              InkWell(
                onTap: () {
                  setState(() {
                    emojiShowing = !emojiShowing;
                  });
                },
                child: Icon(
                  Icons.sentiment_satisfied_alt_outlined,
                  color: Colors.red,
                ),
              ),

              //SizedBox(width: kDefaultPadding / 3),
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    )),
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 270,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.camera_alt,
                                      size: 30,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Camera')
                                  ],
                                ),
                              ),
                              onTap: () async {
                                _pickVideoFromCamera();
                              },
                            ),
                            Divider(),
                            GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.video_call,
                                      size: 30,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Video')
                                  ],
                                ),
                              ),
                              onTap: () {
                                _pickVideoFromGallary();
                              },
                            ),
                            Divider(),
                            GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.image,
                                      size: 30,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Image')
                                  ],
                                ),
                              ),
                              onTap: () {
                                _pickImageFromCamera();
                              },
                            ),
                            Divider(),
                            GestureDetector(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.file_copy,
                                      size: 30,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Document')
                                  ],
                                ),
                              ),
                              onTap: () {
                                pickFile();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Icon(
                  Icons.attachment_rounded,
                  color: Colors.red,
                  size: 30,
                ),
              ),

              // SizedBox(width: kDefaultPadding - 5),
              //task != null ? buildUploadStatus(task!) : Container(),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: const Color(0xFFD1D1D1)),
                  ),
                  child: Row(
                    children: [
                      //SizedBox(width: kDefaultPadding / 4),
                      Expanded(
                        child: TextField(
                          controller: searchController,
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
                      InkWell(
                        onTap: addTextData,
                        child: Text(
                          'SEND',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  int i = 0;

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return sdPath + "/test_${i++}.mp3";
  }

  addTextData() {
    if (searchController.text.isEmpty) {
      log('Please first write meaage..');
    } else {
      FirebaseFirestore.instance
          .collection('Chat')
          .doc(chatId(senderId!, receiverId!))
          .collection('Data')
          .add({
            'date': DateTime.now(),
            'text': true,
            "Video": '',
            'senderId': senderId,
            'receiveId': receiverId,
            'seen': false,
            'msg': searchController.text,
            'image': '',
            'type': 'msg',
            'pdf': '',
            'Audio': '',
          })
          .then((value) => searchController.clear())
          .catchError((e) => print(e));
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
    chatCollection.doc(chatId(senderId!, receiverId!)).collection('Data').add({
      'date': DateTime.now(),
      'type': 'Video',
      'Audio': '',
      'senderId': senderId,
      'receiveId': receiverId,
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

  Audio() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var file = Directory(sdPath + "/test_${i++}.mp3");

    if (file != null) {
      // con.addFileImageArray(File(file.path));
      uploadAudioFirebaseStorage(file: File(file.path));
    }
  }

  uploadAudioFirebaseStorage({File? file}) async {
    var snapshot = await kFirebaseStorage
        .ref()
        .child('chatAudio/${DateTime.now().microsecondsSinceEpoch}')
        .putFile(file!);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    print('url=$downloadUrl');
    // print('path=$fileImageArray');
    chatCollection.doc(chatId(senderId!, receiverId!)).collection('Data').add({
      'date': DateTime.now(),
      'type': 'Audio',
      'senderId': senderId,
      'receiveId': receiverId,
      'seen': false,
      'text': false,
      'msg': '',
      'image': '',
      'Video': '',
      'Audio': downloadUrl,
      'pdf': ''
    }).then((value) {
      print('success add');
      con.onClose();
    }).catchError((e) => print('upload error'));
  }

  _pickVideoFromCamera() async {
    ImagePicker videoPicker = ImagePicker();
    PickedFile? file = await videoPicker.getVideo(source: ImageSource.camera);
    if (file != null) {
      // con.addFileImageArray(File(file.path));
      uploadVideoFirebaseStorage(file: File(file.path));
    }
  }

  _pickVideoFromGallary() async {
    ImagePicker videoPicker = ImagePicker();
    PickedFile? file = await videoPicker.getVideo(source: ImageSource.gallery);
    if (file != null) {
      //con.addFileImageArray(File(file.path));
      String attach = file.path.split('.').last;

      Get.to(ShowDocument(
        receiverId: receiverId,
        senderId: senderId,
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

  Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc', 'mp3'],
    );
    String? splites = result!.paths[0];
    path = File(splites!);
    print('PATH::::$path');
    String attach = splites.split('.').last;
    print('PATH  ${attach}');
    if (path != null) {
      Get.to(ShowDocument(
        receiverId: receiverId,
        senderId: senderId,
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

  _pickImageFromCamera() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile? file = await imagePicker.getImage(source: ImageSource.camera);

    if (file != null) {
      con.addFileImageArray(File(file.path));
      String attach = file.path.split('.').last;

      Get.to(ShowDocument(
          receiverId: receiverId,
          senderId: senderId,
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

  Future uploadMultiImage() async {
    try {
      final resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
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
    chatCollection.doc(chatId(senderId!, receiverId!)).collection('Data').add({
      'date': DateTime.now(),
      'text': false,
      'pdf': '',
      'senderId': senderId,
      'receiveId': receiverId,
      'seen': false,
      'msg': '',
      'image': downloadUrl,
      'type': 'image',
      'Video': '',
      'Audio': '',
    }).then((value) {
      print('success add');
      con.clearImage();
    }).catchError((e) => print('upload error'));
  }
}

class FlutterAbsolutePath {
  static const MethodChannel _channel =
      const MethodChannel('flutter_absolute_path');

  /// Gets absolute path of the file from android URI or iOS PHAsset identifier
  /// The return of this method can be used directly with flutter [File] class
  static Future<String?> getAbsolutePath(String uri) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'uri': uri,
    };
    final String? path = await _channel.invokeMethod('getAbsolutePath', params);
    return path;
  }
}

class ShowDocument extends StatelessWidget {
  final String? senderId, receiverId;
  final String? type;
  final File? file;
  final LocalFileController con = Get.find();
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
    chatCollection.doc(chatId(senderId!, receiverId!)).collection('Data').add({
      'date': DateTime.now(),
      'type': type,
      'senderId': senderId,
      'receiveId': receiverId,
      'seen': false,
      'msg': msg,
      'text': true,
      'Video': '',
      'image': type == 'image' ? downloadUrl : '',
      'pdf': type == 'pdf' ? downloadUrl : '',
      'Audio': type == 'Audio' ? downloadUrl : '',
    }).then((value) {
      print('success add');
      con.clearImage();
    }).catchError((e) => print('upload error'));
  }
}

class PdfViewer extends StatefulWidget {
  final String? file;

  PdfViewer({Key? key, this.file}) : super(key: key);

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                child: SfPdfViewer.network(
                  widget.file!,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
