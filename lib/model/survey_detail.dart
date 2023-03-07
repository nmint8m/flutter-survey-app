import 'package:kayla_flutter_ic/model/enum/display_type.dart';
import 'package:kayla_flutter_ic/model/question.dart';
import 'package:kayla_flutter_ic/views/survey_detail/survey_detail_ui_model.dart';

class SurveyDetail {
  final String id;
  final String title;
  final String description;
  final String coverImageUrl;
  final List<Question> questions;

  SurveyDetail({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImageUrl,
    required this.questions,
  });

  SurveyDetail.empty()
      : this(
          id: '',
          title: '',
          description: '',
          coverImageUrl: '',
          questions: [],
        );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'coverImageUrl': coverImageUrl,
      'questions': questions.map((e) => e.toJson()).toList(),
    };
  }

  factory SurveyDetail.fromJson(Map<String, dynamic> json) {
    String id = json['id'];
    String title = json['title'];
    String description = json['description'];
    String coverImageUrl = json['coverImageUrl'];
    dynamic maybeQuestions = json['questions'];
    List<Question> questions = [];
    if (maybeQuestions is List) {
      for (dynamic maybeQuestion in maybeQuestions) {
        if (maybeQuestion is Map<String, dynamic>) {
          questions.add(Question.fromJson(maybeQuestion));
        }
      }
    }
    return SurveyDetail(
      id: id,
      title: title,
      description: description,
      coverImageUrl: coverImageUrl,
      questions: questions,
    );
  }

  SurveyDetailUiModel toSurveyDetailUiModel() {
    final introSection =
        questions.firstWhere((question) => question.displayType == DisplayType.intro);
    final description =
        introSection.text.isEmpty ? this.description : introSection.text;
    String imageUrl = introSection.imageUrl.isEmpty
        ? introSection.coverImageUrl
        : introSection.imageUrl;
    imageUrl = imageUrl.isEmpty ? coverImageUrl : imageUrl;
    return SurveyDetailUiModel(
      title: title,
      description: description,
      imageUrl: imageUrl,
    );
  }
}
