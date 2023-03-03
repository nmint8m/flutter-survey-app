import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/utils/route_paths.dart';
import 'package:kayla_flutter_ic/views/question/question_container_state.dart';
import 'package:kayla_flutter_ic/views/question/question_container_ui_model.dart';

final _answers = <String, String>{};

class QuestionContainerViewModel extends StateNotifier<QuestionContainerState> {
  String get surveyId => _surveyId ?? '';
  int get questionNumber => _questionNumber ?? 0;

  String? _surveyId;
  int? _questionNumber;

  QuestionContainerViewModel() : super(const QuestionContainerState.init());

  void setUpData(Map<String, String> arguments) {
    _surveyId = _setUpSurveyId(arguments);
    _questionNumber = _setUpQuestionNumber(arguments);
  }

  void bindData() {
    // TODO: - Remove hard code of total question
    final uiModel = QuestionContainerUiModel(
      currentQuestionIndex: questionNumber + 1,
      totalQuestions: 10,
      title: surveyId,
    );
    state = QuestionContainerState.success(uiModel);
  }

  void submitCurrentAnswer(String answer) {
    // TODO: - Integrate task
    _answers['$questionNumber'] = answer;
    // ignore: avoid_print
    print(_answers);
  }

  String _setUpSurveyId(Map<String, String> arguments) {
    return arguments[RoutePath.question.pathParam] ?? '';
  }

  int _setUpQuestionNumber(Map<String, String> arguments) {
    final questionNumber =
        arguments[RoutePath.question.queryParams.first] ?? '0';
    return int.parse(questionNumber);
  }

  Map<String, String> getPathParams(Map<String, String> arguments) {
    Map<String, String> params = <String, String>{};
    params[RoutePath.surveyDetail.pathParam] = surveyId;
    return params;
  }

  Map<String, String> getNextQuestionQueryParams(
      Map<String, String> arguments) {
    final nextQuestionNumber = questionNumber + 1;
    Map<String, String> params = <String, String>{};
    params[RoutePath.question.queryParams.first] =
        nextQuestionNumber.toString();
    return params;
  }
}
