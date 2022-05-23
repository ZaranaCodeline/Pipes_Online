import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  int onBoardSwipe = 0;

  void setOnBoarding(int value) {
    onBoardSwipe = value;
    update();
  }

  void setNextOnBoarding() {
    onBoardSwipe++;
    update();
  }
}
