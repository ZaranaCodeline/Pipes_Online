import 'dart:math';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/controller/geolocation_controller.dart';
import 'package:pipes_online/buyer/custom_widget/widgets/custom_text.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/b_login_screen.dart';
import 'package:pipes_online/routes/app_routes.dart';

import 'package:sizer/sizer.dart';
import '../../../routes/bottom_controller.dart';
import '../../../seller/view/s_screens/s_color_picker.dart';
import '../../../seller/view/s_screens/s_image.dart';
import '../../../seller/view/s_screens/s_text_style.dart';
import '../../../shared_prefarence/shared_prefarance.dart';
import '../../app_constant/auth.dart';

import '../b_image.dart';
import 'register_repo.dart';

class BSignUpRagistraionScreen extends StatefulWidget {


  const BSignUpRagistraionScreen({Key? key,}) : super(key: key);

  @override
  _BSignUpRagistraionScreenState createState() => _BSignUpRagistraionScreenState();
}

class _BSignUpRagistraionScreenState extends State<BSignUpRagistraionScreen> {

  File? _image;
  FirebaseAuth _auth = FirebaseAuth.instance;
  GeolocationController _controller = Get.find();
  BottomController homeController = Get.find();
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile!.path);
      print(_image);
    });
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

  GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController addController = TextEditingController();
  TextEditingController mobileCnt = TextEditingController();

  BottomController bottomController = Get.find();
  String? Img;
  bool selected = false;
  int hobbySelected = 0;
  String? _dropDownValue;
  bool? password;
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController phn = TextEditingController();
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  String _userName = '';

  @override
  void initState() {

    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
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
                        'sign up'.toUpperCase(),
                        style: STextStyle.bold700White14,
                      ),
                      SizedBox(width: 20.sp),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: formGlobalKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child:Center(
                              child: Column(
                                children: [
                                  //assets/images/profile.png
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => SimpleDialog(
                                          children: [
                                            Container(
                                              height: 125.sp,
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
                                                    height: 60.sp,
                                                    decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                            begin: Alignment.centerLeft,
                                                            colors: [
                                                              AppColors.primaryColor,
                                                              AppColors
                                                                  .offLightPurpalColor,
                                                            ]),
                                                        borderRadius:
                                                        BorderRadius.circular(25)),
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
                                                    height: 60.sp,
                                                    decoration: BoxDecoration(
                                                        gradient: LinearGradient(
                                                            begin: Alignment.centerLeft,
                                                            colors: [
                                                              AppColors.primaryColor,
                                                              AppColors
                                                                  .offLightPurpalColor,
                                                            ]),
                                                        borderRadius:
                                                        BorderRadius.circular(25)),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    child:   Container(
                                      height:50.sp,
                                      width:50.sp,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child:_image==null?
                                        SvgPicture.asset(
                                          "${BImagePick.PersonIcon}",color: AppColors.primaryColor.withOpacity(0.5)
                                        )
                                        // Image.network(Img==null?'${BImagePick.PersonIcon}':Img!,fit: BoxFit.fill,)
                                            : Image.file(_image!,fit: BoxFit.fill),
                                      ),

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
                          ),
                        ),

                        // Text(
                        //   'Registration',
                        //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                        // ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: fname,
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return 'This field is required';
                                  } else if (!RegExp('[a-zA-Z]').hasMatch(value)) {
                                    return 'please enter valid name';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.name,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(20)
                                ],
                                onChanged: (value) => _userName = value,
                                decoration: InputDecoration(
                                    hintText: 'First Name',
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.blue.withOpacity(0.5),
                                            width: 2)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(0.5),
                                            width: 2)),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                      BorderSide(color: Colors.red, width: 2),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                      BorderSide(color: Colors.red, width: 2),
                                    )),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.trim().isEmpty) {
                                    return 'This field is required';
                                  } else if (!RegExp('[a-zA-Z]').hasMatch(value)) {
                                    return 'please enter valid name';
                                  }
                                  return null;
                                },
                                onTap: () {},
                                controller: lname,
                                decoration: InputDecoration(
                                    hintText: 'Last Name',
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.blue.withOpacity(0.5),
                                            width: 2)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(0.5),
                                            width: 2)),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                      BorderSide(color: Colors.red, width: 2),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide:
                                      BorderSide(color: Colors.red, width: 2),
                                    )),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                              hintText: 'Email',
                              filled: true,
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.blue.withOpacity(0.5), width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.5), width: 2)),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red, width: 2),
                              )),
                          validator: (email) {
                            if (isEmailValid(email!)) {
                              return null;
                            } else {
                              return 'Enter a valid email address';
                            }
                          },
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
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
                          controller: phn,
                          keyboardType: TextInputType.phone,
                          inputFormatters: [LengthLimitingTextInputFormatter(10)],
                          decoration: InputDecoration(
                              hintText: 'Mobile no.',
                              filled: true,
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.blue.withOpacity(0.5), width: 2)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Colors.grey.withOpacity(0.5), width: 2)),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Colors.red, width: 2),
                              )),
                        ),

                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        TextFormField(
                            obscureText: selected ? false : true,
                            controller: pass,
                            decoration: InputDecoration(
                                hintText: 'Password',
                                filled: true,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    selected == false
                                        ? Icons.remove_red_eye
                                        : Icons.remove_red_eye_outlined,
                                    color: selected ? Colors.black : Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selected = !selected;
                                    });
                                  },
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.red, width: 2),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.blue.withOpacity(0.5),
                                        width: 2)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(0.5),
                                        width: 2)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                    BorderSide(color: Colors.red, width: 2))),
                            validator: (password) {
                              if (password!.isEmpty) {
                                return 'Please enter password';
                              } else if (!isPasswordValid(password)) {
                                return 'Enter a valid password';
                              }
                              return null;
                            }),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),

                        InkWell(
                          child: Container(
                            width: 400,
                            height: 50,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                )),
                          ),
                          onTap: () async {

                            if (formGlobalKey.currentState!.validate()) {
                              // _register();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                  content: Text('Processing Data'),
                                  backgroundColor:AppColors.primaryColor,
                                ),
                              );
                              formGlobalKey.currentState!.save();
                              RegisterRepo.emailRegister(
                                  email: email.text, pass: pass.text)
                                  .then((value) async {
                                await addData();
                              });

                              Get.to(LoginScreen());
                            }
                          },
                        ),
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                        Center(
                          child: RichText(

                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Already registered?',
                                  style: STextStyle.regular400Black13,
                                ),

                                TextSpan(
                                    text: '  Log In',
                                    style: STextStyle.medium400Purple13,
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        print('aaa');
                                       Get.off(LoginScreen());
                                      }
                                ),
                              ],
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
        context: context, file: _image, fileName: '${email.text}_profile.jpg');
    RegisterRepo.currentUser()
        .then((value) {
      CollectionReference userCollection =
      kFirebaseStore.collection('Profile');
      userCollection.doc('${PreferenceManager.getUId()}').set({
        'email': email.text,
        'password': pass.text,
        'phoneno': phn.text,
        'firstname': fname.text,
        'lastname': lname.text,
        'imageProfile': imageUrl,
        'time':DateTime.now(),
      });
    })
        .catchError((e) => print('Error =========>>> $e'))
         .then((value) => Navigator.push(context, MaterialPageRoute(
      builder: (context) {
         return LoginScreen();
      },
    )));
  }

  bool isPasswordValid(String password) => password.length <= 8;

  bool isEmailValid(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    return regex.hasMatch(email);
  }


}
