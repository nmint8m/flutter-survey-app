import 'package:freezed_annotation/freezed_annotation.dart';

part 'survey_submission_answer.g.dart';

@JsonSerializable()
class SurveySubmissionAnswer {
  final String id;
  final String? answer;

  SurveySubmissionAnswer({
    required this.id,
    required this.answer,
  });

  Map<String, dynamic> toJson() => _$SurveySubmissionAnswerToJson(this);

  Map<String, dynamic> toObmitNullFieldsJson() {
    Map<String, dynamic> json = {'id': id};
    if (answer != null) {
      json['answer'] = answer;
    }
    return json;
  }

  factory SurveySubmissionAnswer.fromJson(Map<String, dynamic> json) =>
      _$SurveySubmissionAnswerFromJson(json);
}
