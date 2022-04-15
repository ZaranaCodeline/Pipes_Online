import 'package:get/get.dart';

class EditProductContoller extends GetxController{

  String _selectedPrice='';

  String get selectedPrice => _selectedPrice;

  set selectedPrice(String value) {
    _selectedPrice = value;
    update();
  }

  String _name='';

  String get name => _name;

  set name(String value) {
    _name = value;
    update();
  }
  String _images='';

  String get images => _images;

  set images(String value) {
    _images = value;
    update();
  }
  String _prices='';

  String get prices => _prices;

  set prices(String value) {
    _prices = value;
    update();
  }
  String _descs='';

  String get descs => _descs;

  set descs(String value) {
    _descs = value;
    update();
  }

}