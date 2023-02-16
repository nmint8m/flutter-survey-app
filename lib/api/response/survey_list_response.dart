import 'package:json_annotation/json_annotation.dart';
import 'package:kayla_flutter_ic/api/response/base_response_converter.dart';
import 'package:kayla_flutter_ic/api/response/survey_response.dart';

part 'survey_list_response.g.dart';

@JsonSerializable()
class SurveyListResponse {
  @JsonKey(name: 'data')
  final List<SurveyResponse> surveys;

  const SurveyListResponse({
    required this.surveys,
  });

  factory SurveyListResponse.fromJson(Map<String, dynamic> json) {
    return _$SurveyListResponseFromJson(fromJsonApi(json));
  }
}
