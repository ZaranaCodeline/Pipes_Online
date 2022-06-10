import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileViewModel extends GetxController {
  TextEditingController? firstnameController;
  TextEditingController? emailController;
  TextEditingController? addressController;
  TextEditingController? phoneController;
  String? image1;

  void setValueToController(
    String name,
    String phone,
    String email,
    String address,
    dynamic image2,
  ) {
    firstnameController = TextEditingController(text: name);
    emailController = TextEditingController(text: phone);
    addressController = TextEditingController(text: email);
    phoneController = TextEditingController(text: address);
    image1 = image2;
  }
}
