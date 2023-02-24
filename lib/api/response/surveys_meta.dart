import 'package:json_annotation/json_annotation.dart';
import 'package:kayla_flutter_ic/api/response/base_response_converter.dart';

part 'surveys_meta.g.dart';

@JsonSerializable()
class SurveysMeta {
  int page;
  int pages;
  int pageSize;
  int records;

  SurveysMeta({
    required this.page,
    required this.pages,
    required this.pageSize,
    required this.records,
  });

  factory SurveysMeta.fromJson(Map<String, dynamic> json) =>
      _$SurveysMetaFromJson(fromJsonApi(json));
}
