import 'package:email_validator/email_validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/model/oauth_login.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/usecases/oath/login_use_case.dart';
import 'package:kayla_flutter_ic/views/login/login_state.dart';
import 'package:rxdart/rxdart.dart';

class LoginViewModel extends StateNotifier<LoginState> {
  Stream<String?> get emailWarningMessageStream =>
      _emailWarningMessageSubject.stream;
  Stream<String?> get passwordWarningMessageStream =>
      _passwordWarningMessageSubject.stream;

  static const _passwordRequiredLength = 8;

  final LoginUseCase _loginUseCase;
  final BehaviorSubject<String?> _emailWarningMessageSubject =
      BehaviorSubject();
  final BehaviorSubject<String?> _passwordWarningMessageSubject =
      BehaviorSubject();

  LoginViewModel(this._loginUseCase) : super(const LoginState.init());

  void validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      _emailWarningMessageSubject.add('Please enter your email!');
    } else if (!EmailValidator.validate(email)) {
      _emailWarningMessageSubject.add('Wrong email format.');
    } else {
      _emailWarningMessageSubject.add(null);
    }
  }

  void validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      _passwordWarningMessageSubject.add('Please enter your password!');
    } else if (password.length < _passwordRequiredLength) {
      _passwordWarningMessageSubject
          .add('The password should longer 8 characters.');
    } else {
      _passwordWarningMessageSubject.add(null);
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
