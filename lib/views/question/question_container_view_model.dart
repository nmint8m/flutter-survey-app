import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/model/enum/display_type.dart';
import 'package:kayla_flutter_ic/model/survey_detail.dart';
import 'package:kayla_flutter_ic/model/survey_submission.dart';
import 'package:kayla_flutter_ic/model/survey_submission_answer.dart';
import 'package:kayla_flutter_ic/model/survey_submission_question.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/usecases/survey/get_current_survey_detail_use_case.dart';
import 'package:kayla_flutter_ic/usecases/survey/get_current_survey_submission_use_case.dart';
import 'package:kayla_flutter_ic/usecases/survey/store_current_survey_submission_use_case.dart';
import 'package:kayla_flutter_ic/usecases/survey/submit_survey_answer_use_case.dart';
import 'package:kayla_flutter_ic/utils/route_paths.dart';
import 'package:kayla_flutter_ic/views/question/answers_container_ui_model.dart';
import 'package:kayla_flutter_ic/views/question/container_ui_model.dart';
import 'package:kayla_flutter_ic/views/question/question_container_state.dart';
import 'package:kayla_flutter_ic/views/question/question_container_ui_model.dart';

class QuestionContainerViewModel extends StateNotifier<QuestionContainerState> {
  final GetCurrentSurveyDetailUseCase _getCurrentSurveyDetailUseCase;
  final GetCurrentSurveySubmissionUseCase _getCurrentSurveySubmissionUseCase;
  final StoreCurrentSurveySubmissionUseCase
      _storeCurrentSurveySubmissionUseCase;
  final SubmitSurveyAnswerUseCase _submitSurveyAnswerUseCase;

  String get _surveyIdValue => _surveyId ?? '';
  String? _surveyId;

  int get _questionNumberValue => _questionNumber ?? 0;
  int? _questionNumber;

  SurveyDetail get _surveyValue => _survey ?? SurveyDetail.empty();
  SurveyDetail? _survey;

  ContainerUIModel get uiModel => _uiModel;
  ContainerUIModel _uiModel = ContainerUIModel(
    question: const QuestionContainerUiModel.empty(),
    answer: AnswerContainerUIModel.empty(),
  );

  List<String> _currentAnswerList = [];
  Map<String, String> _currentAnswerMap = <String, String>{};

  QuestionContainerViewModel(
    this._getCurrentSurveyDetailUseCase,
    this._getCurrentSurveySubmissionUseCase,
    this._storeCurrentSurveySubmissionUseCase,
    this._submitSurveyAnswerUseCase,
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
    final totalQuestions = _surveyValue.questions.length;
    if (totalQuestions == 0 ||
        (totalQuestions == 1 &&
            _surveyValue.questions.first.displayType == DisplayType.intro)) {
      _bindEmptyData();
    } else {
      _bindDataWithoutIntro();
    }
  }

  void _bindEmptyData() {
    _bindUIModelData(
      questionUiModel: const QuestionContainerUiModel.empty(),
      answerUiModel: AnswerContainerUIModel.empty(),
    );
  }

  void _bindDataWithoutIntro() {
    int totalQuestions = _surveyValue.questions.length;
    final questionIndex = _questionNumberValue + 1;
    if (_surveyValue.questions.first.displayType == DisplayType.intro) {
      totalQuestions--;
    }
    final questionsUiModel = QuestionContainerUiModel(
      questionIndex: questionIndex,
      totalQuestions: totalQuestions,
      title: _surveyValue.questions[questionIndex].text,
    );
    final displayType = _surveyValue.questions[questionIndex].displayType;
    final options = _surveyValue.questions[questionIndex].answers
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
    _bindUIModelData(
      questionUiModel: questionsUiModel,
      answerUiModel: answerUiModel,
    );
  }

  void _bindUIModelData({
    required QuestionContainerUiModel questionUiModel,
    required AnswerContainerUIModel answerUiModel,
  }) {
    final uiModel = ContainerUIModel(
      question: questionUiModel,
      answer: answerUiModel,
    );
    _uiModel = uiModel;
    state = QuestionContainerState.success(uiModel: uiModel);
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
    params[RoutePath.surveyDetail.pathParam] = _surveyIdValue;
    return params;
  }

  Map<String, String> getNextQuestionQueryParams(
      Map<String, String> arguments) {
    final nextQuestionNumber = _questionNumberValue + 1;
    var params = <String, String>{};
    params[RoutePath.question.queryParams.first] =
        nextQuestionNumber.toString();
    return params;
  }

  void storeAnswerList(List<String> ids) {
    _currentAnswerList = ids;
  }

  void storeAnswerMap(Map<String, String> answers) {
    _currentAnswerMap = answers;
  }

  void saveAnswer() {
    if (_currentAnswerList.isNotEmpty) {
      _saveAnswerList();
    }
    if (_currentAnswerMap.isNotEmpty) {
      _saveAnswerMap();
    }
  }

  void _saveAnswerList() async {
    final ids = _currentAnswerList;
    _storeAnswer(_idsToAnswers(ids));
  }

  void _saveAnswerMap() async {
    final answerMap = _currentAnswerMap;
    _storeAnswer(_answerMapToAnswers(answerMap));
  }

  void _storeAnswer(List<SurveySubmissionAnswer> answers) async {
    final result = await _getCurrentSurveySubmissionUseCase.call();
    if (result is Success<SurveySubmission?>) {
      var submission = result.value;
      if (submission == null) {
        submission = _newSurveySubmission(answers);
      } else if (submission.surveyId != _surveyIdValue ||
          _questionNumberValue == 0) {
        _clearStoredCurrentSurveySubmission();
        submission = _newSurveySubmission(answers);
      } else {
        submission = _addNewAnswerToSurveySubmission(
          submission,
          answers,
        );
      }
      _storeCurrentSurveySubmissionUseCase.call(submission);
    }
  }

  SurveySubmission _newSurveySubmission(
    List<SurveySubmissionAnswer> answers,
  ) {
    return SurveySubmission(
      surveyId: _surveyIdValue,
      questions: [
        SurveySubmissionQuestion(
          id: _surveyValue.questions[_questionNumberValue].id,
          answers: answers,
        ),
      ],
    );
  }

  SurveySubmission _addNewAnswerToSurveySubmission(
    SurveySubmission submission,
    List<SurveySubmissionAnswer> answers,
  ) {
    List<SurveySubmissionQuestion> questions = submission.questions;
    questions.add(
      SurveySubmissionQuestion(
        id: _surveyValue.questions[_questionNumberValue].id,
        answers: answers,
      ),
    );
    submission.questions = questions;
    return submission;
  }

  List<SurveySubmissionAnswer> _idsToAnswers(List<String> ids) {
    return ids
        .map(
          (id) => SurveySubmissionAnswer(
            id: id,
            answer: null,
          ),
        )
        .toList();
  }

  List<SurveySubmissionAnswer> _answerMapToAnswers(
      Map<String, String> answerMap) {
    List<SurveySubmissionAnswer> answers = [];
    answerMap.forEach(
      (key, value) {
        answers.add(
          SurveySubmissionAnswer(
            id: key,
            answer: value,
          ),
        );
      },
    );
    return answers;
  }

  void submitAnswers() async {
    final result = await _getCurrentSurveySubmissionUseCase.call();
    if (result is Success<SurveySubmission?>) {
      state = QuestionContainerState.submitting(uiModel: _uiModel);
      final submission = result.value;
      if (submission != null) {
        final result = await _submitSurveyAnswerUseCase.call(submission);
        if (result is Success<void>) {
          state = QuestionContainerState.submitted(uiModel: _uiModel);
          _clearStoredCurrentSurveySubmission();
        } else {
          _handleError(result as Failed);
        }
      }
    }
  }

  void _clearStoredCurrentSurveySubmission() {
    _storeCurrentSurveySubmissionUseCase.call(null);
  }

  void _handleError(Failed failure) {
    state = QuestionContainerState.error(
      uiModel: _uiModel,
      error: failure.errorMessage,
    );
  }
}
