import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/seller/common/s_text_style.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';
import '../../seller/common/s_common_button.dart';
import '../app_constant/app_colors.dart';
import 'custom_widget/custom_text.dart';
import 'bottom_bar_screen_page/widget/b_home_bottom_bar_route.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class PersonalInfoPage extends StatefulWidget {
  PersonalInfoPage(
      {Key? key, this.Img, this.firstname, this.address, this.phoneno})
      : super(key: key);
  String? firstname, phoneno, address, Img;

  @override
  State<PersonalInfoPage> createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  File? _image;
  String? Img;
  String? uploadImage;
  String _userName = '';

  final picker = ImagePicker();
  TextEditingController firstname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phoneno = TextEditingController();
  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
  CollectionReference ProfileCollection = bFirebaseStore.collection('BProfile');

  Future<void> getData() async {
    print('demo..PersonalInfoPage');
    final user =
        await ProfileCollection.doc('${FirebaseAuth.instance.currentUser!.uid}')
            .get();
    Map<String, dynamic>? getUserData = user.data() as Map<String, dynamic>?;
    firstname.text = getUserData!['firstname'];
    email.text = getUserData['email'];
    address.text = getUserData['address'];
    phoneno.text = getUserData['phoneno'];
    Img = getUserData['imageProfile'];

    setState(() {
      Img = getUserData['imageProfile'];
    });
    print('============================${user.get('imageProfile')}');
    print('=======getUserData========${getUserData}');
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
              bottomBarIndexController.bottomIndex.value = 0;

              bottomBarIndexController.setSelectedScreen(value: 'HomeScreen');
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text(
            'PROFILE'.toUpperCase(),
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
              child: Form(
                key: formGlobalKey,
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
                                      borderRadius:
                                          BorderRadius.circular(25.sp),
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
                                      borderRadius:
                                          BorderRadius.circular(25.sp),
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
                    TextFormField(
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'This field is required';
                        }
                        if (!RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                            .hasMatch(value)) {
                          return 'please enter valid number';
                        }
                        return null;
                      },
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
                    TextFormField(
                      validator: (email) {
                        if (isEmailValid(email!)) {
                          return null;
                        } else {
                          return 'Enter a valid email address';
                        }
                      },
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
                          if (formGlobalKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Processing Data'),
                                backgroundColor: AppColors.primaryColor,
                              ),
                            );
                            UpdateData();
                            formGlobalKey.currentState!.save();
                            bottomBarIndexController.setSelectedScreen(
                                value: 'HomeScreen');
                            bottomBarIndexController.bottomIndex.value = 0;
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
      ),
    );
  }

  uploadImagetFirebase(String imagePath) async {
    await FirebaseStorage.instance
        .ref(imagePath)
        .putFile(File(imagePath))
        .then((taskSnapshot) {
      print("task done");

// download url when it is uploaded
      if (taskSnapshot.state == TaskState.success) {
        FirebaseStorage.instance.ref(imagePath).getDownloadURL().then((url) {
          print("Here is the URL of Image $url");
          return url;
        }).catchError((onError) {
          print("Got Error $onError");
        });
      }
    });
  }

  Future<String?> uploadImageToFirebase(
      {BuildContext? context, File? file, String? fileName}) async {
    try {
      var response = await firebase_storage.FirebaseStorage.instance
          .ref('uploads/$fileName')
          // .ref('uploads/$file')
          .putFile(file!);
      print("Response>>>>>>>>>>>>>>>>>>$response");
      return response.storage.ref().getDownloadURL();
    } catch (e) {
      print(e);
    }
  }

  Future<void> UpdateData() async {
    String? imageUrl = await uploadImagetFirebase(_image!.path);
    // context: context,
    // file: _image,
    // );
    print(imageUrl);
    uploadImage = imageUrl;
    await ProfileCollection.doc('${PreferenceManager.getUId()}').get();
    print(
        '====>Update PreferenceManager.getUId() ---${PreferenceManager.getUId()}');
    print(
        '====>Update FirebaseAuth.instance.currentUser!.uid ---${FirebaseAuth.instance.currentUser!.uid}');
    await ProfileCollection.doc('${PreferenceManager.getUId()}')
        .update({
          'imageProfile': imageUrl == null ? Img : imageUrl,
          'firstname': firstname.text,
          'email': email.text,
          'address': address.text,
          'phoneno': phoneno.text
        })
        .then((value) => print('success full updated'))
        .catchError((e) => print('not updated updated =>$e'));
  }

  bool isEmailValid(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    return regex.hasMatch(email);
  }
}
