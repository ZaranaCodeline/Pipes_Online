// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:pipes_online/buyer/authentificaion/b_functions.dart';
// import 'package:pipes_online/seller/Authentication/s_function.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// FirebaseAuth _auth = FirebaseAuth.instance;
//
// class PreferenceManager {
//
//   static GetStorage getStorage = GetStorage();
//
//   ///uid
//   static Future setUId(String value) async {
//     await getStorage.write('uid', value);
//   }
//
//   static String? getUID() {
//     return getStorage.read('uid');
//   }
//
//   static Future<String?> getTokenId() async{
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     // return await preferences.getString('eyJhbGciOiJSUzI1NiIsImtpZCI6IjU4YjQyOTY2MmRiMDc4NmYyZWZlZmUxM2MxZWIxMmEyOGRjNDQyZDAiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI1NzQ4NDU2NDMxNzAtc29jaTdvYWFjaGtvcDRqM243ZHNkZGN1YWU4N3M1YzguYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI1NzQ4NDU2NDMxNzAtYmpyOGxzMGphMnZlcnZiOGwzcmM1Mzcyb2RkbGU5ZDAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMDMyMzAwNjg5MjQ4ODgwOTU2NTkiLCJlbWFpbCI6InphcmFuYXJhdGhvZDE5OTRAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsIm5hbWUiOiJaYXJhbmEgUmF0aG9kIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hLS9BT2gxNEdpYkRLbnlOUFo1ZHJlWnBXUDNDbDlZUGpRWVFXT3JnUHc0RDBhaHZBPXM5Ni1jIiwiZ2l2ZW5fbmFtZSI6IlphcmFuYSIsImZhbWlseV9uYW1lIjoiUmF0aG9kIiwibG9jYWxlIjoiZW4iLCJpYXQiOjE2NDgyODc0NTEsImV4cCI6MTY0ODI5MTA1MX0.xN71e_FY5psykLtPCALvyKeamu_OPDd5sGc-__mn4rRgNHDjWPkl25Sm5CJBZGnfoXFFUmBzuGm-VJ0wJpFJabikhCsLrWCdyGdbzLOCkwgHacHxRHdfuI4Im3h3geTtD89Aw6qWbHwK8xiPnNOANjReitLUY5d024pKxRCuY9P1moAFATbDDBpUavkMho73KL1mx8-4onKQpkRi3TCxnJ1UkgiCAOHnbFfbEibMRnQ9KyAxWI6Q0f97fShBhyKcTE3r_bCLQlb8S4yhMBAYpTL9DVj4JcB-ec6ILjAdtgFWluYSiq37dOPSzEV4CArRN-GxVi6VZfgwHOOaWKF_JQ');
//   return await preferences.getString(_auth.currentUser!.refreshToken.toString());
//   }
//   static Future<String?> getCustomerPImg()async{
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//
//     return await preferences.getString('${ _auth.currentUser!.photoURL}');
//   }
//
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
FirebaseAuth _auth = FirebaseAuth.instance;

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
  static Future getUId(String value) async {
    await getStorage.write('uid', value);
  }

  static String getUID() {
    return getStorage.read('uid');
  }

  static Future<void> clearData() async {
    await getStorage.remove('email');
    await getStorage.remove('uid');
  }

  static Future<String?> getTokenId() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // return await preferences.getString('eyJhbGciOiJSUzI1NiIsImtpZCI6IjU4YjQyOTY2MmRiMDc4NmYyZWZlZmUxM2MxZWIxMmEyOGRjNDQyZDAiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI1NzQ4NDU2NDMxNzAtc29jaTdvYWFjaGtvcDRqM243ZHNkZGN1YWU4N3M1YzguYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI1NzQ4NDU2NDMxNzAtYmpyOGxzMGphMnZlcnZiOGwzcmM1Mzcyb2RkbGU5ZDAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMDMyMzAwNjg5MjQ4ODgwOTU2NTkiLCJlbWFpbCI6InphcmFuYXJhdGhvZDE5OTRAZ21haWwuY29tIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsIm5hbWUiOiJaYXJhbmEgUmF0aG9kIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hLS9BT2gxNEdpYkRLbnlOUFo1ZHJlWnBXUDNDbDlZUGpRWVFXT3JnUHc0RDBhaHZBPXM5Ni1jIiwiZ2l2ZW5fbmFtZSI6IlphcmFuYSIsImZhbWlseV9uYW1lIjoiUmF0aG9kIiwibG9jYWxlIjoiZW4iLCJpYXQiOjE2NDgyODc0NTEsImV4cCI6MTY0ODI5MTA1MX0.xN71e_FY5psykLtPCALvyKeamu_OPDd5sGc-__mn4rRgNHDjWPkl25Sm5CJBZGnfoXFFUmBzuGm-VJ0wJpFJabikhCsLrWCdyGdbzLOCkwgHacHxRHdfuI4Im3h3geTtD89Aw6qWbHwK8xiPnNOANjReitLUY5d024pKxRCuY9P1moAFATbDDBpUavkMho73KL1mx8-4onKQpkRi3TCxnJ1UkgiCAOHnbFfbEibMRnQ9KyAxWI6Q0f97fShBhyKcTE3r_bCLQlb8S4yhMBAYpTL9DVj4JcB-ec6ILjAdtgFWluYSiq37dOPSzEV4CArRN-GxVi6VZfgwHOOaWKF_JQ');
  return await preferences.getString(_auth.currentUser!.refreshToken.toString());
  }
}
