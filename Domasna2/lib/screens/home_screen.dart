import 'package:flutter/material.dart';
import 'package:home_buddy_app/screens/register_screen.dart';
import 'package:home_buddy_app/view_models/register_view_model.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('Register'),
              onPressed: () {
                _navigateToRegisterPage(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

void _navigateToRegisterPage(BuildContext context) async {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
            create: (context) => RegisterViewModel(), child: RegisterPage()),
        fullscreenDialog: true),
  );
}
