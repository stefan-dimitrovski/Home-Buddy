import 'package:flutter/material.dart';

class DrawerApp extends StatelessWidget {
  const DrawerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text(
            'Drawer Header',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ),
        ListTile(
          onTap: () {},
          leading: const Icon(Icons.message),
          title: const Text('Messages'),
        ),
        ListTile(
          onTap: () {},
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