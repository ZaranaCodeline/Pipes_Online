
import 'package:get/get.dart';

import '../view_model/home_view_model.dart';

class Binding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => HomeViewModel());
  }

}