import 'package:get_storage/get_storage.dart';

class PreferenceManager {
  static GetStorage getStorage = GetStorage();

  ///email
  static Future setEmail(String value) async {
    await getStorage.write('z@gmail.com', value);
  }

  static String getEmail() {
    return getStorage.read('z@gmail.com');
  }


  //passwoed
  static Future setPassword(String value) async {
    await getStorage.write('123456', value);
  }

  static String getPassword() {
    return getStorage.read('123456');
  }

  ///uid
  static Future setUId(String value) async {
    await getStorage.write('uid', value);
  }
  static String getUId() {
    return getStorage.read('uid');
  }
   //address
  static Future setAddress(String value) async {
    await getStorage.write('address', value);
  }
  static String getAddress() {
    return getStorage.read('address');
  }
  static Future setName(String value) async {
    await getStorage.write('userName', value);
  }
  static Future setPhoneNumber(String value) async {
    await getStorage.write('phoneNumber', value);
  }



  static String getName() {
    return getStorage.read('userName');
  }

  static String getPhoneNumber() {
    return getStorage.read('phoneNumber');
  }



  static Future<void> clearData() async {
    await getStorage.remove('email');
    await getStorage.remove('uid');
  }
}

