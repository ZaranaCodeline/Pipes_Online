import 'package:get/get.dart';

class EditProductContoller extends GetxController{

  String _selectedPrice='';

  String get selectedPrice => _selectedPrice;

  set selectedPrice(String value) {
    _selectedPrice = value;
    update();
  }

  String _name='';

  String get selectedName => _name;

  set selectedName(String value) {
    _name = value;
    update();
  }

  String _dsc='';

  String get selectedDesc => _dsc;

  set selectedDesc(String value) {
    _dsc = value;
    update();
  }


  String _images='';
  String get images => _images;

  set images(String value) {
    _images = value;
    update();
  }

}