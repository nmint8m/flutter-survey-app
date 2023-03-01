import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_container_state.freezed.dart';

@freezed
class QuestionContainerState with _$QuestionContainerState {
  const factory QuestionContainerState.init() = _Init;

  const factory QuestionContainerState.error(String? error) = _Error;
}
