import 'package:freezed_annotation/freezed_annotation.dart';

part 'forget_password_state.freezed.dart';

@freezed
class ForgetPasswordState with _$ForgetPasswordState {
  const factory ForgetPasswordState.init() = _Init;

  const factory ForgetPasswordState.loading() = _Loading;

  const factory ForgetPasswordState.error(String? error) = _Error;

  const factory ForgetPasswordState.success() = _Success;
}
