import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_state.freezed.dart';

@freezed
class QuestionState with _$QuestionState {
  const factory QuestionState.init() = _Init;

  const factory QuestionState.error(String? error) = _Error;
}
