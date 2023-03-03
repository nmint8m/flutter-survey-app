import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kayla_flutter_ic/views/survey_detail/survey_detail_ui_model.dart';

part 'survey_detail_state.freezed.dart';

@freezed
class SurveyDetailState with _$SurveyDetailState {
  const factory SurveyDetailState.init() = _Init;

  const factory SurveyDetailState.loading() = _Loading;

  const factory SurveyDetailState.error(String? error) = _Error;

  const factory SurveyDetailState.success(SurveyDetailUiModel uiModel) =
      _Success;
}
