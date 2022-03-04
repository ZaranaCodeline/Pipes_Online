import 'package:get/get.dart';

class BottomController extends GetxController {
  RxInt bottomIndex = 0.obs;
  RxString _selectedScreen = ''.obs;

  RxString get selectedScreen => _selectedScreen;
  void setSelectedScreen(String value) {
    _selectedScreen.value = value;
    update();
  }
}
