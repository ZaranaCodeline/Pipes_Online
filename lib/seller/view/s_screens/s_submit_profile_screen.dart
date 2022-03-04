import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:pipes_online/seller/common/s_common_button.dart';
import 'package:pipes_online/seller/common/s_image.dart';
import 'package:pipes_online/seller/common/s_text_style.dart';
import 'package:pipes_online/routes/app_routes.dart';
import 'package:pipes_online/seller/view/s_screens/s_cateloge_home_screen.dart';
import 'package:pipes_online/seller/view/s_screens/s_home_screen.dart';
import 'package:sizer/sizer.dart';

import '../../../buyer/authentificaion/functions.dart';
import '../../../buyer/controller/geolocation_controller.dart';
import '../../../routes/bottom_controller.dart';
import '../../bottombar/navigation_bar.dart';

class SSubmitProfileScreen extends StatefulWidget {
  @override
  _SSubmitProfileScreenState createState() => _SSubmitProfileScreenState();
}



class _SSubmitProfileScreenState extends State<SSubmitProfileScreen> {
  bool _validate = false;

  File? _image;
  final picker = ImagePicker();

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

  TextEditingController nameController = TextEditingController();


  BottomController bottomController = Get.find();


  String location = 'Null, Press Button';
  String address = '';
  bool? serviceEnabled;
  LocationPermission? permission;
  double? latitude;
  double? longitude;
  TextEditingController addressController = TextEditingController();

  Future<Position> _getGeoLocationPosition() async {
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled!) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      print('permission:- $permission');
      if (permission == LocationPermission.denied) {
        print(
            'permission||LocationPermission:- ${permission == LocationPermission.denied}');
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print('permission:- $permission');
      print('serviceEnabled:- $serviceEnabled');
      print(
          'permission||LocationPermission:- ${permission == LocationPermission.denied}');
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print('placemarks----:$placemarks');
    Placemark place = placemarks[0];
    print('place----:$place');
    address = '  Street: ${place.street},\n'
        '  SubLocality: ${place.subLocality},\n '
        ' Locality: ${place.locality},\n '
        ' PostalCode: ${place.postalCode}, \n '
        ' Country:  ${place.country}';
    print('address-----$address');
    // setState(() {});
  }

  Future<void> finalStep() async {
    Position position = await _getGeoLocationPosition();
    setState(() {
       // address = addressController.text ;
    });
    location = 'Lat: ${position.latitude} , Long: ${position.longitude}';
    print('location: ---${location}');
    print('position: ---$position');
    GetAddressFromLatLong(position);
    print('address: ---${address}');
    address = addressController.text ;
  }

  initState() {}

  Widget build(BuildContext context) {


    return Sizer(builder: (context, orientation, deviceType) {
      GlobalKey<FormState> _formKey = GlobalKey<FormState>();

      TextEditingController nameController = TextEditingController();
      TextEditingController addressController = TextEditingController();
      void _submit() async {
        if (_formKey.currentState!.validate()) {
          print('Validate');
          Get.offAll(()=>NavigationBarScreen());
        } else {
          print('InValidate');
        }
      }

      return Builder(builder: (context) =>
      SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
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
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back_rounded,
                            color: SColorPicker.white,
                          ),
                        ),
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
                            AlertDialog(
                              title: Row(
                                children: [
                                  SCommonButton().sCommonPurpleButton(
                                    name: 'Gallery',
                                    onTap: () {
                                      // Get.back();
                                      getGalleryImage();
                                      print('edit product seller side');
                                      // Get.toNamed(SRoutes.SSubmitProfileScreen);
                                    },
                                  ),
                                  SCommonButton().sCommonPurpleButton(
                                    name: 'Camera',
                                    onTap: () {
                                      // Get.back();
                                      getCamaroImage();
                                      print('edit product seller side');
                                      // Get.toNamed(SRoutes.SSubmitProfileScreen);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          child: _image != null
                              ? Container(
                            height: 35.sp,
                            width: 35.sp,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(50)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
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
                  SizedBox(height: 25.sp),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: STextStyle.semiBold600Black13,
                      ),
                      SizedBox(height: 5.sp),
                      Container(
                        width: Get.width * 0.75,
                        // decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(10.sp),
                        //     border: Border.all(color: Colors.grey)),
                        alignment: Alignment.centerLeft,
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          autocorrect: true,
                          // autovalidateMode: AutovalidateMode.onUserInteraction,
                          autofocus: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: 'Enter Name',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          ),),
                      ),
                      SizedBox(height: 10.sp),
                      Text(
                        'Address',
                        style: STextStyle.semiBold600Black13,
                      ),
                      SizedBox(height: 5.sp),
                      Container(
                        //  height: Get.height * 0.06,
                        width: Get.width * 0.75,
                        alignment: Alignment.centerLeft,
                        child:  TextFormField(
                          // cursorColor: AppColors.primaryColor,
                          keyboardType: TextInputType.streetAddress,
                          autocorrect: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Required';
                            }
                            else{
                              return null;
                            }
                          },
                          maxLines: 3,
                          controller: addressController, decoration: InputDecoration(
                          hintText: 'Enter Address',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        ),),
                    ],
                  ),
                  SizedBox(height: 15.sp),
                  Text(
                    'Add location using google map',
                    style: STextStyle.semiBold600Black13,
                  ),
                  SizedBox(height: 15.sp),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        // progress!.showWithText('');
                        // Future.delayed(Duration(seconds: 1), () {
                        //   progress.dismiss();
                        // });
                        finalStep();
                      });
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
                        )),
                  ),
                  SizedBox(height: 25.sp),
                  if (!address.isEmpty) Text('${addressController.text}'),
                  if (!address.isEmpty) SizedBox(height: Get.height * 0.05),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.sp),
                    child: SCommonButton().sCommonPurpleButton(
                      name: 'Continue',
                      onTap: () {
                        // if (_formKey.currentState!.validate())
                        // setState(() {
                        _submit();
                        // });
                      },
                    ),
                  ),
                  SizedBox(height: Get.height * 0.1),
                ],
              ),
            ),
          ),
        ),
      ),);
    });
  }
}
