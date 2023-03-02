import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kayla_flutter_ic/utils/durations.dart';
import 'package:kayla_flutter_ic/utils/route_paths.dart';
import 'package:kayla_flutter_ic/views/answer/single_choice/single_choice_option_ui_model.dart';
import 'package:kayla_flutter_ic/views/answer/single_choice/single_choice_view.dart';
import 'package:kayla_flutter_ic/views/question/question_container_state.dart';
import 'package:kayla_flutter_ic/views/question/question_container_view_model.dart';
import 'package:kayla_flutter_ic/views/question/question_view.dart';

final questionViewModelProvider = StateNotifierProvider.autoDispose<
    QuestionContainerViewModel, QuestionContainerState>(
  (_) => QuestionContainerViewModel(),
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
  Map<String, String> arguments(BuildContext context) =>
      ModalRoute.of(context)?.settings.arguments as Map<String, String>;

  @override
  void initState() {
    super.initState();
    _setUpData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, __) {
        final state = ref.watch(questionViewModelProvider);
        return state.maybeWhen(
          orElse: () => Container(),
          success: (uiModel) => QuestionView(
            uiModel: uiModel,
            // TODO: - Remove hard code
            child: SingleChoiceView(
              uiModels: List.generate(
                10,
                (index) => SingleChoiceOptionUIModel(
                  id: index.toString(),
                  title: 'Somewhat fulfilled $index',
                  isSelected: false,
                ),
              ),
            ),
            onNextQuestion: () => _nextQuestion(),
            onSubmit: () => _submit(),
          ),
        );
      },
    );
  }

  void _setUpData() {
    Future.delayed(Durations.zeroSecond, () {
      ref
          .read(questionViewModelProvider.notifier)
          .setUpData(arguments(context));
      ref.read(questionViewModelProvider.notifier).bindData();
    });
  }

  void _nextQuestion() {
    context.pushNamed(
      RoutePath.question.name,
      params: _getPathParams(),
      queryParams: _getNextQuestionQueryParams(),
    );
  }

  Map<String, String> _getPathParams() {
    return ref
        .read(questionViewModelProvider.notifier)
        .getPathParams(arguments(context));
  }

  Map<String, String> _getNextQuestionQueryParams() {
    return ref
        .read(questionViewModelProvider.notifier)
        .getNextQuestionQueryParams(arguments(context));
  }

  void _submit() {
    // TODO: - Integration task
    // ignore: avoid_print
    print('Submit survey!');
  }
}
