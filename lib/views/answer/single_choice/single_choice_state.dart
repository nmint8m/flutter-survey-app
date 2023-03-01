import 'package:freezed_annotation/freezed_annotation.dart';

part 'single_choice_state.freezed.dart';

@freezed
class SingleChoiceState with _$SingleChoiceState {
  const factory SingleChoiceState.init() = _Init;
}
