import 'package:get_storage/get_storage.dart';

class PreferenceManager {
  static GetStorage getStorage = GetStorage();

  ///email
  static Future setEmail(String value) async {
    await getStorage.write('email', value);
  }

  static String getEmail() {
    return getStorage.read('email');
  }

  ///uid
  static Future setUId(String value) async {
    await getStorage.write('uid', value);
  }

  static String getUId() {
    return getStorage.read('uid');
  }

  static Future<void> clearData() async {
    await getStorage.remove('email');
    await getStorage.remove('uid');
  }
}

