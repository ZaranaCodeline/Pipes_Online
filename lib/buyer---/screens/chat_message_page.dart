import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_constant/app_colors.dart';
import '../custom_widget/widgets/custom_widget/custom_text.dart';

class ChatMessagePage extends StatelessWidget {
  const ChatMessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Stack(
          children: [
            Column(
              children: [
                CustomText(
                  alignment: Alignment.center,
                  text: 'Jan Doe',
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                  color: AppColors.commonWhiteTextColor,
                ),
                CustomText(
                  alignment: Alignment.center,
                  text: 'Online',
                  fontWeight: FontWeight.w400,
                  fontSize: 18,
                  color: Colors.green,
                ),
              ],
            ),
            CircleAvatar(
              child: Image.asset(
                'assets/images/cat_1.png',
                width: 50,
                height: 50,
                fit: BoxFit.fill,
              ),
              backgroundColor: AppColors.offWhiteColor,
            ),
            Positioned(
              left: 32,
              top: 0,
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.green,
                ),
              ),
            ),
            Positioned(
              right: 20,
              child: Container(
                width: 40,
                height: 38,
                decoration: BoxDecoration(
                    color: AppColors.commonWhiteTextColor,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      new BoxShadow(blurRadius: 0.1),
                    ]),
                child: TextButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.call,
                      color: AppColors.secondaryBlackColor,
                    )),
              ),
            )
          ],
        ),
        backgroundColor: AppColors.primaryColor,
        toolbarHeight: Get.height * 0.1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Column(

                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    height: 50,
                    width: 200,
                    child: const Text(
                      'Hii',
                    ),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.offLightPurpalColor,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(0),bottomRight: Radius.circular(15),
                            topLeft: Radius.circular(20))),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    width: 200,
                    child: const Text(
                      '01:00',
                    ),
                    alignment: Alignment.center,
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.topRight,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.check),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        height: 50,
                        width: 200,
                        child: const Text(
                          'Hii',
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AppColors.lightBlackColor,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20))),
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    width: 200,
                    child: const Text(
                      '01:00',
                    ),
                    alignment: Alignment.centerRight,
                  ),
                ],
              ),
            ),
            Container(
              height: 100,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: AppColors.offWhiteColor,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:   BorderSide(
                      width: 3,color: AppColors.offLightPurpalColor,
                      style: BorderStyle.solid,
                    ),
                  ),
                  hintText: 'Message...',
                  hintStyle: TextStyle(color:AppColors.hintTextColor),
                  prefixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.insert_link_outlined,
                        color: AppColors.primaryColor,
                      )),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RawMaterialButton(
                      constraints: BoxConstraints(minWidth: 0),
                      onPressed: () {},
                      elevation: 2.0,
                      fillColor: AppColors.commonWhiteTextColor,
                      child: Icon(Icons.send,
                          size: 21.0, color: AppColors.primaryColor),
                      padding: EdgeInsets.all(10.0),
                      shape: CircleBorder(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
