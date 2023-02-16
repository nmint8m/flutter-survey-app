import 'package:json_annotation/json_annotation.dart';
import 'package:kayla_flutter_ic/api/response/base_response_converter.dart';
import 'package:kayla_flutter_ic/api/response/survey_response.dart';

part 'survey_list_response.g.dart';

@JsonSerializable()
class SurveyListResponse {
  final List<SurveyResponse> data;

  const SurveyListResponse({
    required this.data,
  });

  factory SurveyListResponse.fromJson(Map<String, dynamic> json) {
    return _$SurveyListResponseFromJson(fromRootJsonApi(json));
  }
}
