import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
        decoration: _inputDecoration(
            labelText: AppLocalizations.of(context)?.resetPasswordEmail ?? ''),
        controller: _emailController,
        validator: _validateEmailMessage,
      );

  ElevatedButton get _resetButton => ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: const Size(0, 56)),
        child: Text(AppLocalizations.of(context)?.resetPasswordReset ?? ''),
        onPressed: () => _forgetPassword(),
      );

  InputDecoration _inputDecoration({
    required String labelText,
  }) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadiuses.circular12,
      ),
      fillColor: Colors.white24,
      filled: true,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
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

  Future<void> _forgetPassword() async {
    setState(() {
      if (!_isStartedValidation) {
        _isStartedValidation = true;
      }
    });
    if (!_forgetPasswordFormKey.currentState!.validate()) {
      return;
    }
    Keyboard.hideKeyboard(context);
    ref.read(forgetPasswordViewModelProvider.notifier).forgetPassword(
          email: _emailController.text,
        );
  }

  String? _validateEmailMessage(String? email) {
    final viewModel = ref.read(forgetPasswordViewModelProvider.notifier);
    viewModel.validateEmail(email);
    return viewModel.emailWarningMessage;
  }
}
