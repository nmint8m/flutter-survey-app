import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kayla_flutter_ic/gen/assets.gen.dart';
import 'package:kayla_flutter_ic/utils/app_bar_ext.dart';
import 'package:kayla_flutter_ic/utils/route_paths.dart';
import 'package:kayla_flutter_ic/views/question/question_component_id.dart';
import 'package:kayla_flutter_ic/views/question/question_container_ui_model.dart';
import 'package:kayla_flutter_ic/views/question/question_container_view.dart';

class QuestionView extends StatelessWidget {
  final QuestionContainerUiModel uiModel;
  final Widget child;
  final Function() onNextQuestion;
  final Function() onSubmit;

  const QuestionView({
    super.key,
    required this.uiModel,
    required this.child,
    required this.onNextQuestion,
    required this.onSubmit,
  });

  AppBar _appBar(BuildContext context) => AppBarExt.appBarWithCloseButton(
        context: context,
        onPressed: () => context.pushReplacementNamed(
          RoutePath.home.name,
        ),
      );

  Widget _background(BuildContext context) => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // TODO: - Bind question's photo
        child: Image(
          image: Assets.images.nimbleBackground.image().image,
          fit: BoxFit.cover,
        ),
      );

  Widget _mainBody(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _questionNumber(context),
            const SizedBox(
              height: 16,
            ),
            _questionTitle(context),
            Expanded(child: child),
          ],
        ),
      );

  Widget _questionNumber(BuildContext context) =>
      Consumer(builder: (_, ref, __) {
        final state = ref.watch(questionViewModelProvider);
        return state.maybeWhen(
          orElse: () => const SizedBox.shrink(),
          success: (uiModel) => Text(
            '${uiModel.question.questionIndex}/${uiModel.question.totalQuestions}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      });

  Widget _questionTitle(BuildContext context) => Text(
        uiModel.title,
        style: Theme.of(context).textTheme.displayMedium,
      );

  Widget _floatingActionButton(BuildContext context) {
    final isLastQuestion = uiModel.totalQuestions > 0 &&
        uiModel.questionIndex == uiModel.totalQuestions;
    return isLastQuestion ? _submitButton(context) : _nextButton;
  }

  Widget get _nextButton => Padding(
        key: QuestionComponentId.nextButton,
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          onPressed: onNextQuestion,
          child: const Icon(Icons.navigate_next),
        ),
      );

  Widget _submitButton(BuildContext context) => Padding(
        key: QuestionComponentId.submitButton,
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(minimumSize: const Size(140, 56)),
          onPressed: onSubmit,
          child: Text(AppLocalizations.of(context)?.surveyDetailSubmit ?? ''),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _background(context),
        Container(color: Colors.black38),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _appBar(context),
          body: SafeArea(child: _mainBody(context)),
          floatingActionButton: _floatingActionButton(context),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        )
      ],
    );
  }
}
