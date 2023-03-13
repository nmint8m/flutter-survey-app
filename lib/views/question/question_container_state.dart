import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kayla_flutter_ic/views/question/container_ui_model.dart';

part 'question_container_state.freezed.dart';

@freezed
class QuestionContainerState with _$QuestionContainerState {
  const factory QuestionContainerState.init() = _Init;

  const factory QuestionContainerState.submitting({
    required ContainerUIModel uiModel,
  }) = _Submitting;

  const factory QuestionContainerState.submitted({
    required ContainerUIModel uiModel,
  }) = _Submitted;

  const factory QuestionContainerState.error({
    required ContainerUIModel uiModel,
    required String? error,
  }) = _Error;

  const factory QuestionContainerState.success({
    required ContainerUIModel uiModel,
  }) = _Success;
}
