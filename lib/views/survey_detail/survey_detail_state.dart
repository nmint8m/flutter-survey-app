import 'package:freezed_annotation/freezed_annotation.dart';

part 'survey_detail_state.freezed.dart';

@freezed
class SurveyDetailState with _$SurveyDetailState {
  const factory SurveyDetailState.init() = _Init;

  const factory SurveyDetailState.loading() = _Loading;

  const factory SurveyDetailState.error(String? error) = _Error;

  const factory SurveyDetailState.success() = _Success;
}
