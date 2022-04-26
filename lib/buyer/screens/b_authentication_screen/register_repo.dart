import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/b_navigationbar.dart';
import 'package:pipes_online/seller/bottombar/s_navigation_bar.dart';
import '../../../shared_prefarence/shared_prefarance.dart';

class BRegisterRepo {
  Future<UserCredential?> LogIn(String email, String password) async {
    UserCredential? firebaseuser = await bFirebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      await PreferenceManager.setUId(bFirebaseAuth.currentUser!.uid);
      PreferenceManager.getUId();
      PreferenceManager.getUserType();
      print('UID BRegisterRepo==========${PreferenceManager.getUId()}');

      print(
          'getUserType BRegisterRepo====getUserType=====${PreferenceManager.getUserType()}');
      print(
          'BRegisterRepo vemailRegister----UID ${PreferenceManager.getUId()}');
      print(
          'BRegisterRepo  emailRegister------LogIn==${bFirebaseAuth.currentUser!.uid}');

      print('LogIn==${bFirebaseAuth.currentUser!.uid}');
      await Get.offAll(() => BottomNavigationBarScreen());
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
      print('UID BRegisterRepo==========${PreferenceManager.getUId()}');
      await PreferenceManager.setUId(bFirebaseAuth.currentUser!.uid);
      PreferenceManager.getUId();
      PreferenceManager.getUserType();
      print('UID BRegisterRepo==========${PreferenceManager.getUId()}');

      print(
          'getUserType BRegisterRepo====getUserType=====${PreferenceManager.getUserType()}');
      print(
          'BRegisterRepo vemailRegister----UID ${PreferenceManager.getUId()}');
      print(
          'BRegisterRepo  emailRegister------LogIn==${bFirebaseAuth.currentUser!.uid}');
    } catch (e) {
      print('registration error?????????$e');
    }
    await bFirebaseAuth
        .createUserWithEmailAndPassword(
            email: email.toString(), password: pass.toString())
        .then((value) => print(value.user!.email))
        .catchError((e) => print(e.toString()));
    await PreferenceManager.setUId(bFirebaseAuth.currentUser!.uid);
    print('emailRegister UID ${PreferenceManager.getUId()}');
    print('emailRegister setUId==${bFirebaseAuth.currentUser!.uid}');
  }

  static Future<void> logOut() async {
    PreferenceManager.clearData();
    bFirebaseAuth.signOut();
    print('Log Out');
  }
}

//seller
class SRegisterRepo {
  Future<UserCredential?> LogIn(String email, String password) async {
    UserCredential? firebaseuser = await bFirebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      await PreferenceManager.setUId(bFirebaseAuth.currentUser!.uid);
      await PreferenceManager.setUserType('seller');
      PreferenceManager.getUId();
      PreferenceManager.getUserType();
      print(
          'getUserType SRegisterRepo=========${PreferenceManager.getUserType()}');
      print('UID SRegisterRepo==========${PreferenceManager.getUId()}');
      print('LogIn ================${bFirebaseAuth.currentUser!.uid}');

      await Get.offAll(() => NavigationBarScreen());
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
      print('UID SRegisterRepo==========${PreferenceManager.getUId()}');
      await PreferenceManager.setUId(bFirebaseAuth.currentUser!.uid);
      PreferenceManager.getUId();
      PreferenceManager.getUserType();
      print('UID SRegisterRepo==========${PreferenceManager.getUId()}');

      print(
          'getUserType SRegisterRepo====getUserType=====${PreferenceManager.getUserType()}');
      print(
          'SRegisterRepo vemailRegister----UID ${PreferenceManager.getUId()}');
      print(
          'SRegisterRepo  emailRegister------LogIn==${bFirebaseAuth.currentUser!.uid}');
    } catch (e) {
      print('registration error?????????$e');
    }
    await bFirebaseAuth
        .createUserWithEmailAndPassword(
            email: email.toString(), password: pass.toString())
        .then((value) => print(value.user!.email))
        .catchError((e) => print(e.toString()));
  }
  // static Future<void> currentUser() async {
  //   print('seller kFirebaseAuth.currentUser!.uid==============>${kFirebaseAuth.currentUser!.uid}');
  //   print('seller Preference Id==============>${PreferenceManager.getUId().toString()}');
  //   print('${bFirebaseAuth.currentUser!.uid}');
  //   await PreferenceManager.setEmail(bFirebaseAuth.currentUser!.email!);
  //   await PreferenceManager.setUId(bFirebaseAuth.currentUser!.uid);
  //
  //   print('EMAIL ${PreferenceManager.getEmail()}');
  //   print('UID ${PreferenceManager.getUId()}');
  // }

  static Future<void> logOut() async {
    PreferenceManager.clearData();
    bFirebaseAuth.signOut();
    print('Log Out');
  }
}
