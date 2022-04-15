import 'package:get/get.dart';
import 'package:pipes_online/buyer/view_model/b_bottom_bar_controller.dart';
import 'package:pipes_online/buyer/view_model/chat_local_file_controller.dart';
import 'package:pipes_online/buyer/view_model/geolocation_controller.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/b_navigationbar.dart';
import 'package:pipes_online/routes/bottom_controller.dart';
import 'package:pipes_online/seller/view_model/s_add_product_controller.dart';
import 'package:pipes_online/seller/view_model/s_edit_product_controller.dart';

class Binding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => BottomController(),fenix: true);
    Get.lazyPut(() => BottomNavigationBarScreen(),fenix: true);
    Get.lazyPut(() => BBottomBarIndexController(),fenix: true);
    Get.lazyPut(() => GeolocationController(),fenix: true);
    Get.lazyPut(() => LocalFileController(),fenix: true);
    Get.lazyPut(() => AddProductController(),fenix: true);
    Get.lazyPut(() => EditProductContoller(),fenix: true);
  }
}