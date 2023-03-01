import 'package:freezed_annotation/freezed_annotation.dart';

part 'multiple_choice_state.freezed.dart';

@freezed
class MultipleChoiceState with _$MultipleChoiceState {
  const factory MultipleChoiceState.init() = _Init;
}
