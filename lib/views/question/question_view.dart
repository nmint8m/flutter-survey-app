import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kayla_flutter_ic/gen/assets.gen.dart';
import 'package:kayla_flutter_ic/utils/app_bar_ext.dart';
import 'package:kayla_flutter_ic/utils/route_paths.dart';
import 'package:kayla_flutter_ic/views/question/question_container_view.dart';
import 'package:kayla_flutter_ic/views/question/question_container_view_model.dart';

class QuestionView extends ConsumerStatefulWidget {
  final Widget child;
  final Function() onNextQuestion;
  final Function() onSubmit;

  const QuestionView({
    super.key,
    required this.child,
    required this.onNextQuestion,
    required this.onSubmit,
  });

  @override
  QuestionViewState createState() => QuestionViewState();
}

class QuestionViewState extends ConsumerState<QuestionView> {
  AppBar get _appBar => AppBarExt.appBarWithCloseButton(
        context: context,
        onPressed: () => context.goNamed(
          RoutePath.home.name,
        ),
      );

  Widget get _background => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // TODO: - Bind question's photo
        child: Image(image: Assets.images.nimbleBackground.image().image),
      );

  Widget get _mainBody => Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _questionNumber,
            const SizedBox(
              height: 16,
            ),
            _questionTitle,
            SingleChildScrollView(child: widget.child),
          ],
        ),
      );

  Widget get _questionNumber => Consumer(builder: (_, ref, __) {
        final state = ref.watch(questionViewModelProvider);
        return state.maybeWhen(
          orElse: () => const Text(''),
          success: (uiModel) => Text(
            '${uiModel.currentQuestionIndex}/${uiModel.totalQuestions}',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      });

  Widget get _questionTitle => Consumer(builder: (_, ref, __) {
        final state = ref.watch(questionViewModelProvider);
        return state.maybeWhen(
          orElse: () => const Text(''),
          success: (uiModel) => Text(
            uiModel.title,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        );
      });

  Widget get _floatingActionButton => Consumer(builder: (_, ref, __) {
        final state = ref.watch(questionViewModelProvider);
        return state.maybeWhen(
          orElse: () => _submitButton,
          success: (uiModel) {
            final isLastQuestion = uiModel.totalQuestions > 0 &&
                uiModel.currentQuestionIndex == uiModel.totalQuestions;
            return isLastQuestion ? _submitButton : _nextButton;
          },
        );
      });

  Widget get _nextButton => FloatingActionButton(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        child: const Icon(Icons.navigate_next),
        onPressed: () => _nextQuestion(),
      );

  Widget get _submitButton => ElevatedButton(
        style: ElevatedButton.styleFrom(minimumSize: const Size(140, 56)),
        onPressed: () => _submit(),
        child: const Text('Submit'),
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _background,
        Container(color: Colors.black38),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _appBar,
          body: SafeArea(child: _mainBody),
          floatingActionButton: _floatingActionButton,
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        )
      ],
    );
  }

  void _nextQuestion() {
    widget.onNextQuestion();
  }

  void _submit() {
    widget.onSubmit();
  }
}
