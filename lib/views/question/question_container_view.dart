import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kayla_flutter_ic/utils/route_paths.dart';
import 'package:kayla_flutter_ic/views/question/question_container_state.dart';
import 'package:kayla_flutter_ic/views/question/question_container_view_model.dart';
import 'package:kayla_flutter_ic/views/question/question_view.dart';

final questionViewModelProvider = StateNotifierProvider.autoDispose<
    QuestionContainerViewModel, QuestionContainerState>(
  (ref) {
    return QuestionContainerViewModel();
  },
);

class QuestionContainerView extends ConsumerStatefulWidget {
  final String surveyId;
  final int questionNumber;

  const QuestionContainerView({
    super.key,
    required this.surveyId,
    required this.questionNumber,
  });

  @override
  QuestionContainerViewState createState() => QuestionContainerViewState();
}

class QuestionContainerViewState extends ConsumerState<QuestionContainerView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _setUpData();
    return QuestionView(
      child: Container(),
      onNextQuestion: () => _nextQuestion(),
      onSubmit: () => _submit(),
    );
  }

  void _setUpData() {
    ref.read(questionViewModelProvider.notifier).bindData(
          surveyId: _getSurveyId(),
          questionNumber: _getQuestionNumber(),
        );
  }

  void _nextQuestion() {
    try {
      Map<String, String> params = <String, String>{};
      params[RoutePath.surveyDetail.pathParam] = _getSurveyId();

      final nextQuestionNumber = _getQuestionNumber() + 1;
      Map<String, String> queryParams = <String, String>{};
      queryParams[RoutePath.question.queryParams.first] =
          nextQuestionNumber.toString();

      final location = context.namedLocation(
        RoutePath.question.name,
        params: params,
        queryParams: queryParams,
      );
      context.go(location);
      // TODO: - Remmove print
      // ignore: avoid_print
      print('GoRouter location: $location');
    } catch (error) {
      // ignore: avoid_print
      print(error);
    }
  }

  String _getSurveyId() {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    return arguments[RoutePath.question.pathParam] ?? '';
  }

  int _getQuestionNumber() {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    return int.parse(arguments[RoutePath.question.queryParams.first] ?? '0');
  }

  void _submit() {
    // TODO: - Integration task
    // ignore: avoid_print
    print('Submit survey!');
  }
}
