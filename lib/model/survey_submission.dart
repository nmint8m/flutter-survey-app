import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kayla_flutter_ic/model/survey_submission_question.dart';

part 'survey_submission.g.dart';

@JsonSerializable()
class SurveySubmission {
  final String surveyId;
  List<SurveySubmissionQuestion> questions;

  SurveySubmission({
    required this.surveyId,
    required this.questions,
  });

  SurveySubmission.empty()
      : this(
          surveyId: '',
          questions: [],
        );

  Map<String, dynamic> toJson() => _$SurveySubmissionToJson(this);

  Map<String, dynamic> toObmitNullFieldsJson() {
    return {
      'survey_id': surveyId,
      'questions': questions
          .map((question) => question.toObmitNullFieldsJson())
          .toList(),
    };
  }

  factory SurveySubmission.fromJson(Map<String, dynamic> json) =>
      _$SurveySubmissionFromJson(json);
}
