// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:pipes_online/buyer/buyer_common/b_image.dart';
// import 'package:pipes_online/buyer/payment_service/paypal_payment.dart';
// import 'package:sizer/sizer.dart';
//
// import '../../seller/common/s_text_style.dart';
// import '../app_constant/app_colors.dart';
// import '../custom_widget/widgets/custom_text.dart';
// import 'b_confirm_order_page.dart';
//
// class PaymentWidget extends StatelessWidget {
//   const PaymentWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'PAYMENT',
//           style: STextStyle.bold700White14,
//         ),
//         backgroundColor: AppColors.primaryColor,
//         toolbarHeight: Get.height * 0.1,
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(25),
//           ),
//         ),
//       ),
//       body: Column(
//         // mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(height: Get.height * 0.05),
//           CustomText(
//             text: 'Payment mode:',
//             fontWeight: FontWeight.w600,
//             fontSize: 14.sp,
//             color: AppColors.secondaryBlackColor,
//             alignment: Alignment.center,
//           ),
//           SizedBox(height: Get.height * 0.03),
//
//           CustomSocialWidget(
//               icon: BImagePick.PayPalIcon,
//               onClicked: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => PaypalPayment(
//                         onFinish: (number) {
//                           print('number id:' + number);
//                         },
//                       ),
//                     ));
//               },
//                   // Get.to(() => BConfirmOrderPage()),
//               name: 'Paypal'),
//           CustomSocialWidget(
//               icon: BImagePick.GooglePayIcon,
//               onClicked: () => Get.to(() => BConfirmOrderPage()),
//               name: 'Google Pay'),
//           CustomSocialWidget(
//               icon: BImagePick.AmazonPayIcon,
//               onClicked: () => Get.to(() => BConfirmOrderPage()),
//               name: 'Amazon Pay'),
//         ],
//       ),
//     );
//   }
//
//   Widget CustomSocialWidget(
//       {String? icon,VoidCallback? onClicked, String? name}) {
//     return GestureDetector(
//       onTap: onClicked,
//       child: Container(
//         height: Get.height * 0.06,
//         decoration: BoxDecoration(
//             color: Color(0xFFEBEBEB),
//             borderRadius: BorderRadius.circular(Get.width)),
//         margin: EdgeInsets.symmetric(
//             horizontal: Get.width * 0.2, vertical: Get.height * 0.02),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SvgPicture.asset(
//               icon!,
//               width: 20.sp,
//               height: 20.sp,
//             ),
//             SizedBox(
//               width: 15.sp,
//             ),
//             CustomText(
//                 text: name!,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 14.sp,
//                 color: AppColors.secondaryBlackColor),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/app_colors.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/screens/b_home_screen_widget.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/b_navigationbar.dart';
import 'package:pipes_online/buyer/screens/custom_widget/custom_text.dart';
import 'package:pipes_online/seller/view/s_screens/s_text_style.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';
import 'package:sizer/sizer.dart';
import 'package:upi_pay/upi_pay.dart';

import 'bottom_bar_screen_page/widget/b_home_bottom_bar_route.dart';

class Screen extends StatefulWidget {
  final String? price;
  final String? name;
  final String? desc;
  final String? image;
  final String? category;
  final String? productID;

  const Screen({
    Key? key,
    this.price,
    this.name,
    this.desc,
    this.image,
    this.category,
    this.productID,
  }) : super(key: key);
  @override
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  String? _upiAddrError;

  final _upiAddressController = TextEditingController();
  final _amountController = TextEditingController();
  bool isLoading = false;
  bool _isUpiEditable = false;
  List<ApplicationMeta>? _apps;

  String? buyerName;
  String? buyerPhone;
  String? buyerAddress;
  String? buyerID;
  String? buyerImage;

  Future<void> getData() async {
    CollectionReference profileCollection =
        bFirebaseStore.collection('BProfile');
    print('demo.....');
    final user = await profileCollection.doc(PreferenceManager.getUId()).get();
    Map<String, dynamic>? getUserData = user.data() as Map<String, dynamic>?;
    setState(() {
      print('======ID=====${PreferenceManager.getUId()}');
      print('buyer details:- ${getUserData}');
      buyerImage = getUserData?['imageProfile'];
      buyerID = PreferenceManager.getUId();
      buyerAddress = getUserData?['address'];
      buyerPhone = getUserData?['phoneno'];
      buyerName = getUserData?['user_name'];
    });
  }

  @override
  void initState() {
    super.initState();
    getData();

    _amountController.text =
        (Random.secure().nextDouble() * 10).toStringAsFixed(2);

    Future.delayed(Duration(milliseconds: 0), () async {
      _apps = await UpiPay.getInstalledUpiApplications(
          statusType: UpiApplicationDiscoveryAppStatusType.all);
      setState(() {});
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    _upiAddressController.dispose();
    super.dispose();
  }

  void _generateAmount() {
    setState(() {
      _amountController.text =
          (Random.secure().nextDouble() * 10).toStringAsFixed(2);
    });
  }

  Future<void> _onTap(ApplicationMeta app) async {
    final err = _validateUpiAddress(_upiAddressController.text);
    if (err != null) {
      setState(() {
        _upiAddrError = err;
      });
      return;
    }
    setState(() {
      _upiAddrError = null;
    });

    final transactionRef = Random.secure().nextInt(1 << 32).toString();
    print("Starting transaction with id $transactionRef");

    final a = await UpiPay.initiateTransaction(
        amount: _amountController.text,
        app: app.upiApplication,
        receiverName: 'Sharad',
        receiverUpiAddress: _upiAddressController.text,
        transactionRef: transactionRef,
        transactionNote: 'UPI Payment',
        url:
            'https://www.npci.org.in/sites/default/files/UPI%20Linking%20Specs_ver%201.6.pdf'

        // merchantCode: '7372'
        );

    print(a);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.to(BottomNavigationBarScreen());
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text(
            'PAYMENT'.toUpperCase(),
            style: STextStyle.bold700White14,
          ),
          centerTitle: true,
          backgroundColor: AppColors.primaryColor,
          toolbarHeight: Get.height * 0.1,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(25),
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: <Widget>[
              _vpa(),
              if (_upiAddrError != null) _vpaError(),
              _amount(),
              if (Platform.isIOS) _submitButton(),
              Platform.isAndroid ? _androidApps() : _iosApps(),
              SizedBox(
                height: Get.height * 0.1,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primaryColor,
                ),
                child: GestureDetector(
                  onTap: () {
                    Get.to(Screen(
                      category: widget.category,
                      desc: widget.desc,
                      image: widget.image,
                      price: widget.price,
                      name: widget.name,
                      productID: widget.productID,
                    ));
                    setState(() {
                      isLoading = true;
                    });
                    print('hello1....');
                    FirebaseFirestore.instance.collection('Orders').add(
                      {
                        'productID': widget.productID,
                        'orderID': PreferenceManager.getUId().toString(),
                        'productImage': widget.image,
                        'prdName': widget.name,
                        'size': '2 ft',
                        'length': '2 kg',
                        'weight': 'Pending',
                        'oil': '--',
                        'orderStatus': 'Pending',
                        'paymentMode': 'upay',
                        'price': widget.price,
                        'category': widget.category,
                        'dsc': widget.desc,
                        'createdOn': DateTime.now().toString(),
                        'buyerName': buyerName,
                        'buyerImg': buyerImage,
                        'buyerAddress': buyerAddress,
                        'buyerID': buyerID,
                        'buyerPhone': buyerPhone,
                      },
                    ).then(
                      (value) {
                        print('Order done successfully');
                        Get.showSnackbar(
                          GetSnackBar(
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
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomText(
                          text: 'Pay Now : ',
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: AppColors.commonWhiteTextColor),
                      CustomText(
                          text: widget.price.toString(),
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: AppColors.commonWhiteTextColor),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _vpa() {
    return Container(
      margin: EdgeInsets.only(top: 32),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextFormField(
              controller: _upiAddressController,
              enabled: _isUpiEditable,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'address@upi',
                labelText: 'Receiving UPI Address',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            child: IconButton(
              icon: Icon(
                _isUpiEditable ? Icons.check : Icons.edit,
              ),
              onPressed: () {
                setState(() {
                  _isUpiEditable = !_isUpiEditable;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _vpaError() {
    return Container(
      margin: EdgeInsets.only(top: 4, left: 12),
      child: Text(
        _upiAddrError!,
        style: TextStyle(color: Colors.red),
      ),
    );
  }

  Widget _amount() {
    return Container(
      margin: EdgeInsets.only(top: 32),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _amountController,
              // readOnly: true,
              // enabled: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Amount',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 8),
            child: IconButton(
              icon: Icon(Icons.loop),
              onPressed: _generateAmount,
            ),
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Container(
      margin: EdgeInsets.only(top: 32),
      child: Row(
        children: <Widget>[
          Expanded(
            child: MaterialButton(
              onPressed: () async => await _onTap(_apps![0]),
              child: Text('Initiate Transaction',
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: Colors.white)),
              color: Theme.of(context).accentColor,
              height: 48,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _androidApps() {
    return Container(
      margin: EdgeInsets.only(top: 32, bottom: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 12),
            child: Text(
              'Pay Using',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          if (_apps != null) _appsGrid(_apps!.map((e) => e).toList()),
        ],
      ),
    );
  }

  Widget _iosApps() {
    return Container(
      margin: EdgeInsets.only(top: 32, bottom: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 24),
            child: Text(
              'One of these will be invoked automatically by your phone to '
              'make a payment',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 12),
            child: Text(
              'Detected Installed Apps',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          if (_apps != null) _discoverableAppsGrid(),
          Container(
            margin: EdgeInsets.only(top: 12, bottom: 12),
            child: Text(
              'Other Supported Apps (Cannot detect)',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          if (_apps != null) _nonDiscoverableAppsGrid(),
        ],
      ),
    );
  }

  GridView _discoverableAppsGrid() {
    List<ApplicationMeta> metaList = [];
    _apps!.forEach((e) {
      if (e.upiApplication.discoveryCustomScheme != null) {
        metaList.add(e);
      }
    });
    return _appsGrid(metaList);
  }

  GridView _nonDiscoverableAppsGrid() {
    List<ApplicationMeta> metaList = [];
    _apps!.forEach((e) {
      if (e.upiApplication.discoveryCustomScheme == null) {
        metaList.add(e);
      }
    });
    return _appsGrid(metaList);
  }

  GridView _appsGrid(List<ApplicationMeta> apps) {
    apps.sort((a, b) => a.upiApplication
        .getAppName()
        .toLowerCase()
        .compareTo(b.upiApplication.getAppName().toLowerCase()));
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      // childAspectRatio: 1.6,
      physics: NeverScrollableScrollPhysics(),
      children: apps
          .map(
            (it) => Material(
              key: ObjectKey(it.upiApplication),
              // color: Colors.grey[200],
              child: InkWell(
                onTap: Platform.isAndroid ? () async => await _onTap(it) : null,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    it.iconImage(48),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      alignment: Alignment.center,
                      child: Text(
                        it.upiApplication.getAppName(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

String? _validateUpiAddress(String value) {
  if (value.isEmpty) {
    return 'UPI VPA is required.';
  }
  if (value.split('@').length != 2) {
    return 'Invalid UPI VPA';
  }
  return null;
}
