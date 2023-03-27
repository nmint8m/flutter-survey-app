import 'package:equatable/equatable.dart';
import 'package:kayla_flutter_ic/views/question/answers_container_ui_model.dart';
import 'package:kayla_flutter_ic/views/question/question_container_ui_model.dart';

class ContainerUIModel extends Equatable {
  final QuestionContainerUiModel question;
  final AnswerContainerUIModel answer;

  const ContainerUIModel({
    required this.question,
    required this.answer,
  });

  @override
  List<Object?> get props => [
        question,
        answer,
      ];
}
