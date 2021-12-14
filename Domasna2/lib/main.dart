import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:home_buddy_app/screens/startup_screen.dart';
import 'package:home_buddy_app/screens/test_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Buddy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Startup(),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return FutureBuilder<FirebaseUser>(
  //       future: FirebaseAuth.instance.currentUser,
  //       builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
  //         if (snapshot.hasData) {
  //           FirebaseUser user = snapshot.data; // this is your user instance
  //           /// is because there is user already logged
  //           return TestWidget();
  //         }

  //         /// other way there is no user logged.
  //         return Startup();
  //       });
  // }
}
