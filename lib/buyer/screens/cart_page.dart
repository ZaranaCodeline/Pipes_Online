import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../app_constant/app_colors.dart';
import '../custom_widget/widgets/custom_widget/custom_text.dart';

class CartPage extends StatelessWidget {
  String dropdownvalue = 'select';
  var items = [
    'select',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          alignment: Alignment.centerLeft,
          text: 'YOUR CART',
          fontWeight: FontWeight.w700,
          fontSize: 18,
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
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset(
                                'assets/images/cart_page.png',
                                fit: BoxFit.cover,
                                width: 130,
                                height: 95,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                children: [
                                  CustomText(
                                    text: 'Round',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    color: AppColors.primaryColor,
                                    alignment: Alignment.topLeft,
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  CustomText(
                                    text: 'ABC Pipe',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: AppColors.secondaryBlackColor,
                                    alignment: Alignment.centerLeft,
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  CustomText(
                                    text: '\$10/ Feet',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: AppColors.secondaryBlackColor,
                                    alignment: Alignment.centerLeft,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                              child: Container(
                            width: 50,
                            height: 38,
                            decoration: BoxDecoration(
                                color: AppColors.commonWhiteTextColor,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  new BoxShadow(blurRadius: 0.1),
                                ]),
                            child: TextButton(
                                onPressed: () {},
                                child: SvgPicture.asset(
                                    'assets/images/delete_icon.svg')),
                          )),
                        ],
                      ),
                    ),
                    CustomDropDownWidget('Size :      '),
                    CustomDropDownWidget('Length : '),
                    CustomDropDownWidget('Weight :'),
                    CustomDropDownWidget('Oil :        '),
                  ],
                ),
              ),
              Card(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          CustomText(
                            text: 'Address : ',
                            fontWeight: FontWeight.w600,
                            fontSize: 22,
                            color: AppColors.secondaryBlackColor,
                            alignment: Alignment.topLeft,
                          ),
                          SizedBox(
                            height: Get.height * 0.01,
                          ),
                          Card(
                            elevation: 4,
                            borderOnForeground: true,
                            child: const TextField(
                              maxLines: 3,
                              keyboardType: TextInputType.multiline,
                              // minLines: 1,
                            ),
                          ),
                          Card(
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),

                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      CustomText(
                                          text: 'Cart total',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                          color: AppColors.secondaryBlackColor),
                                      CustomText(
                                          text: '\$10',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                          color: AppColors.secondaryBlackColor),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){},
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.primaryColor,

                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        CustomText(
                                            text: 'Checkout Now',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                            color: AppColors.commonWhiteTextColor),
                                        CustomText(
                                            text: 'Total: \$10',
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                            color: AppColors.commonWhiteTextColor),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget CustomDropDownWidget(String keyName) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          CustomText(
              text: keyName,
              fontWeight: FontWeight.w600,
              fontSize: 22,
              color: AppColors.secondaryBlackColor),
          SizedBox(
            width: Get.width * .1,
          ),
          Card(
            elevation: 0,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), boxShadow: const []),

              // decoration: BoxDecoration(
              //     color: AppColors.commonWhiteTextColor,
              //     borderRadius: BorderRadius.circular(5),
              //     boxShadow: [
              //       new BoxShadow(blurRadius: 0.1),
              //     ]),
              child: DropdownButton(
                value: dropdownvalue,
                icon: Icon(
                  Icons.arrow_drop_down_outlined,
                  color: AppColors.secondaryBlackColor,
                  size: 30,
                ),
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: CustomText(
                      text: items,
                      color: AppColors.hintTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      textDecoration: TextDecoration.none,
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  // setState(() {
                  //   dropdownvalue = newValue!;
                  // });
                },
              ),
            ),
          ),
          // CustomDropDownWidget(),
        ],
      ),
    );
  }
}
