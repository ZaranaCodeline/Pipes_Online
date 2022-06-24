import 'package:get/get.dart';
import 'package:pipes_online/shared_prefarence/shared_prefarance.dart';

class DropdownValue extends GetxController {
  // It is mandatory initialize with one value from listType
  final selected = "All".obs;

  void setSelected(String value) {
    selected.value = value;
  }
}

class TimeDistanceFilterController extends GetxController {
  String? _dropDownValue = 'All';

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
