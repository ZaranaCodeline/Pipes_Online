import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../app_constant/app_colors.dart';
import '../custom_widget/widgets/custom_widget/custom_text.dart';
import 'confirm_order_page.dart';

class PaymentWidget extends StatelessWidget {
  const PaymentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          alignment: Alignment.centerLeft,
          text: 'PAYMENT',
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
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
              child: CustomText(
                  text: 'Choose payment method:',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: AppColors.secondaryBlackColor,alignment: Alignment.topLeft,),
            ),
            CustomSocialWidget(Icons.paypal_outlined, () =>  {
              Get.to(()=> ConfirmOrderPage())
            }, 'Paypal'),
            CustomSocialWidget(
                Icons.paypal_outlined, () => () {}, 'Google Pay'),
            CustomSocialWidget(Icons.payment, () => () {}, 'Amazon Pay'),
          ],
        ),
      ),
    );
  }

  Widget CustomSocialWidget(IconData icon, VoidCallback function, String name) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),

      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: AppColors.lightBlackColor,

            ),
            child: IconButton(
              onPressed: function,
              icon: Icon(
                icon,
                color: AppColors.primaryColor,size: 23,
              ),
            ),
          ),
          SizedBox(
            width: Get.width * 0.08,height: Get.height * 0.08,
          ),
          CustomText(
              text: name,
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: AppColors.secondaryBlackColor),
        ],
      ),
    );
  }
}
