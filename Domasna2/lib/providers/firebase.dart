import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreInstance {
  static FirebaseFirestore? _instance;

  FirestoreInstance._internal() {
    FirebaseFirestore.instance;
  }

  static FirebaseFirestore? get instance {
    // ignore: prefer_conditional_assignment
    if (_instance == null) {
      _instance = FirestoreInstance._internal() as FirebaseFirestore;
    }
    return _instance;
  }
}
