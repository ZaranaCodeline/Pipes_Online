
import 'package:get/get.dart';
import 'package:pipes_online/buyer/controller/geolocation_controller.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/b_navigationbar.dart';
import 'package:pipes_online/routes/bottom_controller.dart';

import '../../seller/controller/s_subscribe_controller.dart';
import '../../seller/s_bottombar/b_bottom_bar_screen_page.dart';
import '../controller/chat_local_file_controller.dart';
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
    Get.lazyPut(() => GeolocationController(),fenix: true);
    Get.lazyPut(() => LocalFileController(),fenix: true);
  }

}