import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreInstance {
  static FirebaseFirestore? _instance;

  static FirebaseFirestore? get instance {
    if (_instance == null) {
      _instance = FirebaseFirestore.instance;
    }
    return _instance;
  }
}
