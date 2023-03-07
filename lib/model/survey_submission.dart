import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kayla_flutter_ic/model/survey_submission_question.dart';

part 'survey_submission.g.dart';

@JsonSerializable()
class SurveySubmission {
  final String surveyId;
  final List<SurveySubmissionQuestion> questions;

  SurveySubmission({
    required this.surveyId,
    required this.questions,
  });

  Map<String, dynamic> toJson() => _$SurveySubmissionToJson(this);
}
