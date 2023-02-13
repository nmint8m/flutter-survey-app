import 'package:email_validator/email_validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/usecases/oath/forget_password_use_case.dart';
import 'package:kayla_flutter_ic/views/forget_password/forget_password_state.dart';

class ForgetPasswordViewModel extends StateNotifier<ForgetPasswordState> {
  String? get emailWarningMessage => _emailWarningMessage;
  String? get successMessage => _successMessage;

  final ForgetPasswordUseCase _forgetPasswordUseCase;
  String? _emailWarningMessage;
  String? _successMessage;

  ForgetPasswordViewModel(this._forgetPasswordUseCase)
      : super(const ForgetPasswordState.init());

  void validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      _emailWarningMessage = 'Please enter your email!';
    } else if (!EmailValidator.validate(email)) {
      _emailWarningMessage = 'Wrong email format.';
    } else {
      _emailWarningMessage = null;
    }
  }

  void forgetPassword({
    required String email,
  }) async {
    state = const ForgetPasswordState.loading();
    final result = await _forgetPasswordUseCase.call(email);
    if (result is Success<String>) {
      _successMessage = result.value;
      state = const ForgetPasswordState.success();
    } else {
      _successMessage = '';
      _handleError(result as Failed);
    }
  }

  // ignore: unused_element
  void _handleError(Failed failure) {
    state = ForgetPasswordState.error(failure.errorMessage);
  }
}
