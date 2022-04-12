import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/authentificaion/b_functions.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/b_navigationbar.dart';

import '../../../seller/Authentication/s_function.dart';
import '../../../shared_prefarence/shared_prefarance.dart';
class RegisterRepo {
  Future<UserCredential?> LogIn(String email, String password) async {
    UserCredential? firebaseuser = await bFirebaseAuth.signInWithEmailAndPassword(
        email: email, password: password).then((value) async  {
      await Get.offAll(
              () => BottomNavigationBarScreen());
    });
    assert(firebaseuser != null);
    assert(await firebaseuser?.credential?.token != null);
    final User currentUser = await bFirebaseAuth.currentUser!;
    assert(firebaseuser?.user!.uid == currentUser.uid);
    return firebaseuser;
  }
  static Future<void> emailRegister({String? email, String? pass}) async {
    try {
      await bFirebaseAuth.createUserWithEmailAndPassword(
          email: email!, password: pass!);

    } catch (e) {
      print('registration error?????????$e');
    }
      await bFirebaseAuth
        .createUserWithEmailAndPassword(email: email.toString(), password: pass.toString())
        .then((value) => print(value.user!.email))
        .catchError((e) => print(e.toString()));
  }


  // static Future<void> emailLogin({String? email, String? pass}) async {
  // await kFirebaseAuth
  //       .signInWithEmailAndPassword(
  //     email: email!,
  //     password: pass!,
  //   )
  //       .then((value) {
  //     print('LoginSuccess... ${value.user!.email}');
  //   }).catchError((e) => print('Error $e'));
  // }

  static Future<void> currentUser() async {
    print('${bFirebaseAuth.currentUser!.uid}');
    await PreferenceManager.setEmail(bFirebaseAuth.currentUser!.email!);
    await PreferenceManager.setUId(bFirebaseAuth.currentUser!.uid);
    print('EMAIL ${PreferenceManager.getEmail()}');
    print('UID ${PreferenceManager.getUId()}');
  }

  static Future<void> logOut() async {
    bFirebaseAuth.signOut();
    print('Log Out');
  }
}
