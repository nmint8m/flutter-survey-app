import 'package:email_validator/email_validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/model/oauth_login.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/usecases/oath/login_use_case.dart';
import 'package:kayla_flutter_ic/views/login/login_state.dart';

class LoginViewModel extends StateNotifier<LoginState> {
  String? get emailWarningMessage => _emailWarningMessage;
  String? get passwordWarningMessage => _passwordWarningMessage;

  static const _passwordRequiredLength = 8;

  final LoginUseCase _loginUseCase;
  String? _emailWarningMessage;
  String? _passwordWarningMessage;

  LoginViewModel(this._loginUseCase) : super(const LoginState.init());

  void validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      _emailWarningMessage = 'Please enter your email!';
    } else if (!EmailValidator.validate(email)) {
      _emailWarningMessage = 'Wrong email format.';
    } else {
      _emailWarningMessage = null;
    }
  }

  void validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      _passwordWarningMessage = 'Please enter your password!';
    } else if (password.length < _passwordRequiredLength) {
      _passwordWarningMessage = 'The password should be longer 8 characters.';
    } else {
      _passwordWarningMessage = null;
    }
  }

  void login({
    required String email,
    required String password,
  }) async {
    state = const LoginState.loading();
    final result = await _loginUseCase.call(LoginParams(
      email: email,
      password: password,
    ));
    if (result is Success<OAuthLogin>) {
      state = const LoginState.success();
    } else {
      _handleError(result as Failed);
    }
  }

  void _handleError(Failed failure) {
    state = LoginState.error(failure.errorMessage);
  }
}
