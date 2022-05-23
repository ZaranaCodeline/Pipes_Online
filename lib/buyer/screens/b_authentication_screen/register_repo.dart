import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pipes_online/buyer/app_constant/auth.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/new_ui/b_first_user_info_screen.dart';
import 'package:pipes_online/buyer/screens/bottom_bar_screen_page/b_navigationbar.dart';
import 'package:pipes_online/seller/bottombar/s_navigation_bar.dart';
import 'package:pipes_online/seller/view/s_authentication_screen/NEW/s_first_user_info_screen.dart';

import '../../../shared_prefarence/shared_prefarance.dart';

class BRegisterRepo {
  Future<UserCredential?> LogIn(String email, String password) async {
    print('------EMAIL_RAGISTER----${bFirebaseAuth.currentUser?.email}');
    UserCredential? firebaseuser = await bFirebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      PreferenceManager.setUId(bFirebaseAuth.currentUser!.uid);
      Get.offAll(BottomNavigationBarScreen());
      print('UId====${PreferenceManager.getUId()}');
    });
    Get.showSnackbar(
      GetSnackBar(
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 5),
        message: 'Login successfully done',
      ),
    );
    return firebaseuser;
  }

  static Future<UserCredential?> emailRegister(
      {String? email, String? pass}) async {
    try {
      UserCredential? firebaseuser = await bFirebaseAuth
          .createUserWithEmailAndPassword(email: email!, password: pass!)
          .then((value) {
        PreferenceManager.setEmail(email);
        print('---success---email---done');
        Get.offAll(BFirstUserInfoScreen(
          email: email,
        ));
      });

      await PreferenceManager.setUId(bFirebaseAuth.currentUser!.uid);
      print('UID==${PreferenceManager.getUId()}');
      return firebaseuser;
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 5),
          message: 'The email address is already in use by another account',
        ),
      );
      print('registration error?????????$e');
    }
  }

  static Future<void> bLogOut() async {
    PreferenceManager.clearData();
    bFirebaseAuth.signOut();
    print('Log Out');
  }
}

///-------------seller------------------
class SRegisterRepo {
  Future<UserCredential?> LogIn(String email, String password) async {
    UserCredential? firebaseuser = await bFirebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      PreferenceManager.setUId(bFirebaseAuth.currentUser!.uid);
      Get.offAll(NavigationBarScreen());
      Get.showSnackbar(
        GetSnackBar(
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 5),
          message: 'Login successfully done',
        ),
      );
      print('UId====${PreferenceManager.getUId()}');
    });
    return firebaseuser;
  }

  static Future<UserCredential?> emailRegister(
      {String? email, String? pass}) async {
    try {
      UserCredential? firebaseuser = await bFirebaseAuth
          .createUserWithEmailAndPassword(email: email!, password: pass!)
          .then((value) {
        print('---success---email---done');
        Get.offAll(SFirstUserInfoScreen(
          email: email,
        ));
      });

      await PreferenceManager.setUId(bFirebaseAuth.currentUser!.uid);
      print('UID==${PreferenceManager.getUId()}');
      return firebaseuser;
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 5),
          message: 'The email address is already in use by another account',
        ),
      );
      print('registration error?????????$e');
    }
  }
  // static Future<void> emailRegister({String? email, String? pass}) async {
  //   try {
  //     UserCredential? firebaseuser = await bFirebaseAuth
  //         .createUserWithEmailAndPassword(email: email!, password: pass!)
  //         .then((value) {
  //       print('---success---email---done');
  //       Get.offAll(SFirstUserInfoScreen());
  //       Get.showSnackbar(
  //         GetSnackBar(
  //           snackPosition: SnackPosition.BOTTOM,
  //           duration: Duration(seconds: 5),
  //           message: 'Sign up successfully done',
  //         ),
  //       );
  //     });
  //     assert(await firebaseuser?.credential?.token != null);
  //     final User currentUser = await bFirebaseAuth.currentUser!;
  //     assert(firebaseuser?.user!.uid == currentUser.uid);
  //     await PreferenceManager.setUId(bFirebaseAuth.currentUser!.uid);
  //     print('UID==${PreferenceManager.getUId()}');
  //   } catch (e) {
  //     Get.showSnackbar(
  //       GetSnackBar(
  //         snackPosition: SnackPosition.BOTTOM,
  //         duration: Duration(seconds: 10),
  //         message: 'The email address is already in use by another account',
  //       ),
  //     );
  //     print('registration error?????????$e');
  //   }
  // }

  static Future<void> sLogOut() async {
    PreferenceManager.clearData();
    bFirebaseAuth.signOut();
    print('Log Out');
  }
}

Future<bool?> loginwithgoogle() async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  try {
    GoogleSignIn googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken, // accessToken
      idToken: googleAuth.idToken,
    );
    User? users = (await _auth.signInWithCredential(credential)).user;

    print('uid------${users?.uid}');
    print('phoneNumber------${users?.phoneNumber}');
    print('displayName------${users?.displayName}');
    print('email------${users?.email}');
    print('photoURL------${users?.photoURL}');
    await PreferenceManager.setUId(users!.uid);
    await PreferenceManager.setEmail(users.email!);
    await PreferenceManager.setName(users.displayName!);
    await PreferenceManager.setPhoneNumber(users.phoneNumber!);
    print(
        'buyer addData Preference ==>${PreferenceManager.getUId().toString()}');

    Get.offAll(BFirstUserInfoScreen(
      email: users.email,
      name: users.displayName,
      photoUrl: users.photoURL,
    ));
    if (users == null) {
      return false;
    }
    return true;
  } catch (e) {
    print('this is error .......$e');
    return null;
  }
}

Future<bool?> logOutFormGoogle() async {
  GoogleSignIn googleSignIn = GoogleSignIn();
  await googleSignIn.signOut();
  await bFirebaseAuth.signOut();
  PreferenceManager.clearData();
  print('Log Out');
}
