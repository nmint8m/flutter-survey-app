import 'package:json_annotation/json_annotation.dart';
import 'package:kayla_flutter_ic/api/response/base_response_converter.dart';
import 'package:kayla_flutter_ic/model/survey.dart';

part 'survey_response.g.dart';

@JsonSerializable()
class SurveyResponse {
  final String id;
  final String title;
  final String description;
  final String coverImageUrl;

  SurveyResponse({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImageUrl,
  });

  factory SurveyResponse.fromJson(Map<String, dynamic> json) =>
      _$SurveyResponseFromJson(fromJsonApi(json));

  Survey toSurvey() => Survey(
        id: id,
        title: title,
        description: description,
        coverImageUrl: coverImageUrl,
      );
}
