import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_constant/app_colors.dart';
import '../custom_widget/widgets/custom_widget/custom_button.dart';
import '../custom_widget/widgets/custom_widget/custom_text.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          alignment: Alignment.centerLeft,
          text: 'CONFIRM ORDER',
          fontWeight: FontWeight.w700,
          fontSize: 22,
          color: AppColors.commonWhiteTextColor,
        ),
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: Get.height * 0.1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child:  const TextField(
              decoration: InputDecoration(
                hintText: 'Enter Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              // minLines: 1,
            ),
          ),
          Custombutton(
            name: 'Get Started',
            function: (){},
                // Get.to(() => HomePage()),
            height: Get.height * 0.07,
            width: Get.width / 2,
          ),
        ],
      ),
    );
  }
}
