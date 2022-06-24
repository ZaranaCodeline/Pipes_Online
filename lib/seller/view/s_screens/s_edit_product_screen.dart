import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/seller/bottombar/s_navigation_bar.dart';
import 'package:pipes_online/seller/view_model/s_edit_product_controller.dart';
import 'package:sizer/sizer.dart';
import '../../../buyer/app_constant/app_colors.dart';
import '../../../buyer/screens/b_image.dart';
import '../../../buyer/view_model/b_bottom_bar_controller.dart';
import '../../../routes/bottom_controller.dart';
import '../../common/s_common_button.dart';
import '../../common/s_text_style.dart';

class SeditProductScreen extends StatefulWidget {
  SeditProductScreen(
      {Key? key, /* this.img, this.name, this.price, this.desc,*/ this.id})
      : super(key: key);
  final String? /*img, name, price, desc, */ id;

  @override
  State<SeditProductScreen> createState() => _SeditProductScreenState();
}

class _SeditProductScreenState extends State<SeditProductScreen> {
  EditProductContoller editProductContoller = Get.put(EditProductContoller());
  BottomController homeController = Get.find();
  TextEditingController? prdName;
  TextEditingController? dsc;
  TextEditingController? price;
  TextEditingController? cat;
  final formGlobalKey = GlobalKey<FormState>();
  BBottomBarIndexController bottomBarIndexController =
      Get.put(BBottomBarIndexController());
  final picker = ImagePicker();
  String? uploadImage;
  File? _image;
  String? Img;
  bool isLoading = false;
  String dropdownvalue = '';
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection('Products');
  String _selectedValue = '';

  @override
  void initState() {
    print('editProductContoller.id--------- ==>${editProductContoller.id}');
    dropdownvalue = editProductContoller.selectedCatName;
    print('selectedCatName=> ${editProductContoller.selectedCatName}');
    prdName = TextEditingController(text: editProductContoller.selectedName);
    price = TextEditingController(text: editProductContoller.selectedPrice);
    dsc = TextEditingController(text: editProductContoller.selecteddesc);
    cat = TextEditingController(text: editProductContoller.selectedCatName);
    super.initState();
  }

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile!.path);
      print('=====pickImage======updatedimage=========>$_image');
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

  List<String> items = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'EDIT PRODUCT',
            style: STextStyle.bold700White14,
          ),
          leading: IconButton(
            onPressed: () {
              // Get.back();
              setState(() {
                homeController.bottomIndex.value = 0;
                homeController.selectedScreen('SSelectedProductScreen');
              });
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
        body: SafeArea(
          child: Form(
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
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 10)
                                        ]),
                                    child: _image == null
                                        ? Image.network(
                                            editProductContoller.selectedImage,
                                            errorBuilder: (BuildContext context,
                                                Object exception,
                                                StackTrace? stackTrace) {
                                            return ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.asset(
                                                BImagePick.cartIcon,
                                                height: 150,
                                                width: 150,
                                                fit: BoxFit.cover,
                                              ),
                                            );
                                          })
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
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          boxShadow: const [
                                            BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 10)
                                          ]),
                                      child: const Icon(
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
                                  BoxShadow(
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
                                text: 'Category : ',
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                                color: AppColors.secondaryBlackColor,
                                alignment: Alignment.topLeft),
                            SizedBox(
                              width: Get.width * 0.1,
                            ),
                            FutureBuilder<QuerySnapshot>(
                              future: FirebaseFirestore.instance
                                  .collection('Categories')
                                  .get(),
                              builder: (BuildContext context, snapshot) {
                                if (items.isEmpty) {
                                  snapshot.data?.docs.forEach((element) {
                                    items.add(element['name']);
                                  });
                                }
                                print('Categories-name-${items}');
                                if (snapshot.hasData) {
                                  return Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15.sp),
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
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                boxShadow: [
                                                  BoxShadow(
                                                      blurRadius: 1,
                                                      color: AppColors
                                                          .offWhiteColor),
                                                ]),
                                            child: DropdownButton(
                                              hint: Text(dropdownvalue),
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
                                                    color: AppColors
                                                        .secondaryBlackColor,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w600,
                                                    textDecoration:
                                                        TextDecoration.none,
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
                                      ],
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              },
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
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              // hintText:prdName.toString() /*('ABX')*/,
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
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.sp, vertical: 0.sp),
                          alignment: Alignment.topLeft,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.commonWhiteTextColor),
                          child: TextFormField(
                            controller: price,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              // hintText:prdName.toString() /*('ABX')*/,
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
                          child: TextFormField(
                            controller: dsc,
                            decoration: const InputDecoration(
                                // hintText: dsc,
                                ),
                            maxLines: 3,
                            keyboardType: TextInputType.multiline,
                            // minLines: 1,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * 0.01,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 15.sp, horizontal: 30.sp),
                      child: /* isLoading
                          ? Center(
                              child: CircularProgressIndicator(
                              color: AppColors.primaryColor,
                            ))
                          :*/
                          SCommonButton().sCommonPurpleButton(
                        name: 'Edit Product',
                        /* onTap: () {
                          addData();
                          Get.to(() => SCatelogeHomeScreen());
                          print('edit product seller side');
                          // Get.toNamed(SRoutes.SSubmitProfileScreen);
                        },*/
                        onTap: () async {
                          if (formGlobalKey.currentState!.validate()) {
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    height: Get.height,
                                    width: Get.width,
                                    color: Colors.black12,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }).then((value) async {
                              formGlobalKey.currentState!.save();
                            });
                            await UpdateData().then((value) {
                              Get.to(NavigationBarScreen());
                            });
                            setState(() {
                              isLoading = false;
                            });
                            // setState(() {
                            //   isLoading = true;
                            // });

                          }
                        },
                      ),
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

  Future<void> UpdateData() async {
    print('==========editProductContoller.id====${editProductContoller.id}');
    print('==========editProductContoller.selectedName====${prdName?.text}');
    print('==========editProductContoller.selecteddesc====${dsc?.text}');
    print('========== editProductContoller.selectedPrice====${price?.text}');
    print('========== editProductContoller.selectedPrice====${_image}');
    print('========== editProductContoller.selectedPrice====${cat?.text}');
    var snapshot = await bFirebaseStorage
        .ref()
        .child('ChatImage/${DateTime.now().microsecondsSinceEpoch}')
        .putFile(_image!);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    print('url=$downloadUrl');
    userCollection
        .doc(editProductContoller.id)
        .update({
          'prdName': prdName?.text,
          'dsc': dsc?.text,
          'category': cat?.text,
          'imageProfile': downloadUrl,
          'price': price?.text,
        })
        .catchError((e) => print(e.toString()))
        .then((value) {
          editProductContoller.selectedName = prdName;
          editProductContoller.selectedImage = downloadUrl;
          editProductContoller.selecteddesc = dsc.toString();
          editProductContoller.selectedPrice = price.toString();
          editProductContoller.selectedCatName = cat.toString();
          homeController.bottomIndex.value = 0;
          homeController.selectedScreen('SCatelogeHomeScreen');
        });
  }
}
