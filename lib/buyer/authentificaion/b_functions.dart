import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pipes_online/buyer/screens/home_screen_widget.dart';
import 'package:pipes_online/s_onboarding_screen/s_buyer_seller_screen.dart';
import 'package:pipes_online/shared_prefarence/helperFunction/share_preferance_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BAuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  getCurrentUser() async {
    return await _auth.currentUser;
  }

//SIGN IN KA Function
  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      //SIGNING IN WITH GOOGLE
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      //CREATING CREDENTIAL FOR FIREBASE
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);
      print('IDTOKEN....${googleSignInAuthentication.idToken}');

      //SIGNING IN WITH CREDENTIAL & MAKING A USER IN FIREBASE  AND GETTING USER CLASS
      final userCredential =
          await _auth.signInWithCredential(credential).then((value) async {
        User? user = FirebaseAuth.instance.currentUser;
        await FirebaseFirestore.instance
            .collection("UserInfoList")
            .doc(user!.uid)
            .collection("Buyer")
            .doc().set({
          'uid': user.uid,
          'email': user.email,
          'phoneNumber': user.phoneNumber,
          'createdOn': DateTime.now(),
        });
      });

      final User? userDetails = userCredential.user;

      if (userCredential != null) {
        SharedPreferenceHelper().saveUserEmail(userDetails!.email!);
        SharedPreferenceHelper().saveUserId(userDetails.uid);
        SharedPreferenceHelper().saveUserName(userDetails.displayName!);
        SharedPreferenceHelper().saveUserProfileUrl(userDetails.photoURL!);
        SharedPreferenceHelper().saveUserProfileUrl(userDetails.phoneNumber!);

        Map<String, dynamic> userInfoMap = {
          "email": userDetails.email,
          "username": userDetails.email!.replaceAll("@gmail.com", "replace"),
          "name": userDetails.displayName,
          "imgUrl": userDetails.photoURL
        };
      }

      //CHECKING IS ON
      assert(!userDetails!.isAnonymous);
      assert(await userDetails!.getIdToken() != null);

      final User? currentUser = await _auth.currentUser;
      assert(currentUser!.uid == userDetails!.uid);
      // await DatabaseManageer().createUserData(_auth.currentUser!.uid,
      //     _auth.currentUser!.phoneNumber, _auth.currentUser!.email);

      print(userDetails);
      return userDetails;
    } catch (e) {
      print(e);
    }
  }

  Future<String> signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    await googleSignIn.signOut();
    await _auth.signOut();
    Get.off(SBuyerSellerScreen());
    return "SUCCESS";
  }
}
