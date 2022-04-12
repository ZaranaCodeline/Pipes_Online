import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:octo_image/octo_image.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/app_constant/b_image.dart';
import 'package:pipes_online/buyer/controller/chat_local_file_controller.dart';
import 'package:pipes_online/buyer/controller/image.dart';
import 'package:pipes_online/buyer/screens/zoom_img.dart';
import 'package:pipes_online/convert_date_formate_chat.dart';
import 'package:pipes_online/seller/controller/chat_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../buyer/custom_widget/widgets/custom_text.dart';

final FirebaseStorage kFirebaseStorage = FirebaseStorage.instance;
final FirebaseFirestore kFireStore = FirebaseFirestore.instance;
CollectionReference chatCollection = kFireStore.collection('Chat');
FirebaseAuth _auth = FirebaseAuth.instance;

class SChatMessagePage extends StatefulWidget {
  final String? receiverId ;
  final String? userName;
  final String? userImg;

  SChatMessagePage(
      {required this.receiverId,
        required this.userName,
        required this.userImg});

  @override
  State<SChatMessagePage> createState() => _SChatMessagePageState();
}

class _SChatMessagePageState extends State<SChatMessagePage> {
  final LocalFileController con = LocalFileController();
  final TextEditingController _msg = TextEditingController();
  ChatController chatController = Get.put(ChatController());
  File? path;
  String statusText = "";
  bool isComplete = false;
  String? recordFilePath;
  String? documentName;
  final File? file1 = File('');
  final String? type = '';

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
    print('AuthId====${_auth.currentUser!.uid}');

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
                          child: Image.asset(
                            '${BImagePick.proIcon}',
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
                            .collection('Chat')
                            .doc(chatId(_auth.currentUser!.uid,'payal',))
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
                                print('SENDErId====${snapShot.data!.docs[index]
                                ['senderId']}');
                                return snapShot.data!.docs[index]['Type'] ==
                                    'Text'
                                    ? Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: snapShot.data!.docs[index]
                                  ['senderId'] ==
                                      _auth.currentUser!.uid
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
                                                  .primaryColor.withOpacity(0.5),
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
                                                  ),
                                                  // Padding(
                                                  //   padding: const EdgeInsets.only(right: 10),
                                                  //   child: MsgDate(
                                                  //     date: (snapShot.data!.docs[index]
                                                  //     ['date'] as Timestamp)
                                                  //         .toDate(),
                                                  //   ),
                                                  // ),
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

                                    : snapShot.data!.docs[index]['Type'] == 'Image'
                                    ? snapShot.data!.docs[index]['senderId'] == _auth.currentUser!.uid
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
                                            constraints: BoxConstraints(
                                              maxHeight: double.infinity,),
                                            // height: Get.height * 0.39,
                                            width: Get.width * 0.53,
                                            decoration: BoxDecoration(
                                                color: AppColors.primaryColor.withOpacity(0.5),
                                                borderRadius:
                                                BorderRadius.circular(10)),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding:   EdgeInsets.only(
                                                      bottom: 5.sp, top: 8),
                                                  child: Center(
                                                    child: InkWell(
                                                      onTap: () {
                                                        Get.to(ZoomImage(
                                                          img: snapShot.data!
                                                              .docs[index]['image'],
                                                        ));
                                                      },
                                                      child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                        child: OctoImage(
                                                          image:
                                                          CachedNetworkImageProvider(
                                                              snapShot.data!.docs[index]['image']),
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
                                                  EdgeInsets.all(5.sp),
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
                                                Padding(
                                                  padding:   EdgeInsets.only(right: 10,bottom: 15),
                                                  child: MsgDate(
                                                    date: (snapShot.data!.docs[index]
                                                    ['date'] as Timestamp)
                                                        .toDate(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                      ],
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
                                            height: Get.height * 0.3,
                                            width: Get.width * 0.53,
                                            decoration: BoxDecoration(
                                                color: AppColors.primaryColor.withOpacity(0.5),
                                                borderRadius:
                                                BorderRadius.circular(10)),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      bottom: 5, top: 5,right: 5,left: 5),
                                                  child: Center(
                                                    child: InkWell(
                                                      onTap: () {
                                                        Get.to(ZoomImage(
                                                          img: snapShot.data!
                                                              .docs[index]['image'],
                                                        ));
                                                      },
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
                                                  Get.to(ZoomImage(
                                                    img: e,
                                                  ));
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
                                    :SizedBox();
                              },
                            );
                          }else{
                            return Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor.withOpacity(0.5),
                              ),
                            );
                          }

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
                              cursorColor: AppColors.primaryColor,
                              controller: _msg,
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                suffixIcon: InkWell(
                                  onTap: () {
                                    print('it camara');
                                    // _pickImageFromGallery();
                                    pickFile();
                                  },
                                  child: Icon(Icons.image,color: AppColors.primaryColor,),
                                ),
                                fillColor: AppColors.backGroudColor,
                                filled: true,
                                hintText: 'Message',
                                hintStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: BorderSide.none),
                                contentPadding:
                                EdgeInsets.symmetric(horizontal: 15),
                              ),
                            ))),
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
          ],
        ),
      ),
    );
  }


  Future<void> addMsg() async {
    if (_msg.text.isEmpty) {
      log('Please first write meaage..');
      print('------SEnderwidget.uid----   ${_auth.currentUser?.uid}');
    } else {
      FirebaseFirestore.instance
          .collection('Chat')
          .doc(chatId(
        _auth.currentUser!.uid,'payal',))
          .collection('Data')
          .add({
        'date': DateTime.now(),
        'Type': 'Text',
        'senderId': _auth.currentUser?.uid,
        'receiveId': 'payal',
        'seen': false,
        'msg': _msg.text,
        'image': '',
        'time': DateTime.now(),
      })
          .then((value) => _msg.clear())
          .catchError((e) => print(e));
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
        .collection('Chat')
        .doc(chatId(_auth.currentUser!.uid,'payal',))
        .collection('Data')
        .add({
      'date': DateTime.now(),
      'Type': 'Image',
      'senderId': _auth.currentUser!.uid,
      'receiveId': 'payal' ,
      'seen': false,
      'msg': _msg,
      'image': downloadUrl,
    }).then((value) {
      print('success add');
      con.clearImage();
    }).catchError((e) => print('upload error'));
  }

  _pickImageFromGallery() async {
    // ImagePicker imagePicker = ImagePicker();
    // PickedFile? file = await imagePicker.getImage(source: ImageSource.gallery);

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg','png','PNG','JPG','jpeg','image'],
    );
    String? splites = result!.paths[0];
    setState(() {
      if(splites != null){
        path = File(splites);
      }

    });
    print('PATH::::$path');
    String attach = splites!.split('.').last;
    print('PATH  ${attach}');
    if (path != null) {
      Get.to(ShowDocument(
        receiverId:  'payal',
        senderId:  _auth.currentUser!.uid,
        file: path,
        type: attach == 'jpg' ||
            attach == 'png' ||
            attach == 'PNG' ||
            attach == 'JPG' ||
            attach == ' jpeg'
            ? 'image' : '',
      ));
    } else {
      SizedBox();
    }
  }

  Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg','png','PNG','JPG','jpeg','image'],
    );
    String? splites = result!.paths[0];
    path = File(splites!);
    print('PATH::::$path');
    String attach = splites.split('.').last;
    print('PATH  ${attach}');
    if (path != null) {
      Get.to(ShowDocument(
        receiverId:  'payal',
        senderId:  _auth.currentUser!.uid,
        file: path,
        type: attach == 'jpg' ||
            attach == 'png' ||
            attach == 'PNG' ||
            attach == 'JPG' ||
            attach == ' jpeg'
            ? 'image' : '',
      ));
    } else {
      SizedBox();
    }
    //file=File(file!.path);
    //return uploadDocumentFirebaseStorage(file: File(path!));
  }
// Future uploadMultiImage() async {
//   try {
//     final resultList = await MultiImagePicker.pickImages(
//       maxImages: 5,
//       enableCamera: true,
//       cupertinoOptions: const CupertinoOptions(takePhotoIcon: "chat"),
//       materialOptions: const MaterialOptions(
//         actionBarColor: "#abcdef",
//         actionBarTitle: "Example App",
//         allViewTitle: "All Photos",
//         useDetailsView: false,
//         selectCircleStrokeColor: "#000000",
//       ),
//     );
//     print('result ${resultList}');
//     if (resultList.isNotEmpty) {
//       resultList.forEach((imageAsset) async {
//         final filePath =
//             await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier!);
//
//         File tempFile = File(filePath!);
//         if (tempFile.existsSync()) {
//           con.addFileImageArray(tempFile);
//         }
//         await uploadImgFirebaseStorage(file: tempFile);
//         print('success');
//       });
//     }
//   } on Exception catch (e) {
//     print('error $e');
//   }
// }


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
  final LocalFileController con = Get.put(LocalFileController());
  TextEditingController textEditingController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  ShowDocument({Key? key, this.senderId, this.receiverId, this.type, this.file})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('RECEVER ID: $receiverId');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text('DOCUMENT'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Center(
              child: Container(
                  child: Type != null && file != null
                      ? Image.file(file!,fit: BoxFit.cover,):SizedBox(child: Center(child: CircularProgressIndicator(),),)
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
                    uploadImgFirebaseStorage(
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

  uploadImgFirebaseStorage({File? file, String? msg}) async {
    var snapshot = await kFirebaseStorage
        .ref()
        .child('ChatImage/${DateTime.now().microsecondsSinceEpoch}')
        .putFile(file!);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    print('url=$downloadUrl');
    // print('path=$fileImageArray');
    chatCollection.doc(chatId(_auth.currentUser!.uid, 'payal')).collection('Data').add({
      'date': DateTime.now(),
      'Type': 'Image',
      'senderId': _auth.currentUser!.uid,
      'receiveId': 'payal',
      'seen': false,
      'msg': msg,
      'text': true,
      'image': downloadUrl,
      // 'image': type == 'image' ? downloadUrl : '',
    }).then((value) {
      print('successfully added in firebase');
      con.clearImage();
    }).catchError((e) => print('upload error'));
  }
}

