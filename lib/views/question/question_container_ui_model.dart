import 'package:equatable/equatable.dart';

class QuestionContainerUiModel extends Equatable {
  final int questionIndex;
  final int totalQuestions;
  final String title;

  const QuestionContainerUiModel({
    required this.questionIndex,
    required this.totalQuestions,
    required this.title,
  });

  const QuestionContainerUiModel.empty()
      : this(
          questionIndex: 0,
          totalQuestions: 0,
          title: '',
        );

  @override
  List<Object?> get props => [
        questionIndex,
        totalQuestions,
        title,
      ];
}
