import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app_constant/app_colors.dart';

class CustomCupertinoFeildText extends StatelessWidget {
    CustomCupertinoFeildText({Key? key, required this.placeholder}) : super(key: key);
  String placeholder;
  // Color color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: CupertinoTextField(
          keyboardType: TextInputType.text,
          placeholder: placeholder,
          placeholderStyle: GoogleFonts.nunito(
            textStyle: TextStyle(
              color: AppColors.secondaryBlackColor,
              fontSize: 14.0,
            ),
          ),
          suffix: const Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
            child: Icon(
              Icons.edit,
              color: Colors.black45,
            ),
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.hintTextColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(15.0),
            color: AppColors.offWhiteColor,
          ),
        ),
      ),
    );
  }
}
