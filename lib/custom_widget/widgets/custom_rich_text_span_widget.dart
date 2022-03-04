import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/app_constant/app_colors.dart';

class CustomRichTextSpanWidget extends StatelessWidget {
    CustomRichTextSpanWidget(
      {Key? key, required this.color1,required this.color2, required this.fontsize,required this.name1, required this.name2,})
      : super(key: key);
  Color color1 , color2;
  String name1, name2;
  double fontsize;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
        child: RichText(
          textAlign: TextAlign.left,
          text: TextSpan(
            children: [
              TextSpan(
                text: name1,
                style: TextStyle(fontSize: fontsize,
                    color: color1),),
              TextSpan(
                text: name2,
                style: TextStyle(fontSize: fontsize, fontWeight: FontWeight.w400,
                    color: color2),),
            ],
          ),
        ),
    );
  }
}
