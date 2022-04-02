import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/custom_widget/widgets/custom_text.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/b_navigationbar.dart';
import 'package:pipes_online/buyer/screens/maps_screen.dart';
import 'package:pipes_online/seller/bottombar/s_navigation_bar.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:pipes_online/seller/common/s_common_button.dart';
import 'package:pipes_online/seller/common/s_image.dart';
import 'package:pipes_online/seller/common/s_text_style.dart';
import 'package:sizer/sizer.dart';
import '../../../routes/bottom_controller.dart';

class SSubmitProfileScreen extends StatefulWidget {


  const SSubmitProfileScreen({Key? key,}) : super(key: key);

  @override
  _SSubmitProfileScreenState createState() => _SSubmitProfileScreenState();
}

class _SSubmitProfileScreenState extends State<SSubmitProfileScreen> {

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

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  BottomController bottomController = Get.find();

  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      void _submit() async {
        if (_formKey.currentState!.validate()) {
          print('Validate');
          Get.offAll(()=>NavigationBarScreen());
        } else {
          print('InValidate');
        }
      }

      return Builder(
        builder: (context) => SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Form(
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
                                                getGalleryImage();
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
                                                getCamaroImage();
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
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Ubuntu-Bold'),
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
                          alignment: Alignment.centerLeft,
                          child: TextFormField(
                            keyboardType: TextInputType.name,
                            autocorrect: true,
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
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
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
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
                          child: TextFormField(
                            // cursorColor: AppColors.primaryColor,
                            keyboardType: TextInputType.streetAddress,
                            autocorrect: true,
                            autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Required';
                              } else {
                                return null;
                              }
                            },
                            maxLines: 3,
                            controller: addressController,
                            decoration: InputDecoration(
                              hintText: 'Enter Address',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
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
                        print('is enterggg');
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

                    // if (!address.isEmpty) SizedBox(height: Get.height * 0.05),
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
        ),
      );
    });
  }
}
