import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PersonalInfoPageController extends GetxController{
  // var name = 'Getting Name..'.obs;
  TextEditingController? nameContoller ;
  TextEditingController? addressController ;
  TextEditingController? phonenoController ;
  TextEditingController? ImgController ;

  void setProfileInfo(String? name,number,address,image) {
    nameContoller!= null
        ? TextEditingController(text: name.toString())
        : TextEditingController();

    print('name:${nameContoller!.text}');
    update();
  }
  String _name='';

  String get name => _name;

  set name(String value) {
    _name = value;
    update();
  }
}