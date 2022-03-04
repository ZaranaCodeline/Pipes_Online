import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pipes_online/buyer/screens/b_authentication_screen/b_submit_profile_screen.dart';
import 'package:pipes_online/seller/view/s_authentication_screen/s_submit_profile_screen.dart';

// import '../../shared_preferance/shared_prefarance.dart';



// Future<bool?> loginwithgoogle({BuildContext? context}) async {
//   FirebaseAuth _auth = FirebaseAuth.instance;
//
//   try {
//     GoogleSignIn googleSignIn = GoogleSignIn();
//     GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
//     GoogleSignInAuthentication googleAuth = await googleSignInAccount!
//         .authentication;
//     final googleUser = await googleSignIn.signIn();
//
//     final AuthCredential credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken, // accessToken
//       idToken: googleAuth.idToken,
//     );
//     User? users = (await _auth
//         .signInWithCredential(credential)
//         .then((value) {
      // Navigator.pushReplacement(context!, MaterialPageRoute(builder: (context) {
      //   return BSubmitProfileScreen();
      // },
      // ),)
//     }));
//     if (users == null) {
//       return false;
//     }
//     return true;
//   } catch (e) {
//     print('this is error .......$e');
//     return null;
//   }
// }
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

//SIGN IN KA Function
Future<User?> signInWithGoogle() async
{
  try{


    //SIGNING IN WITH GOOGLE
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

    //CREATING CREDENTIAL FOR FIREBASE
    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken
    );

    //SIGNING IN WITH CREDENTIAL & MAKING A USER IN FIREBASE  AND GETTING USER CLASS
    final userCredential  = await _auth.signInWithCredential(credential);
    final User? user = userCredential.user;

    //CHECKING IS ON
    assert(!user!.isAnonymous);
    assert(await user!.getIdToken() != null);

    final User? currentUser = await _auth.currentUser;
    assert(currentUser!.uid == user!.uid);
    print(user);
    // LocalDataSaver.saveLoginData(true);
    // LocalDataSaver.saveName(user!.displayName.toString());
    // LocalDataSaver.saveMail(user.email.toString());
    // LocalDataSaver.saveImg(user.photoURL.toString());

    return user;
  }catch(e){
    print(e);
  }

}

Future<String> signOut() async
{
  await googleSignIn.signOut();
  await _auth.signOut();
  return "SUCCESS";
}

