import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';

class PreferenceManager {
  static GetStorage getStorage = GetStorage();

  static setEmail(String value) {
    getStorage.write('email', value);
  }

  static getEmail() {
    return getStorage.read('email');
  }

  static setFcmToken(String value) {
    getStorage.write('deviceToken', value);
  }

  static getFcmToken() {
    return getStorage.read('deviceToken');
  }

  static setMute(bool value) {
    getStorage.write('isMute', value);
  }

  static getMute() {
    return getStorage.read('isMute');
  }

  static setSellerID(String value) {
    getStorage.write('sellerID', value);
  }

  static getSellerID() {
    return getStorage.read('sellerID');
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

  static setUserImage(String value) {
    getStorage.write('imageProfile', value);
  }

  static getUserImage() {
    return getStorage.read('imageProfile');
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

  static setSubscribeVal(String value) {
    getStorage.write('subscribeVal', value);
  }

  static getSubscribeVal() {
    return getStorage.read('subscribeVal');
  }

  static setSubscribeCategory(String value) {
    getStorage.write('subscribeCategory', value);
  }

  static getSubscribeCategory() {
    return getStorage.read('subscribeCategory');
  }

  static setLat(String value) {
    getStorage.write('lat', value);
  }

  static getLat() {
    return getStorage.read('lat');
  }

  static setLong(String value) {
    getStorage.write('long', value);
  }

  static getLong() {
    return getStorage.read('long');
  }

  static setUserImg(String value) {
    getStorage.write('userImg', value);
  }

  static getUserImg() {
    return getStorage.read('userImg');
  }

  static clearData() {
    getStorage.remove('email');
    getStorage.remove('userType');
    getStorage.remove('password');
    getStorage.remove('phoneno');
    getStorage.remove('user_name');
    getStorage.remove('address');
    getStorage.remove('uid');
    getStorage.remove('subscribeCategory');
    getStorage.remove('subscribeTime');
    getStorage.remove('isMute');
  }
}
