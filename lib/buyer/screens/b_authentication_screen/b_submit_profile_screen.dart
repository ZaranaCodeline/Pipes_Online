// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:pipes_online/buyer/app_constant/app_colors.dart';
// import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/b_navigationbar.dart';
// import 'package:pipes_online/buyer/view_model/geolocation_controller.dart';
// import 'package:pipes_online/seller/common/s_color_picker.dart';
// import 'package:pipes_online/seller/common/s_common_button.dart';
// import 'package:pipes_online/seller/common/s_image.dart';
// import 'package:pipes_online/seller/common/s_text_style.dart';
// import 'package:sizer/sizer.dart';
// import '../../../routes/bottom_controller.dart';
// import '../../../seller/Authentication/s_function.dart';
// import '../b_chat_message_page.dart';
// import '../maps_screen.dart';
//
// class BSubmitProfileScreen extends StatefulWidget {
//
//
//   const BSubmitProfileScreen({Key? key,}) : super(key: key);
//
//   @override
//   _BSubmitProfileScreenState createState() => _BSubmitProfileScreenState();
// }
//
// class _BSubmitProfileScreenState extends State<BSubmitProfileScreen> {
//
//   File? _image;
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   GeolocationController _controller = Get.find();
//   BottomController homeController = Get.find();
//   final picker = ImagePicker();
//
//   Future getGalleryImage() async {
//     var imaGe = await picker.getImage(source: ImageSource.gallery);
//     setState(() {
//       if (imaGe != null) {
//         _image = File(imaGe.path);
//         print("=============ImagePath==========${imaGe.path}");
//         imageCache!.clear();
//       } else {
//         print('no image selected');
//       }
//     });
//   }
//
//   Future getCamaroImage() async {
//     var imaGe = await picker.getImage(source: ImageSource.camera);
//     print("==========ImagePath=============${imaGe!.path}");
//     setState(() {
//       if (imaGe != null) {
//         _image = File(imaGe.path);
//         print("===========ImagePath============${_image}");
//         print("=============ImagePath==========${imaGe.path}");
//
//         imageCache!.clear();
//       } else {
//         print('no image selected');
//       }
//     });
//   }
//
//   GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController addController = TextEditingController();
//   TextEditingController mobileCnt = TextEditingController();
//
//   BottomController bottomController = Get.find();
//
//
//
//   @override
//   void initState() {
//
//     super.initState();
//   }
//
//
//   Widget build(BuildContext context) {
//     return Sizer(builder: (context, orientation, deviceType) {
//
//       return Builder(
//         builder: (context) => SafeArea(
//           child: Scaffold(
//             body: SingleChildScrollView(
//               child: Form(
//                 autovalidateMode: AutovalidateMode.onUserInteraction,
//                 key: _formKey,
//                 child: GetBuilder<GeolocationController>(builder: (controller) => Column(
//                   children: [
//                     Container(
//                       height: Get.height * 0.1,
//                       width: Get.width,
//                       padding: EdgeInsets.only(
//                         top: Get.height * 0.03,
//                         right: Get.width * 0.05,
//                         left: Get.width * 0.05,
//                       ),
//                       decoration: BoxDecoration(
//                           color: SColorPicker.purple,
//                           borderRadius: BorderRadius.vertical(
//                               bottom: Radius.circular(20.sp))),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               Get.back();
//                             },
//                             child: Icon(
//                               Icons.arrow_back_rounded,
//                               color: SColorPicker.white,
//                             ),
//                           ),
//                           Text(
//                             'PROFILE',
//                             style: STextStyle.bold700White14,
//                           ),
//                           SizedBox(width: 20.sp),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 15.sp),
//                     Container(
//                       height: Get.height * 0.075,
//                       width: Get.width * 0.62,
//                       decoration: BoxDecoration(
//                           color: SColorPicker.purple,
//                           borderRadius: BorderRadius.circular(20.sp)),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           GestureDetector(
//                             onTap: () {
//                               print('it is openable image');
//                               showDialog(
//                                 context: context,
//                                 builder: (context) => SimpleDialog(
//                                   children: [
//                                     Container(
//                                       height: 125.sp,
//                                       width: double.infinity,
//                                       child: Column(
//                                         children: [
//                                           Container(
//                                             child: MaterialButton(
//                                               child: Text(
//                                                 'GALLERY',
//                                                 style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize: 14.sp),
//                                               ),
//                                               onPressed: () {
//                                                 getGalleryImage();
//                                                 Get.back();
//                                               },
//                                             ),
//                                             width: 220,
//                                             height: 60.sp,
//                                             decoration: BoxDecoration(
//                                                 gradient: LinearGradient(
//                                                     begin: Alignment.centerLeft,
//                                                     colors: [
//                                                       AppColors.primaryColor,
//                                                       AppColors.offLightPurpalColor,
//                                                     ]),
//                                                 borderRadius: BorderRadius.circular(25)),
//
//                                           ),
//                                           SizedBox(
//                                             height: 5,
//                                           ),
//                                           Container(
//                                             child: MaterialButton(
//                                               child: Text(
//                                                 'camera',
//                                                 style: TextStyle(
//                                                     color: Colors.white,
//                                                     fontSize: 20),
//                                               ),
//                                               onPressed: () {
//                                                 getCamaroImage();
//                                                 Get.back();
//                                               },
//                                             ),
//                                             width: 220,
//                                             height: 60.sp,
//                                             decoration: BoxDecoration(
//                                                 gradient: LinearGradient(
//                                                     begin: Alignment.centerLeft,
//                                                     colors: [
//                                                       AppColors.primaryColor,
//                                                       AppColors.offLightPurpalColor,
//                                                     ]),
//                                                 borderRadius: BorderRadius.circular(25)),
//                                           ),
//                                         ],
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                               );
//                             },
//                             child: _image != null
//                                 ? Container(
//                               height: 35.sp,
//                               width: 35.sp,
//                               decoration: BoxDecoration(
//                                   borderRadius:
//                                   BorderRadius.circular(50)),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(50),
//                                 child: Image.file(
//                                   _image!,
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                             )
//                                 : Container(
//                               child: SvgPicture.asset(
//                                 "${SImagePick.uploadImageIcon}",
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 10.sp,
//                           ),
//                           Text(
//                             'Upload your Image',
//                             style: TextStyle(
//                                 fontSize: 12.sp,
//                                 color: SColorPicker.white,
//                                 fontWeight: FontWeight.w700,
//                                 fontFamily: 'Ubuntu-Bold'),
//                           )
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 25.sp),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Name',
//                           style: STextStyle.semiBold600Black13,
//                         ),
//                         Container(
//                           width: Get.width * 0.75,
//                           alignment: Alignment.centerLeft,
//                           child: TextFormField(
//                             keyboardType: TextInputType.name,
//                             autocorrect: true,
//                             autovalidateMode:
//                             AutovalidateMode.onUserInteraction,
//                             autofocus: true,
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'Required';
//                               }
//                               return null;
//                             },
//                             controller: nameController,
//                             decoration: InputDecoration(
//                               hintText: 'Enter Name',
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10)),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 10.sp),
//                         Text(
//                           'Mobile',
//                           style: STextStyle.semiBold600Black13,
//                         ),
//
//                         Container(
//                           width: Get.width * 0.75,
//                           alignment: Alignment.centerLeft,
//                           child: TextFormField(
//                             keyboardType: TextInputType.number,
//                             autocorrect: true,
//                             autovalidateMode:
//                             AutovalidateMode.onUserInteraction,
//                             maxLength: 10,
//                             autofocus: true,
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return 'Required';
//                               }
//                               return null;
//                             },
//                             controller: mobileCnt,
//                             decoration: InputDecoration(
//                               hintText: '+91 0000000000',
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10)),
//                             ),
//                           ),
//                         ),
//
//
//                         SizedBox(height: 10.sp),
//                         Text(
//                           'Address',
//                           style: STextStyle.semiBold600Black13,
//                         ),
//                         SizedBox(height: 5.sp),
//                         FittedBox(
//                           child: Container(
//                             //  height: Get.height * 0.06,
//                             width: Get.width * 0.75,
//                             alignment: Alignment.centerLeft,
//                             child: TextFormField(
//                               // cursorColor: AppColors.primaryColor,
//                               keyboardType: TextInputType.streetAddress,
//                               validator: (value) {
//                                 if (value!.isEmpty) {
//                                   return 'Required';
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                               maxLines: 3,
//                               controller: _controller.addressController==null?addController:_controller.addressController,
//                               decoration: InputDecoration(
//                                 hintText: 'Enter Address',
//                                 border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(10)),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 15.sp),
//                     Text(
//                       'Add location using google map',
//                       style: STextStyle.semiBold600Black13,
//                     ),
//                     SizedBox(height: 15.sp),
//                     GestureDetector(
//                       onTap: () {
//                         print('is enterggg');
//                         Get.to(MapsScreen());
//                       },
//                       child: Container(
//                         padding: EdgeInsets.all(12.sp),
//                         height: Get.height * 0.075,
//                         width: Get.height * 0.23,
//                         decoration: BoxDecoration(
//                           color: SColorPicker.white,
//                           boxShadow: [
//                             BoxShadow(
//                                 color: Colors.black12,
//                                 spreadRadius: 0.5,
//                                 blurRadius: 1),
//                           ],
//                           borderRadius: BorderRadius.circular(10.sp),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             SvgPicture.asset(
//                               "${SImagePick.locationColorIcon}",
//                             ),
//                             Text(
//                               'Get Locaton',
//                               style: STextStyle.semiBold600Black13,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 25.sp),
//
//                     // if (controller.mapController!.text.isEmpty) SizedBox(height: Get.height * 0.05),
//                     // Text('${controller.mapController!.text}'),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 50.sp),
//                       child: SCommonButton().sCommonPurpleButton(
//                         name: 'Continue',
//                         onTap: () {
//                           if (_formKey.currentState!.validate()) {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                                SnackBar(
//                                 content: Text('Processing Data'),
//                                 backgroundColor: AppColors.primaryColor,
//                               ),
//                             );
//                             addData(_image);
//                           }
//                         },
//                       ),
//                     ),
//                     SizedBox(height: Get.height * 0.1),
//                   ],
//                 ),),
//               ),
//             ),
//           ),
//         ),
//       );
//     });
//   }
//   CollectionReference ProfileCollection = kFireStore.collection('profileinfo');
//   Future<void> addData(File? file) async {
//     var snapshot = await kFirebaseStorage
//         .ref()
//         .child('ChatImage/${DateTime.now().microsecondsSinceEpoch}')
//         .putFile(file!);
//     String downloadUrl = await snapshot.ref.getDownloadURL();
//     print('url=$downloadUrl');
//     SAuthMethods().getCurrentUser()
//         .then((value) {
//       ProfileCollection.doc('${_auth.currentUser!.uid}').set({
//         'imageProfile': downloadUrl,
//         'name':nameController.text,
//        'add':_controller.addressController==null?addController.text:_controller.addressController!.text,
//         'mobile':mobileCnt.text
//       })
//           .catchError((e) => print('Error ===>>> $e'))
//           .then((value) {
//         Get.offAll(() => BottomNavigationBarScreen());
//       }
// );
//     }
//     );
//   }
// }
