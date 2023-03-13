import 'package:kayla_flutter_ic/views/question/answers_container_ui_model.dart';
import 'package:kayla_flutter_ic/views/question/question_container_ui_model.dart';

class ContainerUIModel {
  QuestionContainerUiModel question;
  AnswerContainerUIModel answer;

  ContainerUIModel({
    required this.question,
    required this.answer,
  });
}
