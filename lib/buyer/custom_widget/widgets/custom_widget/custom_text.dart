import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  CustomText(
      {Key? key,
      required this.text,
      this.alignment,
      this.textAlign,
      this.textDecoration,
      required this.fontWeight,
      required this.fontSize,
      required this.color})
      : super(key: key);
  String text;
  Color color;
  FontWeight fontWeight;
  double fontSize;
  Alignment? alignment;
  TextAlign? textAlign;
  TextDecoration? textDecoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        style: GoogleFonts.nunito(
          textStyle: TextStyle(
            color: color,
            fontWeight: fontWeight,
            fontSize: fontSize,
            decoration: textDecoration,
          ),
        ),
        textAlign: textAlign,
      ),
      alignment: alignment,
    );
  }
}
