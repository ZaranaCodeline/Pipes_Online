import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  CustomText(
      {Key? key,
        required this.text,
        this.alignment,
        this.textAlign,
        this.textDecoration,
        this.textOverflow,
        required this.fontWeight,
        required this.fontSize,
         this.max,
        required this.color})
      : super(key: key);
  String text;
  Color color;
  int? max;
  FontWeight fontWeight;
  double fontSize;
  Alignment? alignment;
  TextAlign? textAlign;
  TextDecoration? textDecoration;
  TextOverflow? textOverflow;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,maxLines: max,
        style: GoogleFonts.ubuntu(
          textStyle: TextStyle(
            color: color,
            fontWeight: fontWeight,
            fontSize: fontSize,
            decoration: textDecoration,

          ),
        ),
        textAlign: textAlign,
        overflow:textOverflow ,
      ),
      alignment: alignment,
    );
  }
}
