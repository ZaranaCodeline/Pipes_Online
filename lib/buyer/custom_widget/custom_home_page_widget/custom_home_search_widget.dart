import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomHomeSearchWidget extends StatelessWidget {
  const CustomHomeSearchWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Container(
        margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        height: Get.height / 18,
        width: Get.width / 1.4,
        child: CupertinoTextField(
          keyboardType: TextInputType.text,
          placeholder: 'Filtrar por nombre o nombre corto',
          placeholderStyle: const TextStyle(
            color: Color(0xffC4C6CC),
            fontSize: 14.0,
            fontFamily: 'Brutal',
          ),
          prefix: const Padding(
            padding:
            EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
            child: Icon(
              Icons.search,
              color: Color(0xffC4C6CC),
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            color: Color(0xffF0F1F5),
          ),
        ),
      ),
    );
  }
}
