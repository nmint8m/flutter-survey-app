import 'package:email_validator/email_validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/views/forget_password/forget_password_state.dart';

class ForgetPasswordViewModel extends StateNotifier<ForgetPasswordState> {
  String? get emailWarningMessage => _emailWarningMessage;

  String? _emailWarningMessage;

  ForgetPasswordViewModel() : super(const ForgetPasswordState.init());

  void validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      _emailWarningMessage = 'Please enter your email!';
    } else if (!EmailValidator.validate(email)) {
      _emailWarningMessage = 'Wrong email format.';
    } else {
      _emailWarningMessage = null;
    }
  }

  void reset({
    required String email,
  }) async {}

  // ignore: unused_element
  void _handleError(Failed failure) {
    state = ForgetPasswordState.error(failure.errorMessage);
  }
}
