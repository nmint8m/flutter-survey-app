import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final _email = TextEditingController();
  final _password = TextEditingController();

  LoginForm({super.key});

  TextField get _emailTextField => TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: _inputDecoration(labelText: 'Email'),
        controller: _email,
      );

  TextField get _passwordTextField => TextField(
        keyboardType: TextInputType.text,
        decoration: _inputDecoration(labelText: 'Password'),
        controller: _password,
        obscureText: true,
      );

  TextButton get _forgetPasswordButton => TextButton(
        child: const Text('Forgot?'),
        onPressed: () {
          // TODO: - Integration task
        },
      );

  ElevatedButton get _loginButton => ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: const Size(0, 56)),
        child: const Text('Log in'),
        onPressed: () {
          // TODO: - Integration task
        },
      );

  InputDecoration _inputDecoration({required String labelText}) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(12.0),
      ),
      fillColor: Colors.white24,
      filled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _emailTextField,
        const SizedBox(height: 20),
        Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            _passwordTextField,
            _forgetPasswordButton,
          ],
        ),
        const SizedBox(height: 20),
        _loginButton,
      ],
    );
  }
}
