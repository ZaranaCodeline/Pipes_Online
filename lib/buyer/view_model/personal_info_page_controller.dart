import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PersonalInfoPageController extends GetxController{
  // var name = 'Getting Name..'.obs;
  TextEditingController? nameContoller ;

  void setProfileInfo(String? name1,number,address,image) {
    nameContoller!= null
        ? TextEditingController(text: name1.toString())
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