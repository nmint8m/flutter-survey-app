import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kayla_flutter_ic/utils/border_radiuses.dart';
import 'package:kayla_flutter_ic/utils/keyboard.dart';
import 'package:kayla_flutter_ic/utils/route_paths.dart';
import 'package:kayla_flutter_ic/views/login/login_view.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends ConsumerState<LoginForm> {
  final _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isStartedValidation = false;

  TextFormField get _emailTextField => TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: _inputDecoration(
          labelText: AppLocalizations.of(context)?.loginEmail ?? '',
        ),
        controller: _emailController,
        validator: _validateEmailMessage,
      );

  TextFormField get _passwordTextField => TextFormField(
        keyboardType: TextInputType.text,
        decoration: _inputDecoration(
          labelText: AppLocalizations.of(context)?.loginPassword ?? '',
          rightPadding: 77,
        ),
        controller: _passwordController,
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
            AppLocalizations.of(context)?.loginForgotPassword ?? '',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
      onPressed: () {
        context.goNamed(RoutePath.forgetPassword.name);
      },
    );
  }

  ElevatedButton get _loginButton => ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: const Size(0, 56)),
        child: Text(AppLocalizations.of(context)?.loginLogin ?? ''),
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

  Stack get _passwordRegion => Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: [
          _passwordTextField,
          _forgetPasswordButton(context),
        ],
      );

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() => ref
        .read(loginViewModelProvider.notifier)
        .validateEmail(_emailController.text));
    _passwordController.addListener(() => ref
        .read(loginViewModelProvider.notifier)
        .validatePassword(_passwordController.text));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
          _passwordRegion,
          const SizedBox(height: 20),
          _loginButton,
        ],
      ),
    );
  }

  Future<void> _login() async {
    setState(() {
      if (!_isStartedValidation) {
        _isStartedValidation = true;
      }
    });
    if (!_loginFormKey.currentState!.validate()) {
      return;
    }
    Keyboard.hideKeyboard(context);
    ref.read(loginViewModelProvider.notifier).login(
          email: _emailController.text,
          password: _passwordController.text,
        );
  }

  String? _validateEmailMessage(String? email) {
    ref.read(loginViewModelProvider.notifier).validateEmail(email);
    return ref.read(loginViewModelProvider.notifier).emailWarningMessage;
  }

  String? _validatePasswordMessage(String? password) {
    ref.read(loginViewModelProvider.notifier).validatePassword(password);
    return ref.read(loginViewModelProvider.notifier).passwordWarningMessage;
  }
}
