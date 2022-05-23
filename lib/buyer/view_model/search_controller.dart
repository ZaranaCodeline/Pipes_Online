import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  Future<dynamic> getData(String collection) async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot =
        await firebaseFirestore.collection(collection).get();
    return snapshot.docs;
  }

  Future queryData(String queryString) {
    return FirebaseFirestore.instance
        .collection('Products')
        .where('proName', isGreaterThanOrEqualTo: queryString)
        .get();
  }
}
