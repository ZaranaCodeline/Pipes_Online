import 'package:get/get.dart';
import 'package:pipes_online/buyer/controller/chat_local_file_controller.dart';
import 'package:pipes_online/buyer/controller/geolocation_controller.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/b_navigationbar.dart';
import 'package:pipes_online/routes/bottom_controller.dart';
import 'package:pipes_online/seller/view_model/add_product_controller.dart';
import 'package:pipes_online/seller/view_model/edit_product_controller.dart';

class Binding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => BottomController(),fenix: true);
    Get.lazyPut(() => BottomNavigationBarScreen(),fenix: true);
    Get.lazyPut(() => GeolocationController(),fenix: true);
    Get.lazyPut(() => LocalFileController(),fenix: true);
    Get.lazyPut(() => AddProductController(),fenix: true);
    Get.lazyPut(() => EditProductContoller(),fenix: true);
  }
}