import 'package:json_annotation/json_annotation.dart';
import 'package:kayla_flutter_ic/api/response/base_response_converter.dart';
import 'package:kayla_flutter_ic/api/response/question_response.dart';
import 'package:kayla_flutter_ic/model/survey_detail.dart';

part 'survey_detail_response.g.dart';

@JsonSerializable()
class SurveyDetailResponse {
  final String id;
  final String? title;
  final String? description;
  final String? coverImageUrl;
  final List<QuestionResponse>? questions;

  SurveyDetailResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImageUrl,
    required this.questions,
  });

  factory SurveyDetailResponse.fromJson(Map<String, dynamic> json) {
    return _$SurveyDetailResponseFromJson(fromJsonApi(json));
  }

  SurveyDetail toSurveyDetail() => SurveyDetail(
        id: id,
        title: title ?? '',
        description: description ?? '',
        coverImageUrl: coverImageUrl ?? '',
        questions:
            (questions ?? []).map((question) => question.toQuestion()).toList(),
      );
}
