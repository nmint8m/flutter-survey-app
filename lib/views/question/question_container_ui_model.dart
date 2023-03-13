class QuestionContainerUiModel {
  int questionIndex;
  int totalQuestions;
  String title;

  QuestionContainerUiModel({
    required this.questionIndex,
    required this.totalQuestions,
    required this.title,
  });

  QuestionContainerUiModel.empty()
      : this(
          questionIndex: 0,
          totalQuestions: 0,
          title: '',
        );
}
