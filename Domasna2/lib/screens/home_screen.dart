import 'package:flutter/material.dart';
import 'package:home_buddy_app/screens/login_screen.dart';
import 'package:home_buddy_app/screens/register_screen.dart';
import 'package:home_buddy_app/view_models/login_view_model.dart';
import 'package:home_buddy_app/view_models/register_view_model.dart';
import 'package:provider/provider.dart';

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
    _populateAllListings();
  }

  void _populateAllListings() async {}

  void _navigateToRegisterPage(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => RegisterViewModel(), child: RegisterPage()),
          fullscreenDialog: true),
    );
  }

  void _navigateTLoginPage(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
              create: (context) => LoginViewModel(), child: LoginPage()),
          fullscreenDialog: true),
    );
  }

  // void _navigateToMyListings(BuildContext context) {
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => MyListingsPage()));
  // }

  // void _navigateToAddListingPage(BuildContext context) async {
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (context) => AddListingPage()));
  // }

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
                _navigateTLoginPage(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
