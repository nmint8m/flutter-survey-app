import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/views/question/question_container_state.dart';
import 'package:kayla_flutter_ic/views/question/question_container_ui_model.dart';
import 'package:kayla_flutter_ic/views/question/question_container_view.dart';

final questionContainerUiModelStream =
    StreamProvider.autoDispose<QuestionContainerUiModel>(
  (ref) {
    return ref.watch(questionViewModelProvider.notifier)._uiModelStream.stream;
  },
);

class QuestionContainerViewModel extends StateNotifier<QuestionContainerState> {
  final StreamController<QuestionContainerUiModel> _uiModelStream =
      StreamController();

  String _surveyId = '';
  int _questionNumber = 0;

  QuestionContainerViewModel() : super(const QuestionContainerState.init());

  void bindData({
    required String surveyId,
    required int questionNumber,
  }) {
    _surveyId = surveyId;
    _questionNumber = questionNumber;
    // TODO: - Remove hard code
    _uiModelStream.add(QuestionContainerUiModel(
      currentQuestionIndex: _questionNumber + 1,
      totalQuestions: 10,
      title: _surveyId,
    ));
  }
}
