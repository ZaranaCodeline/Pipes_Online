import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

class PreferenceManager {
  static GetStorage getStorage = GetStorage();

  static setEmail(String value) {
    getStorage.write('email', value);
  }

  static Future<String> getEmail() async {
    return await getStorage.read('email');
  }

  static setUserType(String value) {
    getStorage.write('userType', value);
  }

  static getUserType() {
    return getStorage.read('userType');
  }

  static setPassword(var value) {
    getStorage.write('password', value);
  }

  static getPassword() {
    return getStorage.read('password');
  }

  static setUId(String value) {
    getStorage.write('uid', value);
  }

  static getUId() {
    return getStorage.read('uid');
  }

  static setAddress(String value) {
    getStorage.write('address', value);
  }

  static getAddress() {
    return getStorage.read('address');
  }

  static setName(String value) {
    getStorage.write('user_name', value);
  }

  static getName() {
    return getStorage.read('user_name');
  }

  static setPhoneNumber(String value) {
    getStorage.write('phoneno', value);
  }

  static getPhoneNumber() {
    return getStorage.read('phoneno');
  }

  static setTime(String value) {
    getStorage.write('time', value);
  }

  static getTime() {
    return getStorage.read('time');
  }

  static setSubscribeTime(String value) {
    getStorage.write('subscribeTime', value);
  }

  static getSubscribeTime() {
    return getStorage.read('subscribeTime');
  }

  static setSubscribeCategory(String value) {
    getStorage.write('subscribeCategory', value);
  }

  static getSubscribeCategory() {
    return getStorage.read('subscribeCategory');
  }

  static clearData() {
    // await getStorage.erase();
    getStorage.remove('email');
    getStorage.remove('userType');
    getStorage.remove('password');
    getStorage.remove('phoneno');
    getStorage.remove('user_name');
    getStorage.remove('address');
    getStorage.remove('uid');
    getStorage.remove('subscribeCategory');
    getStorage.remove('subscribeTime');
  }
}
