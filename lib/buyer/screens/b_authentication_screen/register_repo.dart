import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pipes_online/app_notification.dart';
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
      PreferenceManager.getUId();

      CollectionReference ProfileCollection =
          bFirebaseStore.collection('BProfile');
      print('--login-buyer-token--${PreferenceManager.getFcmToken()}');
      ProfileCollection.doc(PreferenceManager.getUId()).update({
        'deviceToken': PreferenceManager.getFcmToken(),
        'isOnline': true,
      }).then((value) {
        print('fcm success add');
        print('fcm getFcmToken --${PreferenceManager.getFcmToken()}');
      }).catchError((e) => print('fcm error'));

      print('UId=${PreferenceManager.getUId()}');
      Get.offAll(BottomNavigationBarScreen());
    });

    Get.showSnackbar(
      const GetSnackBar(
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
        PreferenceManager.getFcmToken();
        print('buyer email token-----1${PreferenceManager.getFcmToken()}');

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
        const GetSnackBar(
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
      PreferenceManager.getUId();

      CollectionReference ProfileCollection =
          bFirebaseStore.collection('SProfile');

      print('--login---seller---${PreferenceManager.getFcmToken()}');

      ProfileCollection.doc(PreferenceManager.getUId()).update({
        'isOnline': true,
        'deviceToken': PreferenceManager.getFcmToken()
      }).then((value) {
        print('fcm success add');
        print('fcm getFcmToken --${PreferenceManager.getFcmToken()}');
      }).catchError((e) => print('fcm error'));

      Get.offAll(NavigationBarScreen());

      Get.showSnackbar(
        const GetSnackBar(
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
        PreferenceManager.getFcmToken();
        print('--email---seller---${PreferenceManager.getFcmToken()}');
        Get.offAll(SFirstUserInfoScreen(
          email: email,
        ));
      });

      await PreferenceManager.setUId(bFirebaseAuth.currentUser!.uid);
      print('UID==${PreferenceManager.getUId()}');
      return firebaseuser;
    } catch (e) {
      Get.showSnackbar(
        const GetSnackBar(
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 5),
          message: 'The email address is already in use by another account',
        ),
      );
      print('registration error?????????$e');
    }
  }

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
    // final googleUser = await googleSignIn.signIn();
    // final googleAuth = await googleUser!.authentication;
    // final AuthCredential credential = GoogleAuthProvider.credential(
    //   accessToken: googleAuth.accessToken, // accessToken
    //   idToken: googleAuth.idToken,
    // );
    // User? users = (await _auth.signInWithCredential(credential)).user;
    print("================================1");
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    print("================================2");
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    print(
        "================================3  ${googleSignInAuthentication.accessToken}");
    final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);
    print("================================4 ${credential.idToken}");
    UserCredential user =
        await FirebaseAuth.instance.signInWithCredential(credential);
    User? users = user.user;
    print("================================5  ${user}");

    print('uid------${users?.uid}');
    print('phoneNumber------${users?.phoneNumber}');
    print('displayName------${users?.displayName}');
    print('email------${users?.email}');
    print('photoURL------${users?.photoURL}');
    await PreferenceManager.setUId(users!.uid);
    await PreferenceManager.setEmail(users.email!);
    await PreferenceManager.setName(users.displayName!);
    // await PreferenceManager.setPhoneNumber(users.phoneNumber!);
    AppNotificationHandler.getFcmToken();
    PreferenceManager.getFcmToken();
    print('token-----1${PreferenceManager.getFcmToken()}');

    print(
        'buyer addData Preference ==>${PreferenceManager.getUId().toString()}');
    if (users == null) {
      return false;
    }
    return true;
  } on FirebaseAuthException catch (e) {
    print(e.message);
    throw e;
  }
}

Future<bool?> logOutFormGoogle() async {
  GoogleSignIn googleSignIn = GoogleSignIn();
  await googleSignIn.signOut();
  await bFirebaseAuth.signOut();
  PreferenceManager.clearData();
  print('Log Out');
}
