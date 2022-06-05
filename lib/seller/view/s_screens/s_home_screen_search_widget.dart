import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/seller/common/s_color_picker.dart';
import 'package:pipes_online/seller/view/s_screens/s_search_screen.dart';
import 'package:sizer/sizer.dart';

class SCustomHomeSearchWidget extends StatelessWidget {
  const SCustomHomeSearchWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 15,
      width: Get.width / 1.5,
      child: CupertinoTextField(
        onTap: () {
          Get.to(() => SSearchScreen());
        },
        keyboardType: TextInputType.text,
        placeholder: 'Search items here',
        placeholderStyle: TextStyle(
          color: SColorPicker.fontGrey,
          fontSize: 12.sp,
          fontFamily: 'Ubuntu',
        ),
        prefix: Padding(
          padding: EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
          child: Icon(
            Icons.search,
            color: SColorPicker.fontGrey,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: Color(0xffF0F1F5),
        ),
      ),
    );
  }
}
