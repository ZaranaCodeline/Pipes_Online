import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/buyer/screens/maps_screen.dart';
import 'package:pipes_online/buyer/view_model/geolocation_controller.dart';
import 'package:pipes_online/routes/bottom_controller.dart';
import 'package:pipes_online/seller/bottombar/s_navigation_bar.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:pipes_online/seller/common/s_image.dart';
import 'package:pipes_online/seller/common/s_text_style.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';

class SFirstUserInfoScreen extends StatefulWidget {
  const SFirstUserInfoScreen({
    Key? key,
    this.email,
    this.mobile,
    this.name,
    this.pass,
    this.photoUrl,
    this.phone,
  }) : super(key: key);
  final String? email, mobile, name, pass, phone, photoUrl;
  @override
  _SFirstUserInfoScreenState createState() => _SFirstUserInfoScreenState();
}

class _SFirstUserInfoScreenState extends State<SFirstUserInfoScreen> {
  File? _image;
//final
  ImagePicker picker = ImagePicker();
  bool isLoading = false;
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
    PreferenceManager.getName();
    PreferenceManager.getFcmToken();

    print('seller user name--${PreferenceManager.getName()}');
    PreferenceManager.getAddress();
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobilecontroller = TextEditingController();
  GeolocationController _controller = Get.find();
  BottomController bottomController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: GetBuilder<GeolocationController>(
                builder: (controller) {
                  controller.latitude.value.toString();
                  controller.longitude.value.toString();
                  PreferenceManager.getLat();
                  PreferenceManager.getLong();
                  print('getLat>>>>>> ${controller.latitude.value.toString()}');
                  print(
                      'getLong>>>>> ${controller.longitude.value.toString()}');

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
                              Container(),
                              Text(
                                'PROFILE',
                                style: STextStyle.bold700White14,
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                  onTap: () {
                                    print('it is openable image');

                                    showModalBottomSheet<void>(
                                      elevation: 0.5,
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20.0),
                                              topRight: Radius.circular(20.0))),
                                      backgroundColor: Colors.white,
                                      context: context,
                                      builder: (context) =>
                                          FractionallySizedBox(
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
                                                        BorderRadius.circular(
                                                            15),
                                                    color:
                                                        AppColors.primaryColor),
                                              ),
                                              const SizedBox(
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
                                    children: [
                                      _image != null
                                          ? Container(
                                              height: 35.sp,
                                              width: 35.sp,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50)),
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
                                    ],
                                  )),
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
                                          : mobilecontroller,
                                      decoration: InputDecoration(),
                                    ),
                                  )
                                : Container(
                                    width: Get.width * 0.8,
                                    height: Get.height * 0.07,
                                    child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Required';
                                        }
                                      },
                                      controller: widget.email != null
                                          ? PreferenceManager.getEmail()
                                          : emailController,
                                      decoration: InputDecoration(),
                                    ),
                                  ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            _controller.addressController != null
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
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
                                          keyboardType:
                                              TextInputType.streetAddress,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Required';
                                            } else {
                                              return null;
                                            }
                                          },
                                          maxLines: 2,
                                          controller:
                                              _controller.addressController,
                                          decoration: InputDecoration(),
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox()
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
                            Get.to(MapsScreen())?.then((value) {
                              PreferenceManager.setAddress(_controller
                                  .addressController!.text
                                  .toString());
                              print(
                                  'STORE ADDRESS SELLER >>>> ${_controller.addressController!.text.toString()}');
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10.sp),
                            height: Get.height * 0.075,
                            width: Get.height * 0.3,
                            decoration: BoxDecoration(
                              color: SColorPicker.white,
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black12,
                                    spreadRadius: 0.5,
                                    blurRadius: 1),
                              ],
                              borderRadius: BorderRadius.circular(10.sp),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            if (PreferenceManager.getLong() == null &&
                                PreferenceManager.getLat() == null) {
                              Get.showSnackbar(
                                GetSnackBar(
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: SColorPicker.black,
                                  duration: Duration(seconds: 5),
                                  message:
                                      'Please Add Location From Google Map',
                                ),
                              );
                            }
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              if (_image == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please Select a Image'),
                                  ),
                                );
                              }
                              if (_image != null &&
                                  PreferenceManager.getLat() != null &&
                                  PreferenceManager.getLong() != null) {
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Container(
                                        height: Get.height,
                                        width: Get.width,
                                        color: Colors.black12,
                                        child: const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    });
                                addData().then((value) {
                                  PreferenceManager.setName(
                                      nameController.text);
                                  PreferenceManager.getName();
                                  PreferenceManager.getAddress();
                                  PreferenceManager.getPhoneNumber();
                                  PreferenceManager.getUserImg();
                                  PreferenceManager.getSellerID();
                                  PreferenceManager.getLong();
                                  PreferenceManager.getLat();
                                  Get.offAll(NavigationBarScreen())
                                      ?.then((value) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  });

                                  print('Validate');
                                });
                              }
                              _formKey.currentState!.save();
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
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.commonWhiteTextColor),
                            ),
                          ),
                        ),
                        SizedBox(height: Get.height * 0.1),
                      ],
                    ),
                  );
                },
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
    print('---ADDRESS TEXT---${address.text}');
    print('---Name---${nameController.text}');
    print('---EMAIL TEXT---${emailController.text}');
    print('---PHONE---${mobilecontroller.text}');

    PreferenceManager.setUserType('Seller');
    PreferenceManager.getUserType();
    PreferenceManager.setName(nameController.text);
    PreferenceManager.getName();
    // PreferenceManager.setAddress(address.text);
    // PreferenceManager.setLong(PreferenceManager.getLong());
    // PreferenceManager.setLat(PreferenceManager.getLat());

    PreferenceManager.getLong();
    PreferenceManager.getLat();
    PreferenceManager.getAddress();
    print('USER_TYPE--${PreferenceManager.getUserType()}');
    print('NAME--${PreferenceManager.getName()}');
    print('ADDRESS--${PreferenceManager.getAddress()}');
    print('EMAIL--${PreferenceManager.getEmail()}');
    print('PHONE--${PreferenceManager.getPhoneNumber()}');
    PreferenceManager.getPhoneNumber() != null
        ? PreferenceManager.setPhoneNumber(PreferenceManager.getPhoneNumber())
        : PreferenceManager.setPhoneNumber(mobilecontroller.text);
    PreferenceManager.getEmail() != null
        ? PreferenceManager.setEmail(PreferenceManager.getEmail())
        : PreferenceManager.setEmail(emailController.text);

    print(emailController.text);
    print(mobilecontroller.text);

    CollectionReference ProfileCollection =
        bFirebaseStore.collection('SProfile');
    ProfileCollection.doc('${PreferenceManager.getUId()}').set({
      'sellerID': PreferenceManager.getUId(),
      'email': PreferenceManager.getEmail() ?? emailController.text,
      'isOnline': false,
      'phoneno': PreferenceManager.getPhoneNumber() ?? mobilecontroller.text,
      'user_name': PreferenceManager.getName(),
      'imageProfile': imageUrl ??
          'https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png',
      'address': _controller.addressController == null
          ? address.text
          : _controller.addressController!.text,
      'deviceToken': PreferenceManager.getFcmToken(),
      'isMute': false,
      'buyerTotal': 0,
      'rating': 0,
      'userType': PreferenceManager.getUserType(),
      'userDetails': 'true',
      'lat': PreferenceManager.getLat() ?? '21.2111111',
      'long': PreferenceManager.getLong() ?? '72.311111',
      'totalOrder': 0,
      'totalProduct': 0,
      'time': DateTime.now().toString(),
    }).catchError((e) => print('Error ====buyer=====>>> $e'));
  }

  bool isPasswordValid(String password) => password.length <= 20;

  bool isEmailValid(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    return regex.hasMatch(email);
  }
}
