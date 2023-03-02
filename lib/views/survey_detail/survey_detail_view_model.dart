import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/model/survey_detail.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/usecases/survey/get_survey_detail_use_case.dart';
import 'package:kayla_flutter_ic/utils/durations.dart';
import 'package:kayla_flutter_ic/views/survey_detail/survey_detail_state.dart';

class SurveyDetailViewModel extends StateNotifier<SurveyDetailState> {
  final GetSurveyDetailUseCase _getSurveyDetailUseCase;

  SurveyDetailViewModel(this._getSurveyDetailUseCase)
      : super(const SurveyDetailState.init());

  void fetchSurvey(String id) async {
    Future.delayed(
      Durations.fiftyMillisecond,
      () => state = const SurveyDetailState.loading(),
    );
    final result = await _getSurveyDetailUseCase.call(id);
    if (result is Success<SurveyDetail>) {
      _bindData(result.value);
    } else {
      _handleError(result as Failed);
    }
  }

  void _handleError(Failed failure) {
    state = SurveyDetailState.error(failure.errorMessage);
  }

  void _bindData(SurveyDetail data) {
    state = SurveyDetailState.success(data.toSurveyDetailUiModel());
  }
}
