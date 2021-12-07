import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterViewModel extends ChangeNotifier {
  String message = '';

  Future<bool> register(String email, String password) async {
    bool isRegistered = false;

    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      isRegistered = userCredential != null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == "email-already-in-use") {
        message = 'The account already exists for that email.';
      } else if (e.code == "invalid-email") {
        message = 'The email address is badly formatted.';
      } else {
        message = e.code;
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
    return isRegistered;
  }
}
