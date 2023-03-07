import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/model/enum/display_type.dart';
import 'package:kayla_flutter_ic/model/survey_detail.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/usecases/survey/get_current_survey_detail_use_case.dart';
import 'package:kayla_flutter_ic/utils/route_paths.dart';
import 'package:kayla_flutter_ic/views/question/answers_container_ui_model.dart';
import 'package:kayla_flutter_ic/views/question/question_container_state.dart';
import 'package:kayla_flutter_ic/views/question/question_container_ui_model.dart';

class QuestionContainerViewModel extends StateNotifier<QuestionContainerState> {
  String get surveyId => _surveyId ?? '';
  int get questionNumber => _questionNumber ?? 0;
  SurveyDetail get survey => _survey ?? SurveyDetail.empty();

  final GetCurrentSurveyDetailUseCase _getCurrentSurveyDetailUseCase;
  String? _surveyId;
  int? _questionNumber;
  SurveyDetail? _survey;

  QuestionContainerViewModel(
    this._getCurrentSurveyDetailUseCase,
  ) : super(const QuestionContainerState.init());

  void setUpData({
    required Map<String, String> arguments,
  }) async {
    _surveyId = _setUpSurveyId(arguments);
    _questionNumber = _setUpQuestionNumber(arguments);
    _setUpSurveyDetailData().then((value) => _bindData());
  }

  Future<void> _setUpSurveyDetailData() async {
    final surveyResult = await _getCurrentSurveyDetailUseCase.call();
    if (surveyResult is Success<SurveyDetail?>) {
      _survey = surveyResult.value;
    }
  }

  void _bindData() {
    final totalQuestions = survey.questions.length;
    if (totalQuestions == 0 ||
        (totalQuestions == 1 &&
            survey.questions.first.displayType == DisplayType.intro)) {
      _bindEmptyData();
    } else {
      _bindDataWithoutIntro();
    }
  }

  void _bindEmptyData() {
    state = QuestionContainerState.success(
      questionUiModel: QuestionContainerUiModel.empty(),
      answerUiModel: AnswerContainerUIModel.empty(),
    );
  }

  void _bindDataWithoutIntro() {
    int totalQuestions = survey.questions.length;
    final questionIndex = questionNumber + 1;
    if (survey.questions.first.displayType == DisplayType.intro) {
      totalQuestions--;
    }
    final questionsUiModel = QuestionContainerUiModel(
      questionIndex: questionIndex,
      totalQuestions: totalQuestions,
      title: survey.questions[questionIndex].text,
    );
    final displayType = survey.questions[questionIndex].displayType;
    final options = survey.questions[questionIndex].answers
        .map(
          (answer) => OptionUiModel(
            index: answer.displayOrder,
            id: answer.id,
            title: answer.text,
          ),
        )
        .toList();
    final answerUiModel = AnswerContainerUIModel(
      displayType: displayType,
      options: options,
    );
    state = QuestionContainerState.success(
      questionUiModel: questionsUiModel,
      answerUiModel: answerUiModel,
    );
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
    var params = <String, String>{};
    params[RoutePath.surveyDetail.pathParam] = surveyId;
    return params;
  }

  Map<String, String> getNextQuestionQueryParams(
      Map<String, String> arguments) {
    final nextQuestionNumber = questionNumber + 1;
    var params = <String, String>{};
    params[RoutePath.question.queryParams.first] =
        nextQuestionNumber.toString();
    return params;
  }
}
