import 'package:get/get.dart';

class BBottomBarIndexController extends GetxController {
  RxInt bottomIndex = 0.obs;
  RxString _selectedScreen = ''.obs;
  String? catName;
  RxString get selectedScreen => _selectedScreen;
  void setSelectedScreen({String? value}) {
    _selectedScreen.value = value!;
    print('selectedScreen :- ${_selectedScreen.value}');
    update();
  }

  void setCategoriesType({String? value}) {
    catName = value;
    print('catName :- ${catName}');
    update();
  }
}
