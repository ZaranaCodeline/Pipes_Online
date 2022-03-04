
import 'package:get/get.dart';
import 'package:pipes_online/routes/bottom_controller.dart';

import '../../seller/s_bottombar/bottom_bar_screen_page.dart';
import '../controller/selected_product_controller.dart';
import '../view_model/home_view_model.dart';

class Binding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    // Get.lazyPut(() => HomeViewModel());
    // Get.lazyPut(() => SelectedProductController());
    Get.lazyPut(() => BottomController(),fenix: true);
    Get.lazyPut(() => BottomNavigationBarScreen(),fenix: true);
  }

}