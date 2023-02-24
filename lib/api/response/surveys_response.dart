import 'package:json_annotation/json_annotation.dart';
import 'package:kayla_flutter_ic/api/response/base_response_converter.dart';
import 'package:kayla_flutter_ic/api/response/survey_response.dart';

part 'surveys_response.g.dart';

@JsonSerializable()
class SurveysResponse {
  final List<SurveyResponse> data;

  const SurveysResponse({
    required this.data,
  });

  factory SurveysResponse.fromJson(Map<String, dynamic> json) {
    return _$SurveysResponseFromJson(fromRootJsonApi(json));
  }
}
