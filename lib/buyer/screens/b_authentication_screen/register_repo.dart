import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/b_navigationbar.dart';

import '../../../seller/Authentication/s_function.dart';
import '../../../shared_prefarence/shared_prefarance.dart';
class RegisterRepo {
  Future<UserCredential?> LogIn(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential? firebaseuser = await auth.signInWithEmailAndPassword(
        email: email, password: password).then((value) async  {
      await Get.offAll(
              () => BottomNavigationBarScreen());
    });
    assert(firebaseuser != null);
    assert(await firebaseuser?.credential?.token != null);
    final User currentUser = await auth.currentUser!;
    assert(firebaseuser?.user!.uid == currentUser.uid);
    return firebaseuser;
  }
  static Future<void> emailRegister({String? email, String? pass}) async {
    try {
      await kFirebaseAuth.createUserWithEmailAndPassword(
          email: email!, password: pass!);

    } catch (e) {
      print('registration error?????????$e');
    }
      await kFirebaseAuth
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
    print('${kFirebaseAuth.currentUser!.uid}');
    await PreferenceManager.setEmail(kFirebaseAuth.currentUser!.email!);
    await PreferenceManager.setUId(kFirebaseAuth.currentUser!.uid);
    print('EMAIL ${PreferenceManager.getEmail()}');
    print('UID ${PreferenceManager.getUId()}');
  }

  static Future<void> logOut() async {
    kFirebaseAuth.signOut();
    print('Log Out');
  }
}
