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
}
