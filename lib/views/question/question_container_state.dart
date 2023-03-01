import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kayla_flutter_ic/views/question/question_container_ui_model.dart';

part 'question_container_state.freezed.dart';

@freezed
class QuestionContainerState with _$QuestionContainerState {
  const factory QuestionContainerState.init() = _Init;

  const factory QuestionContainerState.success(QuestionContainerUiModel uiModel) = _Success;
}
