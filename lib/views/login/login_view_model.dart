import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/model/oauth_login.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/usecases/oath/login_use_case.dart';
import 'package:kayla_flutter_ic/views/login/login_state.dart';

class LoginViewModel extends StateNotifier<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase) : super(const LoginState.init());

  void login({
    required String email,
    required String password,
  }) async {
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
