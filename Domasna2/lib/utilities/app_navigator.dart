import 'package:flutter/material.dart';
import 'package:home_buddy_app/screens/login_screen.dart';
import 'package:home_buddy_app/screens/register_screen.dart';
import 'package:home_buddy_app/screens/home_screen.dart';
import 'package:home_buddy_app/view_models/login_view_model.dart';
import 'package:home_buddy_app/view_models/register_view_model.dart';
import 'package:provider/provider.dart';

class AppNavigator {
  static Future<bool> navigateToLoginPage(BuildContext context) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => LoginViewModel(),
          child: LoginPage(),
        ),
        fullscreenDialog: true,
      ),
    );
  }

  static Future<bool> navigateToRegisterPage(BuildContext context) async {
    return await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNotifierProvider(
          create: (context) => RegisterViewModel(),
          child: RegisterPage(),
        ),
        fullscreenDialog: true,
      ),
    );
  }

  static Future navigateToTestPage(BuildContext context) async {
    return await Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }
}
