import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/utils/border_radiuses.dart';
import 'package:kayla_flutter_ic/utils/keyboard.dart';
import 'package:kayla_flutter_ic/views/forget_password/forget_password_view.dart';
import 'package:kayla_flutter_ic/views/login/login_view.dart';

class ForgetPasswordForm extends ConsumerStatefulWidget {
  const ForgetPasswordForm({super.key});

  @override
  ForgetPasswordFormState createState() => ForgetPasswordFormState();
}

class ForgetPasswordFormState extends ConsumerState<ForgetPasswordForm> {
  final _forgetPasswordFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isStartedValidation = false;

  TextFormField get _emailTextField => TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: _inputDecoration(labelText: 'Email'),
        controller: _emailController,
        validator: _validateEmailMessage,
      );

  ElevatedButton get _resetButton => ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: const Size(0, 56)),
        child: const Text('Reset'),
        onPressed: () => _reset(),
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
    _emailController.addListener(() => ref
        .read(loginViewModelProvider.notifier)
        .validateEmail(_emailController.text));
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _forgetPasswordFormKey,
      autovalidateMode: _isStartedValidation
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _emailTextField,
          const SizedBox(height: 20),
          _resetButton,
        ],
      ),
    );
  }

  Future<void> _reset() async {
    setState(() {
      if (!_isStartedValidation) {
        _isStartedValidation = true;
      }
    });
    if (!_forgetPasswordFormKey.currentState!.validate()) {
      return;
    }
    Keyboard.hideKeyboard(context);
    // TODO: - Call API
  }

  String? _validateEmailMessage(String? email) {
    ref.read(forgetPasswordViewModelProvider.notifier).validateEmail(email);
    return ref
        .read(forgetPasswordViewModelProvider.notifier)
        .emailWarningMessage;
  }
}
