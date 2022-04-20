import 'package:get_storage/get_storage.dart';

class PreferenceManager {
  static GetStorage getStorage = GetStorage();

  static Future setEmail(String value) async {
    await getStorage.write('email', value);
  }
  static String getEmail() {
    return getStorage.read('email');
  }

  static Future setUserType(String value) async {
    await getStorage.write('userType', value);
  }
  static  getUserType() {
    return getStorage.read('userType');
  }


  static Future setPassword(var value) async {
    await getStorage.write('password', value);
  }
  static   getPassword() {
    return getStorage.read('password');
  }

  static Future setUId(String value) async {
    await  getStorage.write('uid', value);
  }
  static   getUId() {
    return getStorage.read('uid');
  }

  static Future setAddress(String value) async {
    await getStorage.write('address', value);
  }
  static  getAddress() {
    return getStorage.read('address');
  }

  static Future setName(String value) async {
    await getStorage.write('firstname', value);
  }
  static  getName() {
    return getStorage.read('firstname');
  }

  static Future setPhoneNumber(String value) async {
    await getStorage.write('phoneno', value);
  }
  static  getPhoneNumber() {
    return getStorage.read('phoneno');
  }

  static Future<void> clearData() async {
    // await getStorage.erase();
    await getStorage.remove('email');
    await getStorage.remove('userType');
    await getStorage.remove('password');
    await getStorage.remove('phoneno');
    await getStorage.remove('firstname');
    await getStorage.remove('address');
    await  getStorage.remove('uid');
  }

}

