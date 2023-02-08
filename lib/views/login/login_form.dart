import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/utils/border_radiuses.dart';
import 'package:kayla_flutter_ic/utils/keyboard.dart';
import 'package:kayla_flutter_ic/views/login/login_view.dart';

final _emailWarningMessageProvider = StreamProvider.autoDispose<String?>(
  (ref) => ref.watch(loginViewModelProvider.notifier).emailWarningMessageStream,
);

final _passwordWarningMessageProvider = StreamProvider.autoDispose<String?>(
  (ref) =>
      ref.watch(loginViewModelProvider.notifier).passwordWarningMessageStream,
);

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends ConsumerState<LoginForm> {
  final _loginFormKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _isStartedValidation = false;

  TextFormField get _emailTextField => TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: _inputDecoration(labelText: 'Email'),
        controller: _email,
        validator: _validateEmailMessage,
      );

  TextFormField get _passwordTextField => TextFormField(
        keyboardType: TextInputType.text,
        decoration: _inputDecoration(
          labelText: 'Password',
          rightPadding: 77,
        ),
        controller: _password,
        obscureText: true,
        validator: _validatePasswordMessage,
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
  void initState() {
    super.initState();
    _email.addListener(() =>
        ref.read(loginViewModelProvider.notifier).validateEmail(_email.text));
    _password.addListener(() => ref
        .read(loginViewModelProvider.notifier)
        .validatePassword(_password.text));
    _validateInputs();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      autovalidateMode: _isStartedValidation
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: Column(
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
      ),
    );
  }

  Future<void> _login() async {
    setState(() {
      if (!_isStartedValidation) {
        _validateInputs();
        _isStartedValidation = true;
      }
    });
    if (!_loginFormKey.currentState!.validate()) {
      return;
    }
    Keyboard.hideKeyboard(context);
    ref.read(loginViewModelProvider.notifier).login(
          email: _email.text,
          password: _password.text,
        );
  }

  void _validateInputs() {
    ref.read(loginViewModelProvider.notifier).validateEmail(_email.text);
    ref.read(loginViewModelProvider.notifier).validatePassword(_password.text);
  }

  String? _validateEmailMessage(String? email) {
    return ref.watch(_emailWarningMessageProvider).value;
  }

  String? _validatePasswordMessage(String? password) {
    return ref.watch(_passwordWarningMessageProvider).value;
  }
}
