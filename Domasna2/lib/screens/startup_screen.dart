import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:home_buddy_app/screens/home_screen.dart';
import 'package:home_buddy_app/utilities/app_navigator.dart';

class Startup extends StatefulWidget {
  const Startup({Key? key}) : super(key: key);

  @override
  State<Startup> createState() => _StartupState();
}

class _StartupState extends State<Startup> {
  bool _isSignedIn = false;

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(
            title: 'Home',
          ),
        ),
      );
    }
    return firebaseApp;
  }

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
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                Align(
                  alignment: const AlignmentDirectional(0, -0.59),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      height: 200,
                      width: 200,
                      color: Colors.blue,
                      child: const Icon(Icons.home,
                          color: Colors.white, size: 150),
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(-0.14, -0.08),
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Align(
                      alignment: const AlignmentDirectional(0, 0.56),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Get Started Button
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                40, 0, 40, 20),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  _navigateToRegisterPage(context);
                                },
                                child: const Text('Get Started'),
                              ),
                            ),
                          ),
                          //Login Button
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                40, 0, 40, 20),
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  _navigateToLoginPage(context);
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(color: Colors.black),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
