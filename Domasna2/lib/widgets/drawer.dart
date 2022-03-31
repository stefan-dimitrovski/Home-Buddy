import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_buddy_app/screens/profile_screen.dart';

class DrawerApp extends StatelessWidget {
  const DrawerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            FirebaseAuth.instance.currentUser!.email.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Profile()));
          },
          leading: const Icon(Icons.account_circle),
          title: const Text('Profile'),
        ),
        ListTile(
          onTap: () {},
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
        ),
      ],
    );
  }
}
