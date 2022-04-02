//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class DatabaseManageer{
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   final CollectionReference profileList = FirebaseFirestore.instance.collection('userInfoProfile');
//
//   Future<void> createUserData(String? name, phoneNumber,email)async{
//     return await profileList.doc(_auth.currentUser!.uid).set({
//       'name':name,
//       'phoneNumber':phoneNumber,
//       'email':email,
//     });
//
//   }
// }