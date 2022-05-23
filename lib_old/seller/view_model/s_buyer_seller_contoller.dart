import 'package:get/get.dart';

class BuyerSellerController extends GetxController {
  String? radioValue;

  void setRadioValue(val) {
    radioValue = val;
    print('radioValue---: $radioValue');
    update();
  }
}
