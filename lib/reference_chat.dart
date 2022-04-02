// import 'dart:developer';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:chewie/chewie.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:flutter/widgets.dart';
//
// import 'package:image_picker/image_picker.dart';
// import 'package:multi_image_picker2/multi_image_picker2.dart';
// import 'package:octo_image/octo_image.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:pipes_online/buyer/app_constant/app_colors.dart';
// import 'package:pipes_online/buyer/controller/image.dart';
// import 'package:pipes_online/buyer/controller/chat_local_file_controller.dart';
// import 'package:pipes_online/reerence_chat_msgData.dart';
// import 'package:sizer/sizer.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:video_player/video_player.dart';
//
// import 'buyer/custom_widget/widgets/custom_widget/custom_text.dart';
//
// final FirebaseStorage kFirebaseStorage = FirebaseStorage.instance;
// final FirebaseFirestore kFireStore = FirebaseFirestore.instance;
//
// CollectionReference chatCollection = kFireStore.collection('chatMsg');
//
//
// class NewChatScreen extends StatefulWidget {
//   NewChatScreen({
//     this.receiverId,
//     this.userImg,
//     this.userName,
//     this.file,
//   });
//
//   final String? receiverId;
//   final String? userImg;
//   final String? userName;
//   final File? file;
//
//   @override
//   State<NewChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<NewChatScreen> {
//   // final timerController = TimerController();
//   final LocalFileController con = LocalFileController();
//   List<Reference> references = [];
//   String? senderId, receiverId;
//   Duration _duration = new Duration();
//   Duration _position = new Duration();
//   VideoPlayerController? videoPlayerController;
//   VideoPlayerController? _controllerVideos;
//   TextEditingController searchController = TextEditingController();
//
//   // LocalFileController con = Get.find();
//   bool emojiShowing = false;
//   String statusText = "";
//   File? path;
//
//   // AudioPlayer? audioPlayer;
//   bool isComplete = false;
//
//   FilePickerResult? result;
//
//   // _onEmojiSelected(Emoji emoji) {
//   //   searchController
//   //     ..text += emoji.emoji
//   //     ..selection = TextSelection.fromPosition(
//   //         TextPosition(offset: searchController.text.length));
//   // }
//
//   _onBackspacePressed() {
//     searchController
//       ..text = searchController.text.characters.skipLast(1).toString()
//       ..selection = TextSelection.fromPosition(
//           TextPosition(offset: searchController.text.length));
//   }
//
//   @override
//   void initState() {
//     senderId = 's12';
//     receiverId = 'r12';
//     //admin id
//     seenOldMessage();
//     //getPdfBytes();
//     super.initState();
//     // audioPlayer = AudioPlayer();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   String chatId(String id1, String id2) {
//     print('id1 length => ${id1.length} id2 length=> ${id2.length}');
//     if (id1.compareTo(id2) > 0) {
//       return id1 + '-' + id2;
//     } else {
//       return id2 + '-' + id1;
//     }
//   }
//
//   Future<void> seenOldMessage() async {
//     QuerySnapshot data = await FirebaseFirestore.instance
//         .collection('chatMsg')
//         .doc(chatId(senderId!, receiverId!))
//         .collection('Data')
//         .where('seen', isEqualTo: false)
//         .get();
//
//     data.docs.forEach((element) {
//       if (receiverId == element.get('senderId')) {
//         FirebaseFirestore.instance
//             .collection('chatMsg')
//             .doc(chatId(senderId!, receiverId!))
//             .collection('Data')
//             .doc(element.id)
//             .update({'seen': true});
//       }
//     });
//   }
//
//   UploadTask? task;
//   File? file;
//
//   @override
//   Widget build(BuildContext context) {
//
//     return WillPopScope(
//       onWillPop: () {
//         return Future.value(false);
//       },
//       child: Scaffold(
//           appBar: AppBar(
//             title: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Stack(
//                       children: [
//                         Container(
//                           height: 40.sp,
//                           width: 40.sp,
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(50)),
//                           child: ClipRRect(
//                             borderRadius: BorderRadius.circular(50),
//                             child: Image.network(
//                               widget.userImg!,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           right: 0,
//                           child: Container(
//                             width: 10.sp,
//                             height: 10.sp,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(50),
//                               color: Colors.green,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(width: Get.width * 0.03),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         CustomText(
//                           alignment: Alignment.center,
//                           text: '${widget.userName}',
//                           fontWeight: FontWeight.w500,
//                           fontSize: 22,
//                           color: AppColors.commonWhiteTextColor,
//                         ),
//                         CustomText(
//                           alignment: Alignment.center,
//                           text: 'Online',
//                           fontWeight: FontWeight.w400,
//                           fontSize: 18,
//                           color: Colors.green,
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 Container(
//                   width: 35.sp,
//                   height: 35.sp,
//                   // padding: EdgeInsets,
//                   decoration: BoxDecoration(
//                     color: AppColors.commonWhiteTextColor,
//                     borderRadius: BorderRadius.circular(8.sp),
//                     border:
//                     Border.all(color: AppColors.hintTextColor, width: 2.sp),
//                   ),
//                   child: TextButton(
//                       onPressed: () {
//                         print('click...');
//                         launch('tel:1234567892');
//                       },
//                       child: Icon(
//                         Icons.call,
//                         color: AppColors.secondaryBlackColor,
//                       )),
//                 )
//               ],
//             ),
//             backgroundColor: AppColors.primaryColor,
//             toolbarHeight: Get.height * 0.1,
//             leading: IconButton(onPressed: () {
//               Get.back();
//             }, icon: Icon(Icons.arrow_back)),
//             shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.vertical(
//                 bottom: Radius.circular(25),
//               ),
//             ),
//           ),
//         body: _chatScreen(),
//       ),
//     );
//   }
//
//
//   SizedBox _chatScreen() {
//     return SizedBox(
//       height: Get.height,
//       width: Get.width,
//       child: Column(
//         children: [
//           Container(
//             height: 300,
//             width: 400,
//             child: SingleChildScrollView(
//               reverse: true,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   _chatField(),
//                   _localFileImage(),
//                 ],
//               ),
//             ),
//           ),
//           Align(alignment: Alignment.bottomCenter, child: _bottomBar()),
//         ],
//       ),
//     );
//   }
//
//   Widget _localFileImage() {
//     return GetBuilder<LocalFileController>(
//         builder: (LocalFileController contr) {
//       print('list:${contr.fileImageArray.value}');
//       return contr.fileImageArray.value.isEmpty
//           ? SizedBox()
//           : Align(
//               alignment: Alignment.centerRight,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisSize: MainAxisSize.min,
//                 children: contr.fileImageArray.value
//                     .map((e) => Container(
//                           height: 200,
//                           width: 200,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           margin: EdgeInsets.only(right: 10, top: 10),
//                           child: Stack(
//                             fit: StackFit.expand,
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(5),
//                                 child: Image(
//                                   image: FileImage(e),
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                               Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5),
//                                   color: Colors.black26,
//                                 ),
//                                 child: Center(
//                                   child: CircularProgressIndicator(),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ))
//                     .toList(),
//               ),
//             );
//     });
//   }
//
//   StreamBuilder<QuerySnapshot> _chatField() {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('chatMsg')
//           .doc(chatId(senderId!, receiverId!))
//           .collection('Data')
//           .orderBy('date', descending: true)
//           .snapshots(),
//       builder: (context, snapShot) {
//         if (!snapShot.hasData) {
//           return Container(
//             child: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         }
//         return snapShot.data!.docs.length > 0 ? _chatMsg(snapShot) : SizedBox();
//       },
//     );
//   }
//
//   Widget _chatMsg(AsyncSnapshot<QuerySnapshot> snapShot) {
//     return ListView.builder(
//         //reverse: true,
//         padding: EdgeInsets.only(top: 20),
//         shrinkWrap: true,
//         physics: NeverScrollableScrollPhysics(),
//         itemCount: snapShot.data!.docs.length,
//         itemBuilder: (context, index) {
//           return snapShot.data!.docs[index]['type'] == 'msg'
//               ? Padding(
//                   padding: const EdgeInsets.only(bottom: 8),
//                   child: snapShot.data!.docs[index]['senderId'] == senderId
//                       ? Align(
//                           alignment: Alignment.centerRight,
//                           child: Padding(
//                             padding: EdgeInsets.only(
//                                 left: Get.width / 5, right: 5, top: 5),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Flexible(
//                                   child: Card(
//                                     margin: EdgeInsets.zero,
//                                     color: Colors.blue.withOpacity(0.7),
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.only(
//                                             topLeft: Radius.circular(15),
//                                             topRight: Radius.circular(15),
//                                             bottomLeft: Radius.circular(15))),
//                                     elevation: 1,
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.end,
//                                       children: [
//                                         Flexible(
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Text(
//                                               "${snapShot.data!.docs[index]['msg']}",
//                                               style: TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.w400,
//                                                 color: Colors.white,
//                                                 fontFamily: 'Poppins',
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.only(
//                                               right: 10, bottom: 5),
//                                           child: MsgDate(
//                                             date: (snapShot.data!.docs[index]
//                                                     ['date'] as Timestamp)
//                                                 .toDate(),
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 12,
//                                 ),
//                                 Container(
//                                   width: 35,
//                                   height: 35,
//                                   decoration: BoxDecoration(
//                                       border: Border.all(color: Colors.black),
//                                       shape: BoxShape.circle,
//                                       image: DecorationImage(
//                                           image: NetworkImage(
//                                               'https://www.whatsappprofiledpimages.com/wp-content/uploads/2021/08/Profile-Photo-Wallpaper.jpg'),
//                                           fit: BoxFit.cover)),
//                                 ),
//                                 /*  PreferenceManager.getCustomerPImg() == null ||
//                                         PreferenceManager.getCustomerPImg() ==
//                                             ''
//                                     ? imageNotFound()
//                                     : ClipOval(
//                                         child: commonProfileOctoImage(
//                                           image: PreferenceManager
//                                               .getCustomerPImg(),
//                                           height: Get.height * 0.05,
//                                           width: Get.height * 0.05,
//                                         ),
//                                       ),*/
//                               ],
//                             ),
//                           ),
//                         )
//                       : Align(
//                           alignment: Alignment.centerLeft,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 10),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 widget.userImg == null || widget.userImg == ''
//                                     ? imageNotFound()
//                                     : ClipOval(
//                                         child: commonProfileOctoImage(
//                                           image: widget.userImg,
//                                           height: Get.height * 0.05,
//                                           width: Get.height * 0.05,
//                                         ),
//                                       ),
//                                 Flexible(
//                                   child: Padding(
//                                     padding:
//                                         EdgeInsets.only(right: Get.width / 5),
//                                     child: Card(
//                                       color: Colors.grey[200],
//                                       shape: RoundedRectangleBorder(
//                                         borderRadius: BorderRadius.only(
//                                             topRight: Radius.circular(15),
//                                             bottomRight: Radius.circular(15),
//                                             bottomLeft: Radius.circular(15)),
//                                       ),
//                                       elevation: 1,
//                                       child: Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Row(
//                                           mainAxisSize: MainAxisSize.min,
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.end,
//                                           children: [
//                                             Flexible(
//                                               child: Text(
//                                                 snapShot.data!.docs[index]
//                                                     ['msg'],
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.w400,
//                                                   color: Colors.black,
//                                                   fontFamily: 'Poppins',
//                                                 ),
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               width: 10,
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   top: 10),
//                                               child: MsgDate(
//                                                 date: (snapShot
//                                                             .data!.docs[index]
//                                                         ['date'] as Timestamp)
//                                                     .toDate(),
//                                               ),
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                 )
//               : snapShot.data!.docs[index]['type'] == 'image'
//                   ? snapShot.data!.docs[index]['senderId'] == senderId
//                       ? snapShot.data!.docs[index]['msg'] != ''
//                           ? Row(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Container(
//                                         height: Get.height * 0.34,
//                                         width: Get.width * 0.53,
//                                         decoration: BoxDecoration(
//                                             color: Colors.blue.withOpacity(0.7),
//                                             borderRadius:
//                                                 BorderRadius.circular(10)),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.end,
//                                           children: [
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   bottom: 5, top: 8),
//                                               child: Center(
//                                                 child: InkWell(
//                                                   // onTap: () {
//                                                   //   Get.to(ZoomImage(
//                                                   //     img: snapShot.data!
//                                                   //         .docs[index]['image'],
//                                                   //   ));
//                                                   // },
//                                                   child: ClipRRect(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             5),
//                                                     child: OctoImage(
//                                                       image:
//                                                           CachedNetworkImageProvider(
//                                                               snapShot.data!
//                                                                           .docs[
//                                                                       index]
//                                                                   ['image']),
//                                                       placeholderBuilder:
//                                                           OctoPlaceholder
//                                                               .blurHash(
//                                                         'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
//                                                       ),
//                                                       errorBuilder:
//                                                           OctoError.icon(
//                                                               color:
//                                                                   Colors.red),
//                                                       height: 200,
//                                                       width: 200,
//                                                       fit: BoxFit.cover,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding:
//                                                   const EdgeInsets.all(8.0),
//                                               child: Text(
//                                                 "${snapShot.data!.docs[index]['msg']}",
//                                                 style: TextStyle(
//                                                   fontSize: 16,
//                                                   fontWeight: FontWeight.w400,
//                                                   color: Colors.white,
//                                                   fontFamily: 'Poppins',
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(right: 10),
//                                       child: MsgDate(
//                                         date: (snapShot.data!.docs[index]
//                                                 ['date'] as Timestamp)
//                                             .toDate(),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Column(
//                                   children: [
//                                     Container(
//                                       width: 35,
//                                       height: 35,
//                                       decoration: BoxDecoration(
//                                           border: Border.all(
//                                               color: AppColors.primaryColor),
//                                           shape: BoxShape.circle,
//                                           image: DecorationImage(
//                                               image: NetworkImage(
//                                                   'https://www.whatsappprofiledpimages.com/wp-content/uploads/2021/08/Profile-Photo-Wallpaper.jpg'),
//                                               fit: BoxFit.cover)),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   width: 5,
//                                 ),
//                                 /* PreferenceManager.getCustomerPImg() == null ||
//                 PreferenceManager.getCustomerPImg() == ''
//                 ? imageNotFound()
//                 : ClipOval(
//               child: commonProfileOctoImage(
//                 image:
//                 PreferenceManager.getCustomerPImg(),
//                 height: Get.height * 0.05,
//                 width: Get.height * 0.05,
//               ),
//             ),*/
//                               ],
//                             )
//                           : Row(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Container(
//                                         height: Get.height * 0.27,
//                                         width: Get.width * 0.53,
//                                         decoration: BoxDecoration(
//                                             color: Colors.blue.withOpacity(0.7),
//                                             borderRadius:
//                                                 BorderRadius.circular(10)),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.end,
//                                           children: [
//                                             Padding(
//                                               padding: const EdgeInsets.only(
//                                                   bottom: 5, top: 5),
//                                               child: Center(
//                                                 child: InkWell(
//                                                   // onTap: () {
//                                                   //   Get.to(ZoomImage(
//                                                   //     img: snapShot.data!
//                                                   //         .docs[index]['image'],
//                                                   //   ));
//                                                   // },
//                                                   child: ClipRRect(
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             5),
//                                                     child: OctoImage(
//                                                       image:
//                                                           CachedNetworkImageProvider(
//                                                               snapShot.data!
//                                                                           .docs[
//                                                                       index]
//                                                                   ['image']),
//                                                       placeholderBuilder:
//                                                           OctoPlaceholder
//                                                               .blurHash(
//                                                         'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
//                                                       ),
//                                                       errorBuilder:
//                                                           OctoError.icon(
//                                                               color:
//                                                                   Colors.red),
//                                                       height:
//                                                           Get.height * 0.255,
//                                                       width: Get.width * 0.5,
//                                                       fit: BoxFit.cover,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(right: 10),
//                                       child: MsgDate(
//                                         date: (snapShot.data!.docs[index]
//                                                 ['date'] as Timestamp)
//                                             .toDate(),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Column(
//                                   children: [
//                                     Container(
//                                       width: 35,
//                                       height: 35,
//                                       decoration: BoxDecoration(
//                                           border:
//                                               Border.all(color: Colors.black),
//                                           shape: BoxShape.circle,
//                                           image: DecorationImage(
//                                               image: NetworkImage(
//                                                   'https://www.whatsappprofiledpimages.com/wp-content/uploads/2021/08/Profile-Photo-Wallpaper.jpg'),
//                                               fit: BoxFit.cover)),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   width: 5,
//                                 ),
//                                 /* PreferenceManager.getCustomerPImg() == null ||
//                 PreferenceManager.getCustomerPImg() == ''
//                 ? imageNotFound()
//                 : ClipOval(
//               child: commonProfileOctoImage(
//                 image:
//                 PreferenceManager.getCustomerPImg(),
//                 height: Get.height * 0.05,
//                 width: Get.height * 0.05,
//               ),
//             ),*/
//                               ],
//                             )
//                       : Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             widget.userImg == null || widget.userImg == ''
//                                 ? imageNotFound()
//                                 : ClipOval(
//                                     child: commonProfileOctoImage(
//                                       image: widget.userImg,
//                                       height: Get.height * 0.05,
//                                       width: Get.height * 0.05,
//                                     ),
//                                   ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 10, top: 10),
//                               child: Column(
//                                 children: (snapShot.data!.docs[index]['image']
//                                         as List)
//                                     .map(
//                                       (e) => Padding(
//                                         padding:
//                                             const EdgeInsets.only(bottom: 5),
//                                         child: ClipRRect(
//                                           borderRadius:
//                                               BorderRadius.circular(5),
//                                           child: InkWell(
//                                             onTap: () {
//                                               // Get.to(ZoomImage(
//                                               //   img: e,
//                                               // ));
//                                             },
//                                             child: OctoImage(
//                                               image: CachedNetworkImageProvider(
//                                                   '$e'),
//                                               placeholderBuilder:
//                                                   OctoPlaceholder.blurHash(
//                                                 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
//                                               ),
//                                               errorBuilder: OctoError.icon(
//                                                   color: Colors.red),
//                                               height: 200,
//                                               width: 200,
//                                               fit: BoxFit.cover,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     )
//                                     .toList(),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 10),
//                               child: MsgDate(
//                                 date: (snapShot.data!.docs[index]['date']
//                                         as Timestamp)
//                                     .toDate(),
//                               ),
//                             )
//                           ],
//                         )
//
//                               : SizedBox();
//         });
//   }
//
//   Widget _bottomBar() {
//     return Column(
//       children: [
//         Padding(
//           padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
//           child: Row(
//             children: [
//               InkWell(
//                 onTap: () {
//                   uploadMultiImage();
//                 },
//                 child: Icon(
//                   Icons.image,
//                   color: Colors.red,
//                 ),
//               ),
//
//               Expanded(
//                 child: Container(
//                   padding: EdgeInsets.symmetric(),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(40),
//                     border: Border.all(color: const Color(0xFFD1D1D1)),
//                   ),
//                   child: Row(
//                     children: [
//                       //SizedBox(width: kDefaultPadding / 4),
//                       Expanded(
//                         child: TextField(
//                           controller: searchController,
//                           decoration: InputDecoration(
//                             hintText: "Write your message...",
//                             border: InputBorder.none,
//                             hintStyle: TextStyle(
//                               color: Color(0xFFA2A2A2),
//                               fontWeight: FontWeight.w400,
//                               fontSize: 13.0,
//                             ),
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: addTextData,
//                         child: Text(
//                           'SEND',
//                           style: TextStyle(
//                             fontSize: 13,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
//
//
//
//   addTextData() {
//     if (searchController.text.isEmpty) {
//       log('Please first write message..');
//     } else {
//       FirebaseFirestore.instance
//           .collection('chatMsg')
//           .doc(chatId(senderId!, receiverId!))
//           .collection('Data')
//           .add({
//             'date': DateTime.now(),
//             'text': true,
//             'senderId': senderId,
//             'receiveId': receiverId,
//             'seen': false,
//             'msg': searchController.text,
//             'image': '',
//             'type': 'msg',
//           })
//           .then((value) => searchController.clear())
//           .catchError((e) => print(e));
//     }
//   }
//
//
//
//
//
//
//
//
//
//
//
//
//   Future uploadMultiImage() async {
//     try {
//       final resultList = await MultiImagePicker.pickImages(
//         maxImages: 5,
//         enableCamera: true,
//         cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
//         materialOptions: MaterialOptions(
//           actionBarColor: "#abcdef",
//           actionBarTitle: "Example App",
//           allViewTitle: "All Photos",
//           useDetailsView: false,
//           selectCircleStrokeColor: "#000000",
//         ),
//       );
//
//       print('result ${resultList}');
//       if (resultList.isNotEmpty) {
//         resultList.forEach((imageAsset) async {
//           final filePath =
//               await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier!);
//
//           File tempFile = File(filePath!);
//           if (tempFile.existsSync()) {
//             con.addFileImageArray(tempFile);
//           }
//
//           await uploadImgFirebaseStorage(file: tempFile);
//           print('success');
//         });
//       }
//     } on Exception catch (e) {
//       print('error $e');
//     }
//   }
//
//   uploadImgFirebaseStorage({File? file}) async {
//     var snapshot = await kFirebaseStorage
//         .ref()
//         .child('ChatImage/${DateTime.now().microsecondsSinceEpoch}')
//         .putFile(file!);
//     String downloadUrl = await snapshot.ref.getDownloadURL();
//     print('url=$downloadUrl');
//     // print('path=$fileImageArray');
//     chatCollection.doc(chatId(senderId!, receiverId!)).collection('Data').add({
//       'date': DateTime.now(),
//       'text': false,
//       'senderId': senderId,
//       'receiveId': receiverId,
//       'seen': false,
//       'msg': '',
//       'image': downloadUrl,
//       'type': 'image',
//     }).then((value) {
//       print('success add');
//       con.clearImage();
//     }).catchError((e) => print('upload error'));
//   }
// }
//
// class FlutterAbsolutePath {
//   static const MethodChannel _channel =
//       const MethodChannel('flutter_absolute_path');
//
//   /// Gets absolute path of the file from android URI or iOS PHAsset identifier
//   /// The return of this method can be used directly with flutter [File] class
//   static Future<String?> getAbsolutePath(String uri) async {
//     final Map<String, dynamic> params = <String, dynamic>{
//       'uri': uri,
//     };
//     final String? path = await _channel.invokeMethod('getAbsolutePath', params);
//     return path;
//   }
// }
//
