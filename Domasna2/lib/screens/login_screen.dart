import 'package:flutter/material.dart';
import 'package:home_buddy_app/view_models/login_view_model.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late LoginViewModel _loginViewModel;

  Future<bool> _loginUser(BuildContext context) async {
    bool isLoggedIn = false;

    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _emailController.text;

      bool isLoggedIn = await _loginViewModel.login(email, password);
      if (isLoggedIn) {
        Navigator.pop(context, true);
      }
    }
    return isLoggedIn;
  }

  @override
  Widget build(BuildContext context) {
    _loginViewModel = Provider.of<LoginViewModel>(context);

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future<bool>.value(false);
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("Login")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const CircleAvatar(
                    maxRadius: 150,
                    backgroundImage: AssetImage('assets/images/city_care.jpg'),
                  ),
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email is required!";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: "Email"),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password is required!";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: "Password"),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(40, 0, 40, 20),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            _loginUser(context);
                          },
                          child: const Text(
                            'Login',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    _loginViewModel.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
