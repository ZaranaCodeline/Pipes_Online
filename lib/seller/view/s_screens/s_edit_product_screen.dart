import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/seller/bottombar/s_navigation_bar.dart';
import 'package:pipes_online/seller/view/s_screens/s_add_product_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_cateloge_home_screen.dart';
import 'package:pipes_online/seller/view_model/s_add_product_controller.dart';
import 'package:sizer/sizer.dart';

import '../../../buyer/app_constant/app_colors.dart';
import '../../../buyer/view_model/b_bottom_bar_controller.dart';
import '../../../buyer/view_model/bottom_controller.dart';
import '../../../shared_prefarence/shared_prefarance.dart';
import '../../Authentication/s_function.dart';
import '../../common/s_common_button.dart';
import '../../common/s_text_style.dart';

class SeditProductScreen extends StatefulWidget {
  SeditProductScreen({Key? key, this.img, this.name, this.price, this.desc, this.id}) : super(key: key);
  final String? img,name,price,desc,id;

  @override
  State<SeditProductScreen> createState() => _SeditProductScreenState();
}

class _SeditProductScreenState extends State<SeditProductScreen> {

  AddProductController addProductController = Get.put(AddProductController());
  BottomController homeController = Get.find();
  TextEditingController prdName = TextEditingController();
  TextEditingController dsc = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  BBottomBarIndexController bottomBarIndexController =
  Get.put(BBottomBarIndexController());
  final picker = ImagePicker();
  String? uploadImage;
  File? _image;
  String? Img;
  String? cat;


  String dropdownvalue = 'Plastic';
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference userCollection = FirebaseFirestore.instance.collection('User');
  @override
  void initState() {
    // TODO: implement initState
   getData();
    super.initState();
  }
  Future<void> getData() async {
print('demo.....');
    final   user =
     await userCollection.doc('${FirebaseAuth.instance.currentUser!.uid}').collection('data').doc(widget.id).get();
Map<String, dynamic>? getUserData = user.data()!;
       prdName.text=getUserData['prdName'];
         dsc.text=getUserData['dsc'];
         Img=getUserData['imageProfile'];
cat=getUserData['category'];

        print('============================${user.get('prdName')}');
      // print('ID:${PreferenceManager.getUID().toString()}');

  }

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
          'EDIT PRODUCT',
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
                              Container(
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
                               Image.network(widget.img.toString())
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

                            ],),
                          // child: TextButton(
                          //     onPressed: () {},
                          //     child: SvgPicture.asset(
                          //         'assets/images/svg/delete_icon.svg')) ,
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
                      child: widget.name!=null?TextFormField(
                        controller: prdName,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText:  ('ABX'),
                        ),
                      ):Text(widget.name.toString()),
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
                      child:Text('${widget.price}'),
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
                    name: 'Edit Product',
                    /* onTap: () {
                      addData();
                      Get.to(() => SCatelogeHomeScreen());
                      print('edit product seller side');
                      // Get.toNamed(SRoutes.SSubmitProfileScreen);
                    },*/
                    onTap: () async {

                      if (formGlobalKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:   Text('Processing data'),
                            backgroundColor: AppColors.primaryColor,
                          ),
                        );
                        formGlobalKey.currentState!.save();
                        await UpdateData();
                        Get.to(() =>
                         NavigationBarScreen(),
                        );
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
  Future<void> UpdateData() async {
    var snapshot = await kFirebaseStorage
        .ref()
        .child('ChatImage/${DateTime.now().microsecondsSinceEpoch}')
        .putFile(_image!);
    String downloadUrl = await snapshot.ref.getDownloadURL();
    print('url=$downloadUrl');
    await userCollection.doc('${FirebaseAuth.instance.currentUser!.uid}').collection('data').doc(widget.id)
        .update({
    'prdName':prdName.text,
      'dsc':dsc.text,
      'category':dropdownvalue,
      'imageProfile': downloadUrl,
    })
        .then((value) => print('success'))
        .catchError((e) => print(e));
  }



}
