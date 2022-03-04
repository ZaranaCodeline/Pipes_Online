import 'package:get/get.dart';

class BHelpCenterController extends GetxController {
  bool openSlide = false;

  void setSlide() {
    openSlide = !openSlide;
    print('openSlide: $openSlide');
    update();
  }
}
