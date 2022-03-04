// import 'package:get/get.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class HomeViewModel extends GetxController {
//   final CollectionReference? _collectionReference =
//       FirebaseFirestore.instance.collection("Categories");
//
//   HomeViewModel(){
//     getCategory();
//   }
//   getCategory() async {
//     _collectionReference!.get().then((value) {
//       print(value.docs[0].data());
//     });
//   }
// }
