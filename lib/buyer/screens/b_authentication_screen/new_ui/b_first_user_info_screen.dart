import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/register_repo.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/b_navigationbar.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/buyer/screens/maps_screen.dart';
import 'package:pipes_online/buyer/view_model/geolocation_controller.dart';
import 'package:pipes_online/routes/bottom_controller.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:pipes_online/seller/common/s_image.dart';
import 'package:pipes_online/seller/common/s_text_style.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';

class BFirstUserInfoScreen extends StatefulWidget {
  const BFirstUserInfoScreen({
    Key? key,
    this.email,
    this.mobile,
    this.name,
    this.pass,
    this.phone,
    this.photoUrl,
  }) : super(key: key);
  final String? email, mobile, name, pass, phone, photoUrl;
  @override
  _BFirstUserInfoScreenState createState() => _BFirstUserInfoScreenState();
}

class _BFirstUserInfoScreenState extends State<BFirstUserInfoScreen> {
  File? _image;

  ImagePicker picker = ImagePicker();
  bool isLoading = false;
  Future getGalleryImage() async {
    var imaGe = await picker.pickImage(source: ImageSource.gallery);
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
    if (await Permission.camera.request().isGranted) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.camera,
      ].request();
      print(statuses[Permission.camera]);
      final imaGe = await picker.pickImage(source: ImageSource.camera);

      if (imaGe != null) {
        setState(() {
          _image = File(imaGe.path);
        });

        print("=============ImagePath==========${imaGe.path}");
      } else {
        print('no image selected');
      }
      // Either the permission was already granted before or the user just granted it.
    }

// You can request multiple permissions at once.
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.clear();
    mobilecontroller.clear();
    emailController.clear();
    address.clear();
  }

  @override
  void initState() {
    super.initState();
    print('email---${widget.email}');
    print('name---${widget.name}');
    print('photo---${widget.photoUrl}');
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  GeolocationController _controller = Get.find();

  BottomController bottomController = Get.find();
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Builder(
        builder: (context) => WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: GetBuilder<GeolocationController>(
                  builder: (controller) {
                    return Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            height: Get.height * 0.1,
                            width: Get.width,
                            padding: EdgeInsets.only(
                              top: Get.height * 0.03,
                              right: Get.width * 0.05,
                              left: Get.width * 0.05,
                            ),
                            decoration: BoxDecoration(
                                color: SColorPicker.purple,
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(20.sp))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                /* GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Icon(
                                    Icons.arrow_back_rounded,
                                    color: SColorPicker.white,
                                  ),
                                ),*/
                                Container(),
                                Center(
                                  child: Text(
                                    'PROFILE',
                                    style: STextStyle.bold700White14,
                                  ),
                                ),
                                SizedBox(width: 20.sp),
                              ],
                            ),
                          ),
                          SizedBox(height: 15.sp),
                          Container(
                            height: Get.height * 0.075,
                            width: Get.width * 0.62,
                            decoration: BoxDecoration(
                                color: SColorPicker.purple,
                                borderRadius: BorderRadius.circular(20.sp)),
                            child: GestureDetector(
                              onTap: () {
                                print('it is openable image');

                                showModalBottomSheet<void>(
                                  elevation: 0.5,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: const Radius.circular(20.0),
                                          topRight:
                                              const Radius.circular(20.0))),
                                  backgroundColor: Colors.white,
                                  context: context,
                                  builder: (context) => FractionallySizedBox(
                                    heightFactor: 0.5.sp,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: 35.sp,
                                            height: 5.sp,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: AppColors.primaryColor),
                                          ),
                                          SizedBox(
                                            height: 0.2,
                                          ),
                                          CustomText(
                                              alignment: Alignment.topLeft,
                                              text: '    Add profile photo',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14.sp,
                                              color: AppColors
                                                  .secondaryBlackColor),
                                          Container(
                                            child: MaterialButton(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/png/camera.png',
                                                    width: 15.sp,
                                                    height: 15.sp,
                                                  ),
                                                  SizedBox(
                                                    width: Get.width * 0.05,
                                                  ),
                                                  Text(
                                                    ' Take a photo',
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .primaryColor,
                                                        fontSize: 14.sp),
                                                  ),
                                                ],
                                              ),
                                              onPressed: () {
                                                getCamaroImage();
                                                Get.back();
                                              },
                                            ),
                                          ),
                                          Container(
                                            child: MaterialButton(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    'assets/images/png/gallery.png',
                                                    width: 15.sp,
                                                    height: 15.sp,
                                                  ),
                                                  SizedBox(
                                                    width: Get.width * 0.05,
                                                  ),
                                                  Text(
                                                    ' Upload from photos',
                                                    style: TextStyle(
                                                        color: AppColors
                                                            .primaryColor,
                                                        fontSize: 14.sp),
                                                  ),
                                                ],
                                              ),
                                              onPressed: () {
                                                getGalleryImage();
                                                Get.back();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _image != null
                                      ? Container(
                                          height: 35.sp,
                                          width: 35.sp,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50)),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Image.file(
                                              _image!,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )
                                      : Container(
                                          child: SvgPicture.asset(
                                            "${SImagePick.uploadImageIcon}",
                                          ),
                                        ),
                                  SizedBox(
                                    width: 10.sp,
                                  ),
                                  Text(
                                    'Upload your Image',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: SColorPicker.white,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Nunito-Bold'),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 25.sp),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name',
                                style: STextStyle.semiBold600Black13,
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              Container(
                                width: Get.width * 0.8,
                                height: Get.height * 0.07,
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.trim().isEmpty) {
                                      return 'This field is required';
                                    } else if (!RegExp('[a-zA-Z]')
                                        .hasMatch(value)) {
                                      return 'please enter valid name';
                                    }
                                    return null;
                                  },
                                  controller: nameController,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                      // hintText: widget.email,
                                      ),
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Text(
                                widget.email != null ||
                                        bFirebaseAuth.currentUser?.email != null
                                    ? 'Mobile'
                                    : 'Email',
                                style: STextStyle.semiBold600Black13,
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              ),
                              widget.email != null ||
                                      bFirebaseAuth.currentUser?.email != null
                                  ? Container(
                                      width: Get.width * 0.8,
                                      height: Get.height * 0.07,
                                      child: TextFormField(
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(10),
                                        ],
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Required';
                                          }
                                        },
                                        controller: widget.phone != null
                                            ? PreferenceManager.getPhoneNumber()
                                            : emailController,
                                        decoration: InputDecoration(

                                            // hintText: "Name",
                                            ),
                                      ),
                                    )
                                  : Container(
                                      width: Get.width * 0.8,
                                      height: Get.height * 0.07,
                                      child: TextFormField(
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Required';
                                          }
                                        },
                                        controller: widget.email != null
                                            ? PreferenceManager.getEmail()
                                            : emailController,
                                        decoration: InputDecoration(
                                            // hintText: "Name",
                                            ),
                                      ),
                                    ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Text(
                                'Address',
                                style: STextStyle.semiBold600Black13,
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Container(
                                height: Get.height * 0.09,
                                width: Get.width * 0.75,
                                alignment: Alignment.centerLeft,
                                child: TextFormField(
                                  // cursorColor: AppColors.primaryColor,
                                  keyboardType: TextInputType.streetAddress,
                                  // autocorrect: true,
                                  // autovalidateMode:
                                  //     AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Required';
                                    } else {
                                      return null;
                                    }
                                  },
                                  maxLines: 2,
                                  controller:
                                      _controller.addressController == null
                                          ? address
                                          : _controller.addressController,
                                  decoration: InputDecoration(
                                      // hintText: 'Enter Address',
                                      // border: OutlineInputBorder(
                                      //     borderRadius: BorderRadius.circular(10)),
                                      ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.sp),
                          Text(
                            'Add location using google map....',
                            style: STextStyle.semiBold600Black13,
                          ),
                          SizedBox(height: 15.sp),
                          GestureDetector(
                            onTap: () {
                              print('is Maps  ');
                              Get.to(MapsScreen());
                            },
                            child: Container(
                              padding: EdgeInsets.all(12.sp),
                              height: Get.height * 0.075,
                              width: Get.height * 0.23,
                              decoration: BoxDecoration(
                                color: SColorPicker.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      spreadRadius: 0.5,
                                      blurRadius: 1),
                                ],
                                borderRadius: BorderRadius.circular(10.sp),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset(
                                    "${SImagePick.locationColorIcon}",
                                  ),
                                  Text(
                                    'Get Locaton',
                                    style: STextStyle.semiBold600Black13,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 25.sp),
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                print('Validate');
                                addData().then((value) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  // Get.offAll(() => BottomNavigationBarScreen());
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavigationBarScreen()));
                                });
                                setState(() {
                                  isLoading = false;
                                });
                              } else {
                                print('InValidate');
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: Get.width * 0.6,
                              height: Get.height * 0.07,
                              decoration: BoxDecoration(
                                color: SColorPicker.purple,
                                borderRadius: BorderRadius.circular(10.sp),
                              ),
                              child: isLoading
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomText(
                                            text: 'Loading...  ',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12.sp,
                                            color:
                                                AppColors.commonWhiteTextColor),
                                        CircularProgressIndicator(
                                          color: AppColors.commonWhiteTextColor,
                                        ),
                                      ],
                                    )
                                  : Text(
                                      'Submit',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              AppColors.commonWhiteTextColor),
                                    ),
                            ),
                          ),
                          // if (!address.isEmpty) SizedBox(height: Get.height * 0.05),
                          SizedBox(height: Get.height * 0.1),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  Future<String?> uploadImageToFirebase(
      {BuildContext? context, String? fileName, File? file}) async {
    try {
      var response = await firebase_storage.FirebaseStorage.instance
          .ref('uploads/$fileName')
          .putFile(file!);
      print("Response>>>>>>>>>>>>>>>>>>$response");
      return response.storage.ref('uploads/$fileName').getDownloadURL();
    } catch (e) {
      print(e);
    }
  }

  Future<void> addData() async {
    String? imageUrl = await uploadImageToFirebase(
        context: context,
        file: _image,
        fileName: '${emailController.text}_profile.jpg');
    // FirebaseFirestore.instance
    //     .collection("BReviews")
    //     .doc('${PreferenceManager.getUId()}')
    print(emailController.text);
    print(mobilecontroller.text);
    CollectionReference ProfileCollection =
        bFirebaseStore.collection('BProfile');
    ProfileCollection.doc('${PreferenceManager.getUId()}')
        .set({
          'buyerID': PreferenceManager.getUId(),
          'email': widget.email != null
              ? PreferenceManager.getEmail()
              : emailController.text,
          'isOnline': false,
          'phoneno': widget.phone != null
              ? PreferenceManager.getPhoneNumber()
              : mobilecontroller.text,
          'user_name': nameController.text,
          'imageProfile': imageUrl ??
              'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png',
          'address': _controller.addressController == null
              ? address
              : _controller.addressController!.text,
          'userType': PreferenceManager.getUserType(),
          'userDetails': 'true',
          'time': DateTime.now(),
        })
        .catchError((e) => print('Error ====buyer=====>>> $e'))
        .then((value) async {
          PreferenceManager.getPhoneNumber() != null
              ? PreferenceManager.setPhoneNumber(
                  PreferenceManager.getPhoneNumber())
              : PreferenceManager.setPhoneNumber(mobilecontroller.text);

          PreferenceManager.getEmail() != null
              ? PreferenceManager.setEmail(PreferenceManager.getEmail())
              : PreferenceManager.setEmail(emailController.text);
        });
  }

  bool isPasswordValid(String password) => password.length <= 50;

  bool isEmailValid(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    return regex.hasMatch(email);
  }
}
