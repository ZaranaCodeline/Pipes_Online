
import 'package:get/get.dart';

import '../controller/selected_product_controller.dart';
import '../view_model/home_view_model.dart';

class Binding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    // Get.lazyPut(() => HomeViewModel());
    Get.lazyPut(() => SelectedProductController());
  }

}