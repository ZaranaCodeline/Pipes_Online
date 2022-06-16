import 'package:get/get.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';

class TimeFilterController extends GetxController {
  String? _dropDownValue = 'This Month';
  final now = DateTime.now();

  ///filter data
  int _dropValue = 0;

  int get dropValue => _dropValue;

  set dropValue(int value) {
    _dropValue = value;
    update();
  }

  String get dropDownValue => _dropDownValue!;
  set dropDownValue(String value) {
    _dropDownValue = value;
    update();
  }
}
