import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/utils/border_radiuses.dart';
import 'package:kayla_flutter_ic/utils/keyboard.dart';
import 'package:kayla_flutter_ic/views/login/login_view.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends ConsumerState<LoginForm> {
  final _email = TextEditingController();
  final _password = TextEditingController();

  TextField get _emailTextField => TextField(
        keyboardType: TextInputType.emailAddress,
        decoration: _inputDecoration(labelText: 'Email'),
        controller: _email,
      );

  TextField get _passwordTextField => TextField(
        keyboardType: TextInputType.text,
        decoration: _inputDecoration(
          labelText: 'Password',
          rightPadding: 77,
        ),
        controller: _password,
        obscureText: true,
      );

  TextButton _forgetPasswordButton(BuildContext context) {
    return TextButton(
      child: SizedBox(
        width: 77,
        height: 40,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Forgot?',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
      onPressed: () {
        // TODO: - Integration task
      },
    );
  }

  ElevatedButton get _loginButton => ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: const Size(0, 56)),
        child: const Text('Log in'),
        onPressed: () => _login(),
      );

  InputDecoration _inputDecoration({
    required String labelText,
    double rightPadding = 12.0,
  }) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadiuses.circular12,
      ),
      fillColor: Colors.white24,
      filled: true,
      contentPadding: EdgeInsets.only(
        top: 18.0,
        bottom: 18.0,
        left: 12.0,
        right: rightPadding,
      ),
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
            _forgetPasswordButton(context),
          ],
        ),
        const SizedBox(height: 20),
        _loginButton,
      ],
    );
  }

  Future<void> _login() async {
    Keyboard.hideKeyboard(context);
    ref.read(loginViewModelProvider.notifier).login(
          email: _email.text,
          password: _password.text,
        );
  }
}
