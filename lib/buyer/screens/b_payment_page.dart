import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/b_image.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/payment_service/payment_key.dart';
import 'package:pipes_online/payment_service/paypal_payment.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_stripe/flutter_stripe.dart' as stripe;
import '../../seller/common/s_text_style.dart';
import '../app_constant/app_colors.dart';
import 'package:http/http.dart' as http;

import 'b_confirm_order_page.dart';

class PaymentWidget extends StatefulWidget {
  final String? bName,
      bAddress,
      pSize,
      pLength,
      pWeight,
      bPhone,
      bID,
      proID,
      cartID,
      proName,
      proPrice,
      bImage,
      category,
      proImage,
      proOilPipe,
      desc;
  const PaymentWidget(
      {Key? key,
      this.bName,
      this.bAddress,
      this.bPhone,
      this.bImage,
      this.bID,
      this.proID,
      this.proName,
      this.proImage,
      this.proPrice,
      this.category,
      this.desc,
      this.pSize,
      this.pLength,
      this.pWeight,
      this.proOilPipe,
      this.cartID})
      : super(key: key);

  @override
  State<PaymentWidget> createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  bool? isLoading;
  Map<String, dynamic>? paymentIntentData;

  Future payWithPaypal() async {
    Get.to(PaypalPayment(
      amount: widget.proPrice,
      onFinish: () {
        setState(() {
          isLoading = true;
        });
        print('hello1....');
        FirebaseFirestore.instance.collection('Orders').add(
          {
            'productID': widget.proID,
            'orderID': PreferenceManager.getUId().toString(),
            'productImage': widget.proImage,
            'prdName': widget.proName,
            'size': widget.pSize,
            'length': widget.pLength,
            'weight': widget.pWeight,
            'oil': widget.proOilPipe,
            'orderStatus': 'Complate',
            'paymentMode': 'paypal',
            'price': widget.proPrice,
            'category': widget.category,
            'dsc': widget.desc,
            'createdOn': DateTime.now().toString(),
            'buyerName': widget.bName,
            'buyerImg': widget.bImage,
            'buyerAddress': widget.bAddress,
            'buyerID': widget.bID,
            'buyerPhone': widget.bPhone,
          },
        ).then(
          (value) {
            print('Order done successfully');
            Get.to(BConfirmOrderPage());

            Get.showSnackbar(
              const GetSnackBar(
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.greenAccent,
                duration: Duration(seconds: 5),
                message: 'Order done succefully',
              ),
            );
            setState(
              () {
                isLoading = false;
              },
            );
          },
        );
        print('Finish');
      },
      packageName: widget.proName,
    ));
  }

  Future payWithStrip() async {
    makePayment(widget.proPrice.toString());
  }

  Future<void> makePayment(String price) async {
    print('HELOO....');
    try {
      paymentIntentData =
          await createPaymentIntent(price, 'usd'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await stripe.Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: stripe.SetupPaymentSheetParameters(
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  applePay: true,
                  googlePay: true,
                  testEnv: true,
                  style: ThemeMode.dark,
                  merchantCountryCode: 'IN',
                  merchantDisplayName: 'ANNIE'))
          .then((value) async {
        print("payment sheet created");

        ///Change
        // await stripe.Stripe.instance.presentPaymentSheet();
        //
        // print("after payment sheet presented");
      });

      ///now finally display payment sheeet

      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await stripe.Stripe.instance
          .presentPaymentSheet(
              parameters: stripe.PresentPaymentSheetParameters(
        clientSecret: paymentIntentData!['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) {
        print('payment intent' + paymentIntentData!['id'].toString());
        print(
            'payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());

        ///Entry order
        setState(() {
          isLoading = true;
        });
        print('hello1....');
        FirebaseFirestore.instance.collection('Orders').add(
          {
            'productID': widget.proID,
            'orderID': PreferenceManager.getUId().toString(),
            'productImage': widget.proImage,
            'prdName': widget.proName,
            'size': '2 ft',
            'length': '2 kg',
            'weight': 'Pending',
            'oil': '--',
            'orderStatus': 'Complate',
            'paymentMode': 'stripe',
            'price': widget.proPrice,
            'category': widget.category,
            'dsc': widget.desc,
            'createdOn': DateTime.now().toString(),
            'buyerName': widget.bName,
            'buyerImg': widget.bImage,
            'buyerAddress': widget.bAddress,
            'buyerID': widget.bID,
            'buyerPhone': widget.bPhone,
          },
        ).then(
          (value) {
            print('Order done successfully');
            Get.back();

            Get.showSnackbar(
              const GetSnackBar(
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.greenAccent,
                duration: Duration(seconds: 5),
                message: 'Order done succefully',
              ),
            );
            setState(
              () {
                isLoading = false;
              },
            );
          },
        );
        print('Finish');

        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Transaction Successfully")));

        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
      });
    } on stripe.StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET==> $e');
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer $secretKey',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PAYMENT',
          style: STextStyle.bold700White14,
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
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: Get.height * 0.05),
          CustomText(
            text: 'Payment mode:',
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
            color: AppColors.secondaryBlackColor,
            alignment: Alignment.center,
          ),
          SizedBox(height: Get.height * 0.03),
          CustomSocialWidget(
              icon: BImagePick.PayPalIcon,
              onClicked: () {
                payWithPaypal().then((value) {
                  try {
                    FirebaseFirestore.instance
                        .collection('Cart')
                        .doc(PreferenceManager.getUId())
                        .collection('MyCart')
                        .doc(widget.cartID)
                        .delete()
                        .then((value) {
                      print('Removed from your side');
                      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      //   content: Text('Removed from Cart'),
                      //   duration: Duration(seconds: 5),
                      // ));
                    });
                  } catch (e) {
                    print(e.toString());
                  }
                });
              },

              // Get.to(() => BConfirmOrderPage()),
              name: 'Paypal'),
          GestureDetector(
            onTap: () {
              payWithStrip().then((value) {
                try {
                  FirebaseFirestore.instance
                      .collection('Cart')
                      .doc(PreferenceManager.getUId())
                      .collection('MyCart')
                      .doc(widget.cartID)
                      .delete()
                      .then((value) {})
                      .then((value) {
                    print('Removed from your side');
                    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    //   content: Text('Removed from Cart'),
                    //   duration: Duration(seconds: 5),
                    // ));
                  });
                } catch (e) {
                  print(e.toString());
                }
              });
            },
            child: Container(
              height: Get.height * 0.06,
              decoration: BoxDecoration(
                  color: Color(0xFFEBEBEB),
                  borderRadius: BorderRadius.circular(Get.width)),
              margin: EdgeInsets.symmetric(
                  horizontal: Get.width * 0.2, vertical: Get.height * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      'assets/images/png/stripe.png',
                      width: 20.sp,
                      height: 20.sp,
                    ),
                  ),
                  SizedBox(
                    width: 15.sp,
                  ),
                  CustomText(
                      text: 'Stripe',
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: AppColors.secondaryBlackColor),
                ],
              ),
            ),
          ),

          // CustomSocialWidget(
          //     icon: Icon(Icons.payment_outlined).toString(),
          //     onClicked: () {
          //       payWithStrip();
          //     },
          //     name: 'Stripe'),
        ],
      ),
    );
  }

  Widget CustomSocialWidget(
      {String? icon, VoidCallback? onClicked, String? name}) {
    return GestureDetector(
      onTap: onClicked,
      child: Container(
        height: Get.height * 0.06,
        decoration: BoxDecoration(
            color: Color(0xFFEBEBEB),
            borderRadius: BorderRadius.circular(Get.width)),
        margin: EdgeInsets.symmetric(
            horizontal: Get.width * 0.2, vertical: Get.height * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon!,
              width: 20.sp,
              height: 20.sp,
            ),
            SizedBox(
              width: 15.sp,
            ),
            CustomText(
                text: name!,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: AppColors.secondaryBlackColor),
          ],
        ),
      ),
    );
  }
}
