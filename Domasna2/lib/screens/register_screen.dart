import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:home_buddy_app/view_models/register_view_model.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late RegisterViewModel _registerViewModel;

  Future<bool> _registerUser(BuildContext context) async {
    bool isRegistered = false;

    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final password = _emailController.text;

      isRegistered = await _registerViewModel.register(email, password);
      if (isRegistered) {
        Navigator.pop(context, true);
      }
    }

    return isRegistered;
  }

  @override
  Widget build(BuildContext context) {
    _registerViewModel = Provider.of<RegisterViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 150,
                  backgroundImage: AssetImage(
                    'assets/images/city_care.jpg',
                  ),
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
                ElevatedButton(
                  child: const Text("Register"),
                  onPressed: () {
                    _registerUser(context);
                  },
                ),
                Text(
                  _registerViewModel.message,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
