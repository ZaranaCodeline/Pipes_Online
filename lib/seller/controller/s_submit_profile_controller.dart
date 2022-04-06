import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pipes_online/routes/bottom_controller.dart';

class SSubmitProfileController extends GetxController{
  File?  image;

  final picker = ImagePicker();

  Future getGalleryImage() async {
    var imaGe = await picker.getImage(source: ImageSource.gallery);
      if (imaGe != null) {
         image = File(imaGe.path);
        print("=============ImagePath==========${imaGe.path}");
        imageCache!.clear();
      } else {
        print('no image selected');
      }
  }

  Future getCamaroImage() async {
    var imaGe = await picker.getImage(source: ImageSource.camera);
    print("==========ImagePath=============${imaGe!.path}");
      if (imaGe != null) {
         image = File(imaGe.path);
        print("===========ImagePath============${image}");
        print("=============ImagePath==========${imaGe.path}");
        imageCache!.clear();
      } else {
        print('no image selected');
      }

  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>() ;
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController() ;
  BottomController bottomController = Get.find();
}