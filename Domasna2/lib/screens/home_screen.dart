import 'package:flutter/material.dart';
import 'package:home_buddy_app/utilities/app_navigator.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
  }

  void _navigateToRegisterPage(BuildContext context) async {
    final bool isRegistered =
        await AppNavigator.navigateToRegisterPage(context);
    if (isRegistered) {
      AppNavigator.navigateToLoginPage(context);
    }
  }

  void _navigateToLoginPage(BuildContext context) async {
    _isSignedIn = await AppNavigator.navigateToLoginPage(context);
    if (_isSignedIn) {
      AppNavigator.navigateToTestPage(context);
    }
  }

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
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () {
                _navigateToLoginPage(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
