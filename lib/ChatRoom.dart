// // ignore_for_file: prefer_const_constructors
//
// import 'dart:developer';
// import 'dart:io';
// import 'dart:async';
// // import 'package:chewie/chewie.dart';
// import 'package:chewie/chewie.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/services.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:multi_image_picker2/multi_image_picker2.dart';
// import 'package:octo_image/octo_image.dart';
// // import 'package:video_player/video_player.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:pipes_online/buyer/app_constant/app_colors.dart';
// import 'package:pipes_online/convert_date_formate_chat.dart';
// import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
// import 'package:sizer/sizer.dart';
// import 'package:video_player/video_player.dart';
//
// import 'buyer/controller/chat_local_file_controller.dart';
//
// final FirebaseStorage kFirebaseStorage = FirebaseStorage.instance;
// final FirebaseFirestore kFireStore = FirebaseFirestore.instance;
//
// CollectionReference chatCollection = kFireStore.collection('Chat');
//
// class ChatRoom extends StatefulWidget {
//   final String? receiverId;
//   final String? userName;
//   final String? userImg;
//   // final String? email;
//   // final String? fcmToken;
//
//   const ChatRoom({this.receiverId, this.userName, this.userImg});
//   @override
//   State<ChatRoom> createState() => _ChatRoomState();
// }
//
// class _ChatRoomState extends State<ChatRoom> {
//   String statusText = "";
//   bool isComplete = false;
//   String? recordFilePath;
//   FilePickerResult? result;
//   String? documentName;
//   // VoiceCallScreenController _voiceCallScreenController = Get.find();
//   // BottomController _bottomController = Get.find();
//   // ScheduleViewModel _scheduleViewModel = Get.find();
//
//   List<Map<String, dynamic>> iconData = [
//     {
//       'icon': Icons.camera_alt,
//       'name': 'Camera',
//     },
//     {
//       'icon': Icons.video_call,
//       'name': 'Video',
//     },
//     {
//       'icon': Icons.image,
//       'name': 'Gallery',
//     },
//     {
//       'icon': Icons.video_call,
//       'name': 'Gallery',
//     },
//     {
//       'icon': Icons.insert_drive_file_outlined,
//       'name': 'document',
//     },
//   ];
//   final TextEditingController _msg = TextEditingController();
//   LocalFileController con = Get.put(LocalFileController());
//   VideoPlayerController? _controllerVideos;
//   VideoPlayerController? videoPlayerController;
//   String chatId(String id1, String id2) {
//     print('--------id1--id1--------$id1');
//
//     print('id1 length => ${id1.length} id2 length=> ${id2.length}');
//     if (id1.compareTo(id2) > 0) {
//       return id1 + '-' + id2;
//     } else {
//       return id2 + '-' + id1;
//     }
//   }
//
//   Future<void> _handleCameraAndMic(Permission permission) async {
//     final status = await permission.request();
//     print(status);
//   }
//
//   @override
//   void initState() {
//     // videoPlayerController = VideoPlayerController.network(
//     //     'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4');
//     // // TODO: implement initState
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.commonWhiteTextColor,
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Container(
//             padding: EdgeInsets.only(bottom: 10.sp),
//             height: 100,
//             width: double.infinity,
//             color: AppColors.primaryColor,
//             child: Align(
//               alignment: Alignment.bottomLeft,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   IconButton(
//                       onPressed: () {
//                         Get.back();
//                       },
//                       icon: Icon(Icons.arrow_back)),
//                   SizedBox(
//                     width: 6,
//                   ),
//                   Container(
//                     height: 46,
//                     width: 46,
//                     child: ClipRRect(
//                         borderRadius: BorderRadius.circular(40),
//                         child: Image.network(
//                           widget.userImg!,
//                           fit: BoxFit.cover,
//                         )),
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 10,
//                   ),
//                   Text(
//                     '${widget.userName}',
//                     style: TextStyle(fontSize: 16, color: Colors.white),
//                   ),
//                   Spacer(),
//                   InkWell(
//                     onTap: () async {
//                       // _bottomController.isRingtone.value = true;
//                       // _voiceCallScreenController.setTrueVideo(
//                       //     isVideoCall: true);
//
//                       kFireStore
//                           .collection('UserAllData')
//                           .doc(PreferenceManager.getTokenId().toString())
//                           .update({
//                         "isCalling": true,
//                         "isVideoCall": false,
//                         // "caller_auth_token":
//                         //     _scheduleViewModel.userData['auth_Token']
//                       });
//                       // _voiceCallScreenController.callerAuthToken =
//                       //     _scheduleViewModel.userData['auth_Token'];
//                       await _handleCameraAndMic(Permission.camera);
//                       await _handleCameraAndMic(Permission.microphone);
//                       // AgoraTokenResponse _agoraTokenResponse =
//                       //     await AgoraTokenApiRepo.agoraTokenApiRepo();
//                       kFireStore
//                           .collection('UserAllData')
//                           .doc(chatId(
//                           PreferenceManager.getTokenId().toString(),
//                           'uorKvVoRJzOeYCMYT1vwjkrFKxz2'))
//                           // .doc(_scheduleViewModel.userData['auth_Token'])
//                           .update({
//                         "isCalling": true,
//                         "isVideoCall": false,
//                         "isCallReceived": false,
//                         // "caller_name": PreferenceManager.getFnameId(),
//                         // "agora_token": _agoraTokenResponse.tokenUId!,
//                         // "agora_channel_name": _agoraTokenResponse.channelName!,
//                         "caller_auth_token": PreferenceManager.getTokenId()
//                       });
//                       // _voiceCallScreenController.callerName =
//                       //     _scheduleViewModel.userData['name'];
//
//                       // AppNotificationHandler.sendMessage(
//                       //     isRing: true,
//                       //     receiverFcmToken:
//                       //         _scheduleViewModel.userData['fcm_token'],
//                       //     msg: 'calling ${PreferenceManager.getFnameId()}');
//                       // _scheduleViewModel.dateTimeCall = DateTime.now();
//                       // _scheduleViewModel.isCallingMe = true;
//                       // Get.to(() => VoiceCallTimeScreenWidget(
//                       //       isVideocALL: _voiceCallScreenController.isVideo,
//                       //       channelName: _agoraTokenResponse.channelName!,
//                       //       tokenId: _agoraTokenResponse.tokenUId!,
//                       //       callerAuthId:
//                       //           _scheduleViewModel.userData['auth_Token'],
//                       //     ));
//                     },
//                     child:Icon(Icons.camera_alt_outlined),
//                   ),
//                   SizedBox(width: 8.sp),
//                   InkWell(
//                     onTap: () async {
//                       // _bottomController.isRingtone.value = true;
//                       // _voiceCallScreenController.setTrueVideo(
//                       //     isVideoCall: true);
//
//                       kFireStore
//                           .collection('UserAllData')
//                           .doc(PreferenceManager.getTokenId().toString())
//                           .update({
//                         "isCalling": true,
//                         "isVideoCall": false,
//                         "caller_auth_token": widget.receiverId
//                       });
//                       // _voiceCallScreenController?.callerAuthToken = widget.uid!;
//                       await _handleCameraAndMic(Permission.camera);
//                       await _handleCameraAndMic(Permission.microphone);
//                       // AgoraTokenResponse _agoraTokenResponse =
//                       //     await AgoraTokenApiRepo.agoraTokenApiRepo();
//                       kFireStore
//                           .collection('UserAllData')
//                           .doc(widget.receiverId!)
//                           .update({
//                         "isCalling": true,
//                         "isVideoCall": false,
//                         "isCallReceived": false,
//                         // "caller_name": PreferenceManager.getFnameId(),
//                         // "agora_token": _agoraTokenResponse.tokenUId!,
//                         // "agora_channel_name": _agoraTokenResponse.channelName!,
//                         "caller_auth_token": PreferenceManager.getTokenId()
//                       });
//                       // _voiceCallScreenController.callerName =
//                       //     widget.email ?? '';
//
//                       // AppNotificationHandler.sendMessage(
//                       //     isRing: true,
//                       //     receiverFcmToken:
//                       //         _scheduleViewModel.userData['fcm_token'],
//                       //     msg: 'calling ${PreferenceManager.getFnameId()}');
//                       // _scheduleViewModel.dateTimeCall = DateTime.now();
//                       // _scheduleViewModel.isCallingMe = true;
//                       // Get.to(() => VoiceCallTimeScreenWidget(
//                       //       isVideocALL: _voiceCallScreenController.isVideo,
//                       //       channelName: _agoraTokenResponse.channelName!,
//                       //       tokenId: _agoraTokenResponse.tokenUId!,
//                       //       callerAuthId:
//                       //           _scheduleViewModel.userData['auth_Token'],
//                       //     ));
//                     },
//                     child: Icon(Icons.call),
//                   ),
//                   SizedBox(width: 8.sp),
//                   InkWell(
//                     onTap: () {},
//                     child: Icon(
//                       Icons.more_vert,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(width: 8.sp),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(width: 8.sp),
//           Expanded(
//             child: SingleChildScrollView(
//               physics: BouncingScrollPhysics(),
//               reverse: true,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   StreamBuilder<QuerySnapshot>(
//                     stream: FirebaseFirestore.instance
//                         .collection('Chat')
//                         .doc(
//                             chatId(PreferenceManager.getTokenId().toString(), widget.receiverId!))
//                         .collection('Data')
//                         .orderBy('date', descending: false)
//                         .snapshots(),
//                     builder: (context, snapShot) {
//                       if (snapShot.hasData) {
//                         return ListView.builder(
//                           shrinkWrap: true,
//                           physics: BouncingScrollPhysics(),
//                           itemCount: snapShot.data!.docs.length,
//                           itemBuilder: (context, index) {
//                             if (snapShot.data!.docs[index]['Type'] == 'Video') {
//                               print(
//                                   'firebasevideo${snapShot.data!.docs[index]['video']}');
//                             }
//                             _controllerVideos = VideoPlayerController.network(
//                                 snapShot.data!.docs[index]['video']);
//                             final chewieController = ChewieController(
//                               videoPlayerController: _controllerVideos!,
//                               aspectRatio: 3 / 2,
//                               autoPlay: false,
//                               autoInitialize: true,
//                               looping: false,
//                             );
//                             final playerWidget = Chewie(
//                               controller: chewieController,
//                             );
//                             return snapShot.data!.docs[index]['Type'] == 'Text'
//                                 ? Padding(
//                                     padding: const EdgeInsets.only(bottom: 8),
//                                     child: snapShot.data!.docs[index]
//                                                 ['senderId'] ==
//                                             PreferenceManager.getTokenId()
//                                         ? Align(
//                                             alignment: Alignment.centerRight,
//                                             child: Padding(
//                                               padding: EdgeInsets.only(
//                                                   left: Get.width / 5,
//                                                   right: 10),
//                                               child: Row(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.end,
//                                                 mainAxisSize: MainAxisSize.min,
//                                                 children: [
//                                                   Flexible(
//                                                     child: Card(
//                                                       margin: EdgeInsets.zero,
//                                                       color: Color(0xFF777794),
//                                                       shape:
//                                                           const RoundedRectangleBorder(
//                                                         borderRadius:
//                                                             BorderRadius.only(
//                                                           topLeft:
//                                                               Radius.circular(
//                                                                   15),
//                                                           bottomRight:
//                                                               Radius.circular(
//                                                                   15),
//                                                           bottomLeft:
//                                                               Radius.circular(
//                                                                   15),
//                                                         ),
//                                                       ),
//                                                       elevation: 1,
//                                                       child: Row(
//                                                         mainAxisSize:
//                                                             MainAxisSize.min,
//                                                         crossAxisAlignment:
//                                                             CrossAxisAlignment
//                                                                 .end,
//                                                         children: [
//                                                           Flexible(
//                                                             child: Padding(
//                                                               padding:
//                                                                   const EdgeInsets
//                                                                       .all(8.0),
//                                                               child: Text(
//                                                                 "${snapShot.data!.docs[index]['msg']}",
//                                                                 style:
//                                                                     TextStyle(
//                                                                   fontSize: 16,
//                                                                   fontWeight:
//                                                                       FontWeight
//                                                                           .w400,
//                                                                   color: Colors
//                                                                       .white,
//                                                                   fontFamily:
//                                                                       'Poppins',
//                                                                 ),
//                                                               ),
//                                                             ),
//                                                           ),
//                                                           // Padding(
//                                                           //   padding:
//                                                           //       const EdgeInsets.only(
//                                                           //           right: 10, bottom: 5),
//                                                           //   child: MsgDate(
//                                                           //     date: (snapShot.data!
//                                                           //                     .docs[index]
//                                                           //                 ['date']
//                                                           //             as Timestamp)
//                                                           //         .toDate(),
//                                                           //   ),
//                                                           // )
//                                                         ],
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   SizedBox(
//                                                     width: 5,
//                                                   ),
//                                                   /*    PreferenceManager.getCustomerPImg() == null ||
//                                                 PreferenceManager.getCustomerPImg() ==
//                                                     ''
//                                             ? imageNotFound()
//                                             : ClipOval(
//                                                 child: commonProfileOctoImage(
//                                                   image: PreferenceManager
//                                                       .getCustomerPImg(),
//                                                   height: Get.height * 0.05,
//                                                   width: Get.height * 0.05,
//                                                 ),
//                                               ),*/
//                                                 ],
//                                               ),
//                                             ),
//                                           )
//                                         : Align(
//                                             alignment: Alignment.centerLeft,
//                                             child: Padding(
//                                               padding: const EdgeInsets.only(
//                                                   left: 10),
//                                               child: Row(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.end,
//                                                 mainAxisSize: MainAxisSize.min,
//                                                 children: [
//                                                   Flexible(
//                                                     child: Padding(
//                                                       padding: EdgeInsets.only(
//                                                           right: Get.width / 5),
//                                                       child: Card(
//                                                         color:
//                                                             Color(0xff404040),
//                                                         shape:
//                                                             RoundedRectangleBorder(
//                                                           borderRadius: BorderRadius.only(
//                                                               topRight: Radius
//                                                                   .circular(15),
//                                                               bottomRight:
//                                                                   Radius
//                                                                       .circular(
//                                                                           15),
//                                                               bottomLeft: Radius
//                                                                   .circular(
//                                                                       15)),
//                                                         ),
//                                                         elevation: 1,
//                                                         child: Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                   .all(8.0),
//                                                           child: Row(
//                                                             mainAxisSize:
//                                                                 MainAxisSize
//                                                                     .min,
//                                                             crossAxisAlignment:
//                                                                 CrossAxisAlignment
//                                                                     .end,
//                                                             children: [
//                                                               Flexible(
//                                                                 child: Text(
//                                                                   snapShot.data!
//                                                                           .docs[
//                                                                       index]['msg'],
//                                                                   style:
//                                                                       TextStyle(
//                                                                     fontSize:
//                                                                         16,
//                                                                     fontWeight:
//                                                                         FontWeight
//                                                                             .w400,
//                                                                     color: Colors
//                                                                         .white,
//                                                                     fontFamily:
//                                                                         'Poppins',
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                               SizedBox(
//                                                                 width: 10,
//                                                               ),
//                                                               // Padding(
//                                                               //   padding:
//                                                               //       const EdgeInsets.only(
//                                                               //           top: 10),
//                                                               //   child: MsgDate(
//                                                               //     date: (snapShot.data.docs[
//                                                               //                     index]
//                                                               //                 ['date']
//                                                               //             as Timestamp)
//                                                               //         .toDate(),
//                                                               //   ),
//                                                               // )
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                   )
//                                 : snapShot.data!.docs[index]['Type'] == 'Image'
//                                     ? snapShot.data!.docs[index]['senderId'] ==
//                                             PreferenceManager.getTokenId()
//                                         ? Row(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.end,
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.end,
//                                             mainAxisSize: MainAxisSize.min,
//                                             children: [
//                                               Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.end,
//                                                 children: [
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             right: 10, top: 10),
//                                                     child: Column(
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .end,
//                                                       children:
//                                                           (snapShot.data!.docs[
//                                                                           index]
//                                                                       ['image']
//                                                                   as List)
//                                                               .map(
//                                                                 (e) => Padding(
//                                                                   padding: const EdgeInsets
//                                                                           .only(
//                                                                       bottom:
//                                                                           5),
//                                                                   child:
//                                                                       InkWell(
//                                                                     onTap: () {
//                                                                       // Get.to(ZoomImage(
//                                                                       //   img: e,
//                                                                       // ));
//                                                                     },
//                                                                     child:
//                                                                         ClipRRect(
//                                                                       borderRadius:
//                                                                           BorderRadius.circular(
//                                                                               5),
//                                                                       child:
//                                                                           OctoImage(
//                                                                         image: CachedNetworkImageProvider(
//                                                                             '$e'),
//                                                                         placeholderBuilder:
//                                                                             OctoPlaceholder.blurHash(
//                                                                           'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
//                                                                         ),
//                                                                         errorBuilder:
//                                                                             OctoError.icon(color: Colors.red),
//                                                                         height:
//                                                                             200,
//                                                                         width:
//                                                                             200,
//                                                                         fit: BoxFit
//                                                                             .cover,
//                                                                       ),
//                                                                     ),
//                                                                   ),
//                                                                 ),
//                                                               )
//                                                               .toList(),
//                                                     ),
//                                                   ),
//                                                   // Padding(
//                                                   //   padding: const EdgeInsets.only(right: 10),
//                                                   //   child: MsgDate(
//                                                   //     date: (snapShot.data.docs[index]['date']
//                                                   //             as Timestamp)
//                                                   //         .toDate(),
//                                                   //   ),
//                                                   // )
//                                                 ],
//                                               ),
//                                               SizedBox(
//                                                 width: 5,
//                                               ),
//                                               /* PreferenceManager.getCustomerPImg() == null ||
//                                         PreferenceManager.getCustomerPImg() == ''
//                                     ? imageNotFound()
//                                     : ClipOval(
//                                         child: commonProfileOctoImage(
//                                           image: PreferenceManager.getCustomerPImg(),
//                                           height: Get.height * 0.05,
//                                           width: Get.height * 0.05,
//                                         ),
//                                       ),*/
//                                             ],
//                                           )
//                                         : Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               /*   widget.userImg == null || widget.userImg == ''
//                                     ? imageNotFound()
//                                     : ClipOval(
//                                         child: commonProfileOctoImage(
//                                           image: widget.userImg,
//                                           height: Get.height * 0.05,
//                                           width: Get.height * 0.05,
//                                         ),
//                                       ),*/
//                                               Padding(
//                                                 padding: const EdgeInsets.only(
//                                                     left: 10, top: 10),
//                                                 child: Column(
//                                                   children: (snapShot
//                                                               .data!.docs[index]
//                                                           ['image'] as List)
//                                                       .map(
//                                                         (e) => Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                       .only(
//                                                                   bottom: 5),
//                                                           child: ClipRRect(
//                                                             borderRadius:
//                                                                 BorderRadius
//                                                                     .circular(
//                                                                         5),
//                                                             child: InkWell(
//                                                               onTap: () {
//                                                                 // Get.to(ZoomImage(
//                                                                 //   img: e,
//                                                                 // ));
//                                                               },
//                                                               child: OctoImage(
//                                                                 image:
//                                                                     CachedNetworkImageProvider(
//                                                                         '$e'),
//                                                                 placeholderBuilder:
//                                                                     OctoPlaceholder
//                                                                         .blurHash(
//                                                                   'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
//                                                                 ),
//                                                                 errorBuilder:
//                                                                     OctoError.icon(
//                                                                         color: Colors
//                                                                             .red),
//                                                                 height: 200,
//                                                                 width: 200,
//                                                                 fit: BoxFit
//                                                                     .cover,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       )
//                                                       .toList(),
//                                                 ),
//                                               ),
//                                               // Padding(
//                                               //   padding: const EdgeInsets.only(left: 10),
//                                               //   child: MsgDate(
//                                               //     date: (snapShot.data.docs[index]['date']
//                                               //             as Timestamp)
//                                               //         .toDate(),
//                                               //   ),
//                                               // )
//                                             ],
//                                           )
//                                     // : snapShot.data!.docs[index]['Type'] ==
//                                     //         'Video'
//                                     //     ? snapShot.data!.docs[index]
//                                     //                 ['senderId'] ==
//                                     //             PreferenceManager.getTokenId()
//                                     //         ? Row(
//                                     //             mainAxisAlignment:
//                                     //                 MainAxisAlignment.end,
//                                     //             children: [
//                                     //               Container(
//                                     //                 height: 250,
//                                     //                 width: 250,
//                                     //                 padding:
//                                     //                     EdgeInsets.symmetric(
//                                     //                   horizontal: 20,
//                                     //                 ),
//                                     //                 child: playerWidget,
//                                     //               ),
//                                     //             ],
//                                     //           )
//                                     //         : Row(
//                                     //             mainAxisAlignment:
//                                     //                 MainAxisAlignment.start,
//                                     //             children: [
//                                     //               Container(
//                                     //                 height: 250,
//                                     //                 width: 250,
//                                     //                 padding:
//                                     //                     EdgeInsets.symmetric(
//                                     //                   horizontal: 20,
//                                     //                 ),
//                                     //                 child: playerWidget,
//                                     //               ),
//                                     //             ],
//                                     //           )
//                                     : snapShot.data!.docs[index]['Type'] ==
//                                             PreferenceManager.getTokenId()
//                                         ? Padding(
//                                             padding: EdgeInsets.only(
//                                                 right: Get.width / 5),
//                                             child: Card(
//                                               color: Colors.grey[200],
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius: BorderRadius.only(
//                                                     topRight:
//                                                         Radius.circular(15),
//                                                     bottomRight:
//                                                         Radius.circular(15),
//                                                     bottomLeft:
//                                                         Radius.circular(15)),
//                                               ),
//                                               elevation: 1,
//                                               child: Padding(
//                                                 padding:
//                                                     const EdgeInsets.all(8.0),
//                                                 child: Row(
//                                                   mainAxisSize:
//                                                       MainAxisSize.min,
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.end,
//                                                   children: [
//                                                     Icon(
//                                                       Icons.description,
//                                                       color: Colors.black,
//                                                     ),
//                                                     Flexible(
//                                                       child: Text(
//                                                         snapShot.data!
//                                                                 .docs[index]
//                                                             ['documentName'],
//                                                         style: TextStyle(
//                                                           fontSize: 16,
//                                                           fontWeight:
//                                                               FontWeight.w400,
//                                                           color: Colors.black,
//                                                           fontFamily: 'Poppins',
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     SizedBox(
//                                                       width: 10,
//                                                     ),
//                                                     Padding(
//                                                       padding:
//                                                           const EdgeInsets.only(
//                                                               top: 10),
//                                                       child: MsgDate(
//                                                         date: (snapShot.data!.docs[
//                                                                         index]
//                                                                     ['date']
//                                                                 as Timestamp)
//                                                             .toDate(),
//                                                       ),
//                                                     )
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           )
//                                         : Padding(
//                                             padding: EdgeInsets.only(
//                                                 left: Get.width / 5),
//                                             child: Align(
//                                               child: Card(
//                                                 color:AppColors.primaryColor,
//                                                 shape: RoundedRectangleBorder(
//                                                   borderRadius:
//                                                       BorderRadius.only(
//                                                           topRight:
//                                                               Radius.circular(
//                                                                   15),
//                                                           bottomRight:
//                                                               Radius.circular(
//                                                                   15),
//                                                           bottomLeft:
//                                                               Radius.circular(
//                                                                   15)),
//                                                 ),
//                                                 elevation: 1,
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(8.0),
//                                                   child: Row(
//                                                     mainAxisSize:
//                                                         MainAxisSize.min,
//                                                     crossAxisAlignment:
//                                                         CrossAxisAlignment.end,
//                                                     children: [
//                                                       Icon(Icons.description),
//                                                       Flexible(
//                                                         child: Text(
//                                                           snapShot.data!
//                                                                   .docs[index]
//                                                               ['documentName'],
//                                                           style: TextStyle(
//                                                             fontSize: 16,
//                                                             fontWeight:
//                                                                 FontWeight.w400,
//                                                             color: Colors.white,
//                                                             fontFamily:
//                                                                 'Poppins',
//                                                           ),
//                                                         ),
//                                                       ),
//                                                       SizedBox(
//                                                         width: 10,
//                                                       ),
//                                                       Padding(
//                                                         padding:
//                                                             const EdgeInsets.only(
//                                                                 top: 10),
//                                                         child: MsgDate(
//                                                           date: (snapShot.data!.docs[
//                                                                           index]
//                                                                       ['date']
//                                                                   as Timestamp)
//                                                               .toDate(),
//                                                         ),
//                                                       )
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           );
//                             // : SfPdfViewer.network(
//                             //     'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf',
//                             //   );
//                           },
//                         );
//                       }
//                       return Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             height: 55,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                       child: SizedBox(
//                           height: 50,
//                           child: TextFormField(
//                             cursorColor: Colors.white,
//                             controller: _msg,
//                             style: TextStyle(color: Colors.white),
//                             decoration: InputDecoration(
//                               prefixIcon: Icon(Icons.emoji_emotions),
//                               suffixIcon: InkWell(
//                                 onTap: () {
//                                   print('it camara');
//                                   performTask();
//                                 },
//                                 child: Icon(Icons.image),
//                               ),
//                               fillColor: AppColors.backGroudColor,
//                               filled: true,
//                               hintText: 'Message',
//                               hintStyle: TextStyle(color: Colors.white),
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(40),
//                                   borderSide: BorderSide.none),
//                               contentPadding:
//                                   EdgeInsets.symmetric(horizontal: 15),
//                             ),
//                           ))),
//                   // GestureDetector(
//                   //   onTap: () {
//                   //     print('on tap');
//                   //   },
//                   //   onLongPressStart: (_) async {
//                   //     print('on long tap');
//                   //     // startRecord();
//                   //   },
//                   //   // onLongPressCancel: () {
//                   //   //   cancelPress();
//                   //   // },
//                   //   onLongPressEnd: (_) {
//                   //     // stopRecord();
//                   //
//                   //     print('on long end');
//                   //   },
//                   //   child: Icon(
//                   //     Icons.mic,
//                   //     color: Colors.grey.shade400,
//                   //     size: 30,
//                   //   ),
//                   // ),
//                   // InkWell(
//                   //   onTap: () {
//                   //     showModalBottomSheet(
//                   //       shape: RoundedRectangleBorder(
//                   //           borderRadius: BorderRadius.only(
//                   //         topLeft: Radius.circular(30),
//                   //         topRight: Radius.circular(30),
//                   //       )),
//                   //       context: context,
//                   //       builder: (context) {
//                   //         return Container(
//                   //           height: 350,
//                   //           decoration: BoxDecoration(
//                   //             borderRadius: BorderRadius.only(
//                   //               topLeft: Radius.circular(30),
//                   //               topRight: Radius.circular(30),
//                   //             ),
//                   //           ),
//                   //           child: GridView.builder(
//                   //             padding: EdgeInsets.symmetric(
//                   //                 vertical: 20, horizontal: 25),
//                   //             gridDelegate:
//                   //                 SliverGridDelegateWithFixedCrossAxisCount(
//                   //               crossAxisCount: 4,
//                   //               mainAxisSpacing: 15,
//                   //               crossAxisSpacing: 15,
//                   //               childAspectRatio: 1,
//                   //             ),
//                   //             itemCount: iconData.length,
//                   //             itemBuilder: (context, index) {
//                   //               return GestureDetector(
//                   //                 onTap: () async {
//                   //                   performTask(index);
//                   //                   Get.back();
//                   //                 },
//                   //                 child: Column(
//                   //                   children: [
//                   //                     Icon(
//                   //                       iconData[index]['icon'],
//                   //                       size: 30,
//                   //                       color: Colors.grey,
//                   //                     ),
//                   //                     SizedBox(
//                   //                       height: 10,
//                   //                     ),
//                   //                     Text('${iconData[index]['name']}')
//                   //                   ],
//                   //                 ),
//                   //               );
//                   //             },
//                   //           ),
//                   //         );
//                   //       },
//                   //     );
//                   //   },
//                   //   child: Icon(
//                   //     Icons.attachment_rounded,
//                   //     color: Colors.grey.shade400,
//                   //     size: 30,
//                   //   ),
//                   // ),
//                   // SizedBox(width: 10),
//                   InkWell(
//                     onTap: () {
//                       // AppNotificationHandler.sendMessage(
//                       //     msg: _msg.text, receiverFcmToken: widget.fcmToken);
//                       addMsg();
//                     },
//                     child: Padding(
//                       padding: EdgeInsets.only(left: 3),
//                       child: Container(
//                         height: 30.sp,
//                         width: 30.sp,
//                         child: Padding(
//                           padding: const EdgeInsets.all(4.0),
//                           child:
//                               SvgPicture.asset('assets/svg/send_mesaage_i.svg'),
//                         ),
//                         decoration: BoxDecoration(
//                             color: AppColors.offWhiteColor,
//                             shape: BoxShape.circle),
//                       ),
//                     ),
//                   ),
//                     InkWell(
//                     onTap: () {
//                       addMsg();
//                     },
//                     child: const Icon(
//                       Icons.send_rounded,
//                       color: Colors.black,
//                       size: 30,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Future uploadMultiImage() async {
//     try {
//       final resultList = await MultiImagePicker.pickImages(
//         maxImages: 5,
//         enableCamera: true,
//         cupertinoOptions: const CupertinoOptions(takePhotoIcon: "chat"),
//         materialOptions: const MaterialOptions(
//           actionBarColor: "#abcdef",
//           actionBarTitle: "Example App",
//           allViewTitle: "All Photos",
//           useDetailsView: false,
//           selectCircleStrokeColor: "#000000",
//         ),
//       );
//       print('result ${resultList}');
//       if (resultList.isNotEmpty) {
//         resultList.forEach((imageAsset) async {
//           final filePath =
//               await FlutterAbsolutePath.getAbsolutePath(imageAsset.identifier!);
//
//           File tempFile = File(filePath);
//           if (tempFile.existsSync()) {
//             con.addFileImageArray(tempFile);
//           }
//           await uploadImgFirebaseStorage(file: tempFile);
//           print('success');
//         });
//       }
//     } on Exception catch (e) {
//       print('error $e');
//     }
//   }
//
//   Future<void> addMsg() async {
//     if (_msg.text.isEmpty) {
//       log('Please first write meaage..');
//       print('------widget.uid----   ${widget.receiverId}');
//     } else {
//       FirebaseFirestore.instance
//           .collection('Chat')
//           .doc(chatId(PreferenceManager.getTokenId().toString(), widget.receiverId!))
//           .collection('Data')
//           .add({
//             'date': DateTime.now(),
//             'Type': 'Text',
//             'senderId': PreferenceManager.getTokenId(),
//             'receiveId': widget.receiverId,
//             'seen': false,
//             'video': '',
//             'msg': _msg.text,
//             'image': '',
//             'document': '',
//             'voiceNote': ''
//           })
//           .then((value) => _msg.clear())
//           .catchError((e) => print(e));
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
//     print('====chatroom=  ${PreferenceManager.getTokenId()}-${widget.receiverId}');
//     // print('path=$fileImageArray');
//     FirebaseFirestore.instance
//         .collection('Chat')
//         .doc(chatId(PreferenceManager.getTokenId().toString(), widget.receiverId!))
//         .collection('Data')
//         .add({
//       'date': DateTime.now(),
//       'Type': 'Image',
//       'senderId': PreferenceManager.getTokenId(),
//       'receiveId': widget.receiverId,
//       'seen': false,
//       'msg': '',
//       'video': '',
//       'image': [downloadUrl],
//       'document': '',
//       'voiceNote': ''
//     }).then((value) {
//       print('success add');
//       con.clearImage();
//     }).catchError((e) => print('upload error'));
//   }
//
//   // uploadVoiceNoteFirebaseStorage({File? file}) async {
//   //   var snapshot = await kFirebaseStorage
//   //       .ref()
//   //       .child('voiceNote/${DateTime.now().microsecondsSinceEpoch}')
//   //       .putFile(file!);
//   //   String downloadUrl = await snapshot.ref.getDownloadURL();
//   //   print('voiceNote==url=$downloadUrl');
//   //   // print('path=$fileImageArray');
//   //   chatCollection
//   //       .doc(chatId(PreferenceManager.getTokenId(), widget.uid!))
//   //       .collection('Data')
//   //       .add({
//   //     'date': DateTime.now(),
//   //     'Type': 'Image',
//   //     'senderId': PreferenceManager.getTokenId(),
//   //     'receiveId': widget.uid,
//   //     'seen': false,
//   //     'msg': '',
//   //     'video': '',
//   //     'image': [downloadUrl],
//   //     'document': '',
//   //     'voiceNote': ''
//   //   }).then((value) {
//   //     print('success add');
//   //     con.clearImage();
//   //   }).catchError((e) => print('upload error'));
//   // }
//   //
//   uploadDocumentFirebaseStorage({File? file}) async {
//     var snapshot = await kFirebaseStorage
//         .ref()
//         .child('document/${DateTime.now().microsecondsSinceEpoch}')
//         .putFile(file!);
//     String downloadUrl = await snapshot.ref.getDownloadURL();
//     print('url=$downloadUrl');
//     // print('path=$fileImageArray');
//     chatCollection
//         .doc(chatId(PreferenceManager.getTokenId().toString(), widget.receiverId!))
//         .collection('Data')
//         .add({
//       'date': DateTime.now(),
//       'Type': 'Document',
//       'senderId': PreferenceManager.getTokenId(),
//       'receiveId': widget.receiverId,
//       'seen': false,
//       'msg': '',
//       'video': '',
//       'documentName': documentName,
//       'image': '',
//       'document': downloadUrl,
//       'voiceNote': ''
//     }).then((value) {
//       print('success add');
//       con.clearImage();
//     }).catchError((e) => print('upload error'));
//   }
//   //
//   // uploadVideoFirebaseStorage({File? file}) async {
//   //   var snapshot = await kFirebaseStorage
//   //       .ref()
//   //       .child('chatVideo/${DateTime.now().microsecondsSinceEpoch}')
//   //       .putFile(file!);
//   //   String downloadUrl = await snapshot.ref.getDownloadURL();
//   //   print('url=$downloadUrl');
//   //   // print('path=$fileImageArray');
//   //   chatCollection
//   //       .doc(chatId(PreferenceManager.getTokenId(), widget.uid!))
//   //       .collection('Data')
//   //       .add({
//   //     'date': DateTime.now(),
//   //     'Type': 'Video',
//   //     'senderId': PreferenceManager.getTokenId(),
//   //     'receiveId': widget.uid,
//   //     'seen': false,
//   //     'msg': '',
//   //     'image': '',
//   //     'video': downloadUrl,
//   //     'document': '',
//   //     'voiceNote': ''
//   //   }).then((value) {
//   //     print('success add');
//   //     con.clearImage();
//   //   }).catchError((e) => print('upload error'));
//   // }
//
//   // _pickVideoFromCamera() async {
//   //   ImagePicker videoPicker = ImagePicker();
//   //   File file = await ImagePicker.pickVideo(source: ImageSource.camera);
//   //   if (file != null) {
//   //     con.addFileImageArray(File(file.path));
//   //     uploadVideoFirebaseStorage(file: File(file.path));
//   //   }
//   // }
//
//   // _pickVideoFromGallery() async {
//   //   ImagePicker videoPicker = ImagePicker();
//   //   File file = await ImagePicker.pickVideo(source: ImageSource.gallery);
//   //   if (file != null) {
//   //     con.addFileImageArray(File(file.path));
//   //     uploadVideoFirebaseStorage(file: File(file.path));
//   //   }
//   // }
//
//   int i = 0;
//
//   Future<void> performTask() async {
//     //print('-----doc index------$index');
//     // if (index == 0) {
//     //final picker = ImagePicker();
//
//     // var imaGe =
//     //     await picker.getImage(source: ImageSource.camera, imageQuality: 80);
//
//     //  setState(() {
//
//     // });
//
//     final imagePicker = ImagePicker();
//
//     var file = await imagePicker.getImage(
//         source: ImageSource.camera, imageQuality: 80);
//     if (file != null) {
//       con.addFileImageArray(File(file.path));
//       uploadImgFirebaseStorage(file: File(file.path));
//     }
//     //  }
//     //else if (index == 1) {
//     //   _pickVideoFromCamera();
//     // } else if (index == 2) {
//     // final imagePicker = ImagePicker();
//     // var file = await imagePicker.getImage(source: ImageSource.gallery);
//     // if (file != null) {
//     //   con.addFileImageArray(File(file.path));
//     //   uploadImgFirebaseStorage(file: File(file.path));
//     // }
//     //  } else if (index == 3) {
//     //_pickVideoFromGallery();
//     //  } else if (index == 4) {
//     // await pickFileMob();
//     //
//     // uploadDocumentFirebaseStorage(file: File(result.paths.first));
//     // }
//   }
//
//   Future<String> getFilePath() async {
//     Directory storageDirectory = await getApplicationDocumentsDirectory();
//     String sdPath = storageDirectory.path + "/record";
//     var d = Directory(sdPath);
//     if (!d.existsSync()) {
//       d.createSync(recursive: true);
//     }
//     return sdPath + "/test_${i++}.mp3";
//   }
//
//   Future<bool> checkPermission() async {
//     if (!await Permission.microphone.isGranted) {
//       PermissionStatus status = await Permission.microphone.request();
//       if (status != PermissionStatus.granted) {
//         return false;
//       }
//     }
//     return true;
//   }
//
//   // void startRecord() async {
//   //   bool hasPermission = await checkPermission();
//   //   if (hasPermission) {
//   //     statusText = "Recording...";
//   //     recordFilePath = await getFilePath();
//   //     isComplete = false;
//   //     RecordMp3.instance.start(recordFilePath, (type) {
//   //       statusText = "Record error--->$type";
//   //       setState(() {});
//   //     });
//   //   } else {
//   //     statusText = "No microphone permission";
//   //   }
//   //   setState(() {});
//   // }
//
//   // void stopRecord() {
//   //   bool s = RecordMp3.instance.stop();
//   //   if (s) {
//   //     statusText = "Record complete";
//   //     isComplete = true;
//   //     setState(() {});
//   //   }
//   // }
//
//   // void play() {
//   //   if (recordFilePath != null && File(recordFilePath).existsSync()) {
//   //     AudioPlayer audioPlayer = AudioPlayer();
//   //     audioPlayer.play(recordFilePath, isLocal: true);
//   //   }
//   // }
//
//   pickFileMob() async {
//     result = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['pdf', 'doc', 'docx'],
//     );
//     //result = await FilePicker.platform.pickFiles();
//     print('----------result--1---$result');
//     if (result != null) {
//       PlatformFile file = result!.files.first;
//       print('----------------pick file form mob   $result');
//       documentName = file.name;
//       print(file.name);
//       print(file.bytes);
//       print(file.size);
//       print(file.extension);
//       print(file.path);
//     } else {
//       // User canceled the picker
//     }
//     print('----------------pick file form mob   $result');
//     print('----------------pick file form mob   ${result!.paths}');
//   }
// }
//
// class FlutterAbsolutePath {
//   static const MethodChannel _channel =
//       const MethodChannel('flutter_absolute_path');
//
//   /// Gets absolute path of the file from android URI or iOS PHAsset identifier
//   /// The return of this method can be used directly with flutter [File] class
//   static Future<String> getAbsolutePath(String uri) async {
//     final Map<String, dynamic> params = <String, dynamic>{
//       'uri': uri,
//     };
//     final String path = await _channel.invokeMethod('getAbsolutePath', params);
//     return path;
//   }
// }
