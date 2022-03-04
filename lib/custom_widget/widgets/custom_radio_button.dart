import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/app_constant/app_colors.dart';
import 'package:pipes_online/custom_widget/widgets/custom_widget/custom_text.dart';

class CustomRadioButton extends StatefulWidget {
  const CustomRadioButton({Key? key}) : super(key: key);

  @override
  _CustomRadioButtonState createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  int? selectedRadio;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedRadio = 0;
  }

  setSelectedRadio(dynamic a) {
    setState(() {
      selectedRadio = a;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  CustomRadioBtn(AppColors.primaryColor, 1),
                  CustomText(
                      text: 'Buyer',
                      fontWeight: FontWeight.w600,
                      fontSize: 26,
                      color: AppColors.primaryColor),
                ],
              ),
              SizedBox(
                width: Get.width * 0.1,
              ),
              Row(
                children: [
                  CustomRadioBtn(AppColors.primaryColor, 2),
                  CustomText(
                      text: 'Seller',
                      fontWeight: FontWeight.w600,
                      fontSize: 26,
                      color: AppColors.primaryColor),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget CustomRadioBtn(Color color, int groupVal) {
    return Radio(
      fillColor: MaterialStateColor.resolveWith((states) => color),
      value: groupVal,
      groupValue: selectedRadio,
      onChanged: (val) {
        print('$val');
        setSelectedRadio(val);
      },
    );
  }
}
