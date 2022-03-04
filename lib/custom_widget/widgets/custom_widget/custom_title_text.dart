import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pipes_online/app_constant/app_colors.dart';

class CustomTitleText extends StatelessWidget {
  CustomTitleText(
      {Key? key,
      required this.text,
      required this.fontWeight,
      required this.fontSize,
      required this.alignment})
      : super(key: key);

  String text;
  double fontSize;
  FontWeight fontWeight;
  Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text,
            style: GoogleFonts.nunito(
              textStyle: TextStyle(
                  color: AppColors.secondaryBlackColor,
                  fontSize: fontSize,
                  fontWeight: fontWeight),
            ),
          ),
          alignment: alignment,
        ),
      ],
    );
  }
}
