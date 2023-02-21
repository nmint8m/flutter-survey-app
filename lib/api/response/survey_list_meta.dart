import 'package:json_annotation/json_annotation.dart';
import 'package:kayla_flutter_ic/api/response/base_response_converter.dart';

part 'survey_list_meta.g.dart';

@JsonSerializable()
class SurveyListMeta {
  int page;
  int pages;
  int pageSize;
  int records;

  SurveyListMeta({
    required this.page,
    required this.pages,
    required this.pageSize,
    required this.records,
  });

  factory SurveyListMeta.fromJson(Map<String, dynamic> json) =>
      _$SurveyListMetaFromJson(fromJsonApi(json));
}
