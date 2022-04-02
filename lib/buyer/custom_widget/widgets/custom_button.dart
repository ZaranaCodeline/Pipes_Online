import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app_constant/app_colors.dart';

class Custombutton extends StatelessWidget {
  Custombutton(
      {Key? key,
      required this.name,
      required this.function,
      required this.height,
      required this.width})
      : super(key: key);
  String name;
  dynamic function;
  double height, width = Get.width / 3;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // width: Get.width / 3,
        // height: Get.height * 0.07,
        width: width,
        height: height,
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: AppColors.primaryColor,
          onPressed: function,
          child: Text(
            name,
            style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.commonWhiteTextColor),
            ),
          ),
        ),
      ),
    );
  }
}
