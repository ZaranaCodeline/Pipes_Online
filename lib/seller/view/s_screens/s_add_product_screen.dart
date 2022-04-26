import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/seller/Authentication/s_function.dart';
import 'package:pipes_online/seller/view/s_screens/s_color_picker.dart';
import 'package:pipes_online/seller/view_model/s_add_product_controller.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';
import '../../../buyer/app_constant/app_colors.dart';
import '../../../buyer/screens/custom_widget/custom_text.dart';
import '../../../buyer/view_model/b_bottom_bar_controller.dart';
import '../../../routes/bottom_controller.dart';
import '../../common/s_common_button.dart';
import '../../common/s_text_style.dart';

CollectionReference userCollection = bFirebaseStore.collection('Products');

class SAddProductScreen extends StatefulWidget {
  SAddProductScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<SAddProductScreen> createState() => _SAddProductScreenState();
}

class _SAddProductScreenState extends State<SAddProductScreen> {
  AddProductController addProductController = Get.put(AddProductController());
  BottomController homeController = Get.find();

  TextEditingController prdName = TextEditingController();
  TextEditingController dsc = TextEditingController();
  TextEditingController prdPrice = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  BBottomBarIndexController bottomBarIndexController =
      Get.put(BBottomBarIndexController());
  final picker = ImagePicker();
  String? uploadImage;
  File? _image;
  String dropdownvalue = 'Plastic';
  bool isLoading = false;

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
    'Steel',
    'Copper',
    'Electrical',
    'Iron',
    'gas',
    'Oil',
    'Coil Tubing',
    'Coil Rode',
    'Sucker Rode',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'ADD PRODUCT',
            style: STextStyle.bold700White14,
          ),
          leading: IconButton(
            onPressed: () {
              homeController.bottomIndex.value = 0;
              homeController.selectedScreen('ScatelogHomeScreen');
            },
            icon: Icon(Icons.arrow_back),
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
                    margin: EdgeInsets.symmetric(vertical: 5.sp),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.primaryColor.withOpacity(0.3),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.sp),
                            child: Row(
                              children: [
                                Container(
                                  margin:
                                      EdgeInsets.only(bottom: 10, right: 30),
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.9),
                                      border: Border.all(
                                          color: Colors.white, width: 10),
                                      borderRadius: BorderRadius.circular(25),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey, blurRadius: 10)
                                      ]),
                                  child: _image == null
                                      ? Image.network(
                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQB4x3H3i8szbt2TfefSCNwMpzF28ZM1Hvx907uC6ybDPBBb7uUdi3AIQbD7x7Wpnezv6M&usqp=CAU')
                                      : Image.file(_image!),
                                ),
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
                                              color: Colors.grey,
                                              blurRadius: 10)
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
                      ],
                    ),
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
                              ],
                            ),
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Name';
                            }
                          },
                          decoration: InputDecoration(
                            // border: InputBorder.none,
                            // focusedBorder: InputBorder.none,
                            // enabledBorder: InputBorder.none,
                            // errorBorder: InputBorder.none,
                            // disabledBorder: InputBorder.none,
                            hintText: ('ABX'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      CustomText(
                        text: 'price',
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        color: AppColors.secondaryBlackColor,
                        alignment: Alignment.topLeft,
                      ),
                      SizedBox(
                        height: Get.height * 0.01,
                      ),
                      /*Container(
                        alignment: Alignment.center,
                        width: Get.width * 0.26,
                        height: Get.height * 0.06,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.sp, vertical: 0.sp),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.commonWhiteTextColor),
                        // child:Text('${addProductController.selectedPrice}'),
                        child: Text('${prdPrice}'),
                      )*/
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.sp, vertical: 0.sp),
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.commonWhiteTextColor),
                        child: TextFormField(
                          controller: prdPrice,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Price';
                            }
                          },
                          decoration: InputDecoration(
                            // border: InputBorder.none,
                            // focusedBorder: InputBorder.none,
                            // enabledBorder: InputBorder.none,
                            // errorBorder: InputBorder.none,
                            // disabledBorder: InputBorder.none,
                            hintText: ('PRICE'),
                          ),
                        ),
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
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Address';
                              }
                            },
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
                        height: Get.height * 0.03,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 15.sp, horizontal: 30.sp),
                    child: SCommonButton().sCommonPurpleButton(
                      name: 'Add Product',
                      onTap: () async {
                        if (formGlobalKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Processing data'),
                              backgroundColor: AppColors.primaryColor,
                            ),
                          );
                          if (_image == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please Select Image'),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                          }
                          formGlobalKey.currentState!.save();
                          await addData(_image).then((value) {
                            homeController
                                .selectedScreen('SCatelogeHomeScreen');
                            homeController.bottomIndex.value = 0;
                          });
                        }
                      },
                    ),
                  ),
                  // Container(
                  //   alignment: Alignment.center,
                  //   width: Get.width,
                  //   height: Get.height * 0.07,
                  //   decoration: BoxDecoration(
                  //     color: SColorPicker.purple,
                  //     borderRadius: BorderRadius.circular(10.sp),
                  //   ),
                  //   child: GestureDetector(
                  //     onTap: () async {
                  //       if (formGlobalKey.currentState!.validate()) {
                  //         // ScaffoldMessenger.of(context).showSnackBar(
                  //         //   SnackBar(
                  //         //     content: Text('Processing data'),
                  //         //     backgroundColor: AppColors.primaryColor,
                  //         //   ),
                  //         // );
                  //         // if (_image == null) {
                  //         //   ScaffoldMessenger.of(context).showSnackBar(
                  //         //     SnackBar(
                  //         //       content: Text('Please Select Image'),
                  //         //       backgroundColor: Colors.redAccent,
                  //         //     ),
                  //         //   );
                  //         // }
                  //         setState(() {
                  //           isLoading = true;
                  //         });
                  //         Future.delayed(Duration(seconds: 5), () {
                  //           setState(() {
                  //             isLoading = false;
                  //           });
                  //         });
                  //         formGlobalKey.currentState!.save();
                  //         await addData(_image).then((value) {
                  //           homeController
                  //               .selectedScreen('SCatelogeHomeScreen');
                  //           homeController.bottomIndex.value = 0;
                  //         });
                  //       }
                  //     },
                  //     child: isLoading
                  //         ? CircularProgressIndicator(
                  //             color: AppColors.commonWhiteTextColor,
                  //           )
                  //         : Text(
                  //             'Add Product',
                  //             style: TextStyle(
                  //                 color: AppColors.commonWhiteTextColor),
                  //           ),
                  //   ),
                  // ),
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
    print(
        'demo.PreferenceManager.getTime().toString()....${PreferenceManager.getUId()}');
    print('userCollection.id....${userCollection.id}');

    var snapshot = await bFirebaseStorage
        .ref()
        .child('ChatImage/${DateTime.now().microsecondsSinceEpoch}')
        .putFile(file!);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    print('url=$downloadUrl');
    SAuthMethods().getCurrentUser().then((value) {
      userCollection
          .add({
            // 'productID':,
            'sellerID': PreferenceManager.getUId(),
            'imageProfile': downloadUrl,
            'category': dropdownvalue,
            'prdName': prdName.text,
            'dsc': dsc.text,
            'price': prdPrice.text,
            // 'price':addProductController.selectedPrice,
            'createdOn': DateTime.now(),
          })
          .catchError((e) => print('Error ===>>> $e'))
          .then((value) {
            addProductController.name = prdName.text;
            addProductController.images = downloadUrl;
            addProductController.descs = dsc.text;
            addProductController.prices = prdPrice.text;
            // addProductController.prices = addProductController.selectedPrice;
            addProductController.category = addProductController.category;
            homeController.bottomIndex.value = 0;
            homeController.selectedScreen('SCatelogeHomeScreen');
          }
              /*  Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return SCatelogeHomeScreen(
                image: downloadUrl,
                name: prdName.text,
                price: addProductController.selectedPrice,
                desc: dsc.text,);
            },
          ))*/
              );
    });
  }
}
