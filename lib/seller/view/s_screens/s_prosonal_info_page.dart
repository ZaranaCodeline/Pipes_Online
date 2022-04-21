import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/routes/bottom_controller.dart';
import 'package:pipes_online/seller/bottombar/s_navigation_bar.dart';
import 'package:pipes_online/seller/common/s_text_style.dart';
import 'package:pipes_online/seller/view/s_screens/s_common_button.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../../buyer/screens/bottom_bar_screen_page/widget/b_home_bottom_bar_route.dart';
import '../../bottombar/widget/category_bottom_bar_route.dart';

class SPersonalInfoPage extends StatefulWidget {
  const SPersonalInfoPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SPersonalInfoPage> createState() => _SPersonalInfoPageState();
}

class _SPersonalInfoPageState extends State<SPersonalInfoPage> {
  File? _image;
  String? Img;
  String? uploadImage;
  String _userName = '';
  final picker = ImagePicker();
  TextEditingController firstname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phoneno = TextEditingController();
  CollectionReference ProfileCollection = bFirebaseStore.collection('SProfile');

  Future<void> getData() async {
    print('demo.....');
    BottomController homeController = Get.find();

    final user =
        await ProfileCollection.doc('${FirebaseAuth.instance.currentUser!.uid}')
            .get();
    Map<String, dynamic>? getUserData = user.data() as Map<String, dynamic>?;
    firstname.text = getUserData!['firstname'];
    email.text = getUserData['email'];
    address.text = getUserData['address'];
    phoneno.text = getUserData['phoneno'];
    setState(() {
      Img = getUserData['imageProfile'];
    });
    print('============================${user.get('$firstname')}');
    print('============================${user.get('$email')}');
    print('============================${user.get('$address')}');
    print('============================${user.get('$phoneno')}');
  }

  Future getGalleryImage() async {
    var imaGe = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (imaGe != null) {
        _image = File(imaGe.path);
        print("=============ImagePath==========${imaGe.path}");
        imageCache!.clear();
      } else {
        print('no image selected');
      }
    });
  }

  Future getCamaroImage() async {
    var imaGe = await picker.getImage(source: ImageSource.camera);
    print("==========ImagePath=============${imaGe!.path}");
    setState(() {
      if (imaGe != null) {
        _image = File(imaGe.path);
        print("===========ImagePath============${_image}");
        print("=============ImagePath==========${imaGe.path}");

        imageCache!.clear();
      } else {
        print('no image selected');
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
              // homeController.bottomIndex.value = 0;
              // homeController.selectedScreen('NavigationBarScreen');
              // Get.to(() => NavigationBarScreen());
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text(
            'PROFILE',
            style: STextStyle.bold700White14,
          ),
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          toolbarHeight: Get.height * 0.1,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25),
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.sp),
            padding: EdgeInsets.symmetric(horizontal: Get.height * 0.04),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: Get.height * 0.02),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet<void>(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(20.0),
                                topRight: const Radius.circular(20.0))),
                        backgroundColor: Colors.white,
                        context: context,
                        builder: (context) => FractionallySizedBox(
                          heightFactor: 0.2.sp,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(25.sp),
                                    border: Border.all(
                                        color: AppColors.primaryColor)),
                                child: MaterialButton(
                                  child: Text(
                                    'GALLERY'.toUpperCase(),
                                    style: TextStyle(
                                        color: AppColors.commonWhiteTextColor,
                                        fontSize: 14.sp),
                                  ),
                                  onPressed: () {
                                    getGalleryImage();
                                    Get.back();
                                  },
                                ),
                              ),
                              SizedBox(width: Get.width * 0.05),
                              Container(
                                decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(25.sp),
                                    border: Border.all(
                                        color: AppColors.primaryColor)),
                                child: MaterialButton(
                                  child: Text(
                                    'camera'.toUpperCase(),
                                    style: TextStyle(
                                        color: AppColors.commonWhiteTextColor,
                                        fontSize: 14.sp),
                                  ),
                                  onPressed: () {
                                    getCamaroImage();
                                    Get.back();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 50.sp,
                          width: 50.sp,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: _image == null
                                ? Image.network(
                                    Img == null
                                        ? 'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png'
                                        : Img!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(_image!, fit: BoxFit.fill),
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        CustomText(
                            text: 'Change profile picture.',
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            color: AppColors.primaryColor),
                      ],
                    ),
                  ),
                  SizedBox(height: Get.height * 0.01),
                  CustomText(
                    text: 'Name',
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    color: AppColors.primaryColor,
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  TextField(
                    controller: firstname,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.edit),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      hintText: 'Jan Doe',
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  CustomText(
                    text: 'Mobile',
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    color: AppColors.primaryColor,
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  TextField(
                    controller: phoneno,
                    // maxLength: 10,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.edit),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      hintText: '+91 0000000000',
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  CustomText(
                    text: 'Email',
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    color: AppColors.primaryColor,
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  TextField(
                    controller: email,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.edit),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      hintText: 'Enter Emial',
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  CustomText(
                    text: 'Address',
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp,
                    color: AppColors.primaryColor,
                    alignment: Alignment.topLeft,
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  TextField(
                    controller: address,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.edit),
                      hintText: 'Enter Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                    maxLines: 2,
                    keyboardType: TextInputType.multiline,
                    // minLines: 1,
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.sp,
                    ),
                    child: SCommonButton().sCommonPurpleButton(
                      name: 'SAVE',
                      onTap: () {
                        UpdateData();
                        Get.back();
                        if (bottomBarIndexController.bottomIndex.value == 3) {
                          bottomBarIndexController.setSelectedScreen(
                              value: 'ProfileScreen');
                          bottomBarIndexController.bottomIndex.value = 0;
                        } else {
                          Get.back();
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> uploadImageToFirebase(
      {BuildContext? context, File? file}) async {
    try {
      var response = await firebase_storage.FirebaseStorage.instance
          .ref('uploads/$file')
          .putFile(file!);
      print("Response>>>>>>>>>>>>>>>>>>$response");
      return response.storage.ref().getDownloadURL();
    } catch (e) {
      print(e);
    }
  }

  Future<void> UpdateData() async {
    String? imageUrl = await uploadImageToFirebase(
      context: context,
      file: _image,
    );
    print(imageUrl);
    uploadImage = imageUrl;
    await ProfileCollection.doc('${FirebaseAuth.instance.currentUser!.uid}')
        .get();
    print('====>Update data ---${FirebaseAuth.instance.currentUser!.uid}');
    await ProfileCollection.doc('${FirebaseAuth.instance.currentUser!.uid}')
        .update({
          'imageProfile': imageUrl == null ? Img : imageUrl,
          'firstname': firstname.text,
          'email': email.text,
          'address': address.text,
          'phoneno': phoneno.text
        })
        .then((value) => print('success'))
        .catchError((e) => print(e));
  }
}