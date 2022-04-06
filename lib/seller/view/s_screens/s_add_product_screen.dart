import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:image_picker/image_picker.dart';
import 'package:pipes_online/seller/Authentication/s_function.dart';
import 'package:pipes_online/seller/view/s_screens/s_cateloge_home_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_edit_product_screen.dart';
import 'package:pipes_online/seller/view_model/s_add_product_controller.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';

import '../../../buyer/app_constant/app_colors.dart';
import '../../../buyer/custom_widget/widgets/custom_text.dart';
import '../../common/s_common_button.dart';
import '../../common/s_text_style.dart';
import 's_subscribe_screen.dart';
final FirebaseStorage kFirebaseStorage = FirebaseStorage.instance;
final FirebaseFirestore kFireStore = FirebaseFirestore.instance;
CollectionReference userCollection = kFireStore.collection('User');
class SAddProductScreen extends StatefulWidget {

    SAddProductScreen({Key? key, this.selectedPrice}) : super(key: key);
      String? selectedPrice;
  @override
  State<SAddProductScreen> createState() => _SAddProductScreenState();
}

class _SAddProductScreenState extends State<SAddProductScreen> {

  AddProductController addProductController = Get.put(AddProductController());
  TextEditingController prdName = TextEditingController();
  TextEditingController dsc = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();

  final picker = ImagePicker();
  String? uploadImage;
  File? _image;
  String dropdownvalue = 'Plastic';

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile!.path);
      print(_image);
    });
  }
  Future<String?> uploadImageToFirebase(
      {BuildContext? context, String? fileName, File? file}) async {
    try {
      var response = await firebase_storage.FirebaseStorage.instance
          .ref('uploads/$fileName')
          .putFile(file!);

      String downloadUrl = response.ref.getDownloadURL().toString();
      print("Response>>>>>>>>>>>>>>>>>>$downloadUrl");
    } catch (e) {
      print(e);
    }
  }
  var items = [
    'Plastic',
    'Coper 1',
    'Coper 2',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ADD PRODUCT',
          style: STextStyle.bold700White14,
        ),
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: Get.height * 0.1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
      ),
      backgroundColor: AppColors.backGroudColor,
      body: Form(
        key: formGlobalKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 5.sp),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.sp),
                  margin:
                  EdgeInsets.symmetric(vertical: 5.sp),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.primaryColor.withOpacity(0.3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Center(
                        child: Padding(
                          padding:   EdgeInsets.symmetric(vertical: 5.sp),
                          child: Row(
                            children: [
                             /* Container(
                                margin: EdgeInsets.only(bottom: 10, right: 30),
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.9),
                                    border: Border.all(color: Colors.white, width: 10),
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: [
                                      BoxShadow(color: Colors.grey, blurRadius: 10)
                                    ]),
                                child: _image==null?
                                Image.network( 'https://firebasestorage.googleapis.com/v0/b/pipesonline-b2a41.appspot.com/o/pro_1.png?alt=media&token=82dbd6af-9e7d-42e0-9121-60fb98790c04')
                                    : Image.file(_image!),
                  ),*/
                              Container(
                                  alignment: Alignment.topLeft,
                                  child: addProductController.image != null
                                      ? Container(
                                    height: 100.sp,
                                    width: 100.sp,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                        child: _image==null?
                                        Image.network( 'https://firebasestorage.googleapis.com/v0/b/pipesonline-b2a41.appspot.com/o/pro_1.png?alt=media&token=82dbd6af-9e7d-42e0-9121-60fb98790c04')
                                            : Image.file(_image!)
                                    ),
                                  ):Image.asset('assets/images/png/pro_1.png')),
                              FlatButton(
                                onPressed: () async {
                                  pickImage();
                                },
                                child: Container(
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.white, width: 10),
                                      borderRadius: BorderRadius.circular(25),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey, blurRadius: 10)
                                      ]),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      /*GestureDetector(
                          onTap: (){
                            print('it is openable image');
                            showDialog(
                              context: context,
                              builder: (context) => SimpleDialog(
                                children: [
                                  Container(
                                    height: 105.sp,
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        Container(
                                          child: MaterialButton(
                                            child: Text(
                                              'GALLERY',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.sp),
                                            ),
                                            onPressed: () {
                                              // controller.getGalleryImage();
                                              Get.back();
                                            },
                                          ),
                                          width: 220,
                                          height: 50.sp,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  colors: [
                                                    AppColors.primaryColor,
                                                    AppColors.offLightPurpalColor,
                                                    AppColors.primaryColor,
                                                  ]),
                                              borderRadius: BorderRadius.circular(25)),

                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          child: MaterialButton(
                                            child: Text(
                                              'camera',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            onPressed: () {
                                              controller.getCamaroImage();
                                              Get.back();
                                            },
                                          ),
                                          width: 220,
                                          height: 50.sp,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  colors: [
                                                    AppColors.primaryColor,
                                                    AppColors.offLightPurpalColor,
                                                    AppColors.primaryColor,
                                                  ]),
                                              borderRadius: BorderRadius.circular(25)),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          child: Container(
                            child: SvgPicture.asset('assets/images/svg/camera.svg',color: AppColors.primaryColor,),
                            alignment: Alignment.center,
                          ),
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            child: addProductController.image != null
                                ? Container(
                              height: 100.sp,
                              width: 100.sp,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(10)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  controller.image!,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ):Image.asset('assets/images/png/pro_1.png')),*/
                    ],
                  ) /*GetBuilder<AddProductController>(builder: (controller){
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Stack(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 10, right: 30),
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(_image!),
                                          fit: BoxFit.cover),
                                      color: Colors.white.withOpacity(0.9),
                                      border: Border.all(color: Colors.white, width: 10),
                                      borderRadius: BorderRadius.circular(25),
                                      boxShadow: [
                                        BoxShadow(color: Colors.grey, blurRadius: 10)
                                      ]),
                                ),
                                Positioned(
                                  top: 110,
                                  left: 100,
                                  child: FlatButton(
                                    onPressed: () async {
                                      pickImage();
                                    },
                                    child: Container(
                                      height: 45,
                                      width: 45,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.white, width: 10),
                                          borderRadius: BorderRadius.circular(25),
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey, blurRadius: 10)
                                          ]),
                                      child: Icon(
                                        Icons.camera_alt,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        *//*GestureDetector(
                          onTap: (){
                            print('it is openable image');
                            showDialog(
                              context: context,
                              builder: (context) => SimpleDialog(
                                children: [
                                  Container(
                                    height: 105.sp,
                                    width: double.infinity,
                                    child: Column(
                                      children: [
                                        Container(
                                          child: MaterialButton(
                                            child: Text(
                                              'GALLERY',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.sp),
                                            ),
                                            onPressed: () {
                                              // controller.getGalleryImage();
                                              Get.back();
                                            },
                                          ),
                                          width: 220,
                                          height: 50.sp,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  colors: [
                                                    AppColors.primaryColor,
                                                    AppColors.offLightPurpalColor,
                                                    AppColors.primaryColor,
                                                  ]),
                                              borderRadius: BorderRadius.circular(25)),

                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          child: MaterialButton(
                                            child: Text(
                                              'camera',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                            onPressed: () {
                                              controller.getCamaroImage();
                                              Get.back();
                                            },
                                          ),
                                          width: 220,
                                          height: 50.sp,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  colors: [
                                                    AppColors.primaryColor,
                                                    AppColors.offLightPurpalColor,
                                                    AppColors.primaryColor,
                                                  ]),
                                              borderRadius: BorderRadius.circular(25)),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          child: Container(
                            child: SvgPicture.asset('assets/images/svg/camera.svg',color: AppColors.primaryColor,),
                            alignment: Alignment.center,
                          ),
                        ),
                        Container(
                            alignment: Alignment.topLeft,
                            child: addProductController.image != null
                                ? Container(
                              height: 100.sp,
                              width: 100.sp,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.circular(10)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  controller.image!,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ):Image.asset('assets/images/png/pro_1.png')),*//*
                      ],
                    );
                  },),*/
                ),
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Product Info',
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: AppColors.hintTextColor,
                          alignment: Alignment.topLeft,
                        ),
                        Container(
                          height: Get.height / 11.sp,
                          decoration: BoxDecoration(
                              color: AppColors.commonWhiteTextColor,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                new BoxShadow(
                                    blurRadius: 1,
                                    color: AppColors.hintTextColor),
                              ]),
                          // child: TextButton(
                          //     onPressed: () {},
                          //     child: SvgPicture.asset(
                          //         'assets/images/svg/delete_icon.svg')),

                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(
                            text: 'Category',
                            fontWeight: FontWeight.w600,
                            fontSize: 14.sp,
                            color: AppColors.secondaryBlackColor,
                            alignment: Alignment.topLeft),
                        SizedBox(
                          width: Get.width * 0.001,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: SCustomDropDownWidget(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    CustomText(
                      text: 'Product Name',
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: AppColors.secondaryBlackColor,
                      alignment: Alignment.topLeft,
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.sp, vertical: 0.sp),
                      alignment: Alignment.topLeft,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.commonWhiteTextColor),
                      child: TextFormField(
                        controller: prdName,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText:  ('ABX'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    CustomText(
                      text: 'price' ,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: AppColors.secondaryBlackColor,
                      alignment: Alignment.topLeft,
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: Get.width * 0.26,
                      height :Get.height * 0.06,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.sp, vertical: 0.sp),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.commonWhiteTextColor),
                      child:Text('${widget.selectedPrice}'),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    CustomText(
                      text: 'Description',
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: AppColors.secondaryBlackColor,
                      alignment: Alignment.topLeft,
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      width: Get.width * 5,
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.sp, vertical: 10.sp),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: AppColors.commonWhiteTextColor),
                      child: Container(
                        child:  TextField(
                          controller: dsc,
                          decoration: InputDecoration(
                            hintText: 'Enter Address',
                          ),
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          // minLines: 1,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                  ],
                ),
                Padding(
                  padding:   EdgeInsets.symmetric(vertical: 15.sp,horizontal:  30.sp),
                  child: SCommonButton().sCommonPurpleButton(
                    name: 'Add Product',
                   /* onTap: () {
                      addData();
                      Get.to(() => SCatelogeHomeScreen());
                      print('edit product seller side');
                      // Get.toNamed(SRoutes.SSubmitProfileScreen);
                    },*/
                    onTap: () async {
                      if (formGlobalKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Processing Data'),
                            backgroundColor: Colors.blueAccent,
                          ),
                        );
                        formGlobalKey.currentState!.save();
                          await addData(_image).then((value) =>  Get.to(() => SCatelogeHomeScreen()));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget SCustomDropDownWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.sp),
      child: Row(
        children: [
          SizedBox(
            width: Get.width * .1,
          ),
          Card(
            elevation: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 5.sp,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(blurRadius: 1, color: AppColors.offWhiteColor),
                  ]),
              child: DropdownButton(
                value: dropdownvalue,
                icon: Icon(
                  Icons.arrow_drop_down_outlined,
                  color: AppColors.primaryColor,
                  size: 18.sp,
                ),
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: CustomText(
                      text: items,
                      color: AppColors.secondaryBlackColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      textDecoration: TextDecoration.none,
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
              ),
            ),
          ),
          // CustomDropDownWidget(),
        ],
      ),
    );
  }
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> addData(File? file) async {
   /* String? imageUrl = await uploadImageToFirebase(
        context: context, file: _image);*/
    var snapshot = await kFirebaseStorage
        .ref()
        .child('ChatImage/${DateTime.now().microsecondsSinceEpoch}')
        .putFile(file!);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    print('url=$downloadUrl');
    SAuthMethods().getCurrentUser()
        .then((value) {
      userCollection.doc('${_auth.currentUser!.uid}').collection(
          'data').add({
        'imageProfile': downloadUrl,
        'category': dropdownvalue,
        'prdName': prdName.text,
        'dsc': dsc.text,
        'price': widget.selectedPrice,
        'createdOn': DateTime.now(),
      })
          .catchError((e) => print('Error ===>>> $e'))
          .then((value) =>
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return SCatelogeHomeScreen(image: downloadUrl,
                name: prdName.text,
                price: widget.selectedPrice,
                desc: dsc.text,);
            },
          )));
    }
    );
  }
}
