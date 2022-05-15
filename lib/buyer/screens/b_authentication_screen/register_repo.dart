import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
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
      await bFirebaseAuth
          .createUserWithEmailAndPassword(email: email!, password: pass!)
          .then((value) => print('B-LogIn email==${value.user!.uid}'));
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
  }

  static Future<void> bLogOut() async {
    PreferenceManager.clearData();
    // BAuthMethods.logOut();
    bFirebaseAuth.signOut();
    print('Log Out');
  }
}

///-------------seller------------------
class SRegisterRepo {
  Future<UserCredential?> LogIn(String email, String password) async {
    UserCredential? firebaseuser = await bFirebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      print('-LogIn==${value.user!.uid}');
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

      print('LogIn==${bFirebaseAuth.currentUser!.uid}');
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
      await bFirebaseAuth
          .createUserWithEmailAndPassword(email: email!, password: pass!)
          .then((value) => print('-LogIn==${value.user!.uid}'));

      await PreferenceManager.setUId(bFirebaseAuth.currentUser!.uid);
      await PreferenceManager.setSellerID(bFirebaseAuth.currentUser!.uid);
      PreferenceManager.getSellerID();
      PreferenceManager.getUId();
      PreferenceManager.getUserType();
      print('UID SRegisterRepo==========${PreferenceManager.getUId()}');
      print('UID getSellerID=========${PreferenceManager.getSellerID()}');

      print(
          'getUserType SRegisterRepo====getUserType=====${PreferenceManager.getUserType()}');
      print(
          'SRegisterRepo vemailRegister----UID ${PreferenceManager.getUId()}');
      print(
          'SRegisterRepo  emailRegister------LogIn==${bFirebaseAuth.currentUser!.uid}');
    } catch (e) {
      print('registration error?????????$e');
    }
  }
  // static Future<void> emailRegister({String? email, String? pass}) async {
  //   try {
  //     await bFirebaseAuth.createUserWithEmailAndPassword(
  //         email: email!, password: pass!);
  //     print('UID SRegisterRepo==========${PreferenceManager.getUId()}');
  //     print(
  //         'getUserType SRegisterRepo=========${PreferenceManager.getUserType()}');
  //
  //     await PreferenceManager.setUId(bFirebaseAuth.currentUser!.uid);
  //     PreferenceManager.getUId();
  //     PreferenceManager.getUserType();
  //     print('UID SRegisterRepo==========${PreferenceManager.getUId()}');
  //
  //     print(
  //         'getUserType SRegisterRepo====getUserType=====${PreferenceManager.getUserType()}');
  //     print(
  //         'SRegisterRepo vemailRegister----UID ${PreferenceManager.getUId()}');
  //     print(
  //         'SRegisterRepo  emailRegister------LogIn==${bFirebaseAuth.currentUser!.uid}');
  //   } catch (e) {
  //     print('registration error?????????$e');
  //   }
  //   await bFirebaseAuth
  //       .createUserWithEmailAndPassword(
  //           email: email.toString(), password: pass.toString())
  //       .then((value) => print(value.user!.email))
  //       .catchError((e) => print(e.toString()));
  // }

  static Future<void> sLogOut() async {
    // PreferenceManager.clearData();
    bFirebaseAuth.signOut();
    // BAuthMethods.logOut();
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
    PreferenceManager.setUId(users!.uid);
    PreferenceManager.setEmail(users.email!);
    PreferenceManager.setName(users.displayName!);
    PreferenceManager.setPhoneNumber(users.phoneNumber!);
    print(
        'buyer addData Preference ==>${PreferenceManager.getUId().toString()}');
    PreferenceManager.getUId();
    PreferenceManager.getEmail();
    PreferenceManager.getName();
    PreferenceManager.getPhoneNumber();
    print('uid------${users.uid}');
    print('phoneNumber------${users.phoneNumber}');
    print('displayName------${users.displayName}');
    print('email------${users.email}');
    print('photoURL------${users.photoURL}');
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
  await bFirebaseAuth.signOut();
  PreferenceManager.clearData();
  print('Log Out');
}
