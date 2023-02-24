import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/model/survey_detail.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/usecases/survey/get_survey_detail_use_case.dart';
import 'package:kayla_flutter_ic/views/survey_detail/survey_detail_state.dart';
import 'package:kayla_flutter_ic/views/survey_detail/survey_detail_ui_model.dart';
import 'package:kayla_flutter_ic/views/survey_detail/survey_detail_view.dart';

final surveyDetailStream = StreamProvider.autoDispose<SurveyDetail?>((ref) {
  return ref
      .watch(surveyDetailViewModelProvider.notifier)
      ._surveyDetailStream
      .stream;
});

final surveyDetailUiModelStream =
    StreamProvider.autoDispose<SurveyDetailUiModel>((ref) {
  return ref
      .watch(surveyDetailViewModelProvider.notifier)
      ._surveyDetailUiModelStream
      .stream;
});

class SurveyDetailViewModel extends StateNotifier<SurveyDetailState> {
  final GetSurveyDetailUseCase _getSurveyDetailUseCase;
  final StreamController<SurveyDetail> _surveyDetailStream = StreamController();
  final StreamController<SurveyDetailUiModel> _surveyDetailUiModelStream =
      StreamController();

  SurveyDetailViewModel(this._getSurveyDetailUseCase)
      : super(const SurveyDetailState.init());

  void fetchSurvey(String id) async {
    final result = await _getSurveyDetailUseCase.call(id);
    if (result is Success<SurveyDetail>) {
      _surveyDetailStream.add(result.value);
      _bindData(result.value);
    } else {
      _handleError(result as Failed);
    }
  }

  void _handleError(Failed failure) {
    state = SurveyDetailState.error(failure.errorMessage);
  }

  void _bindData(SurveyDetail data) {
    _surveyDetailUiModelStream.add(data.toSurveyDetailUiModel());
  }
}
