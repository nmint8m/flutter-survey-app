import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/model/profile.dart';
import 'package:kayla_flutter_ic/model/survey.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/usecases/survey/survey_list_params.dart';
import 'package:kayla_flutter_ic/usecases/survey/survey_list_use_case.dart';
import 'package:kayla_flutter_ic/usecases/user/get_profile_use_case.dart';
import 'package:kayla_flutter_ic/views/home/home_state.dart';
import 'package:kayla_flutter_ic/views/home/home_view.dart';

final profileImageUrlStream = StreamProvider.autoDispose<String>((ref) =>
    ref.watch(homeViewModelProvider.notifier)._profileImageUrlStream.stream);

final surveyListStream = StreamProvider.autoDispose<List<String>>((ref) =>
    ref.watch(homeViewModelProvider.notifier)._surveyListStream.stream);

class HomeViewModel extends StateNotifier<HomeState> {
  final StreamController<String> _profileImageUrlStream = StreamController();
  final StreamController<List<String>> _surveyListStream = StreamController();

  final ProfileUseCase _profileUseCase;
  final SurveyListUseCase _surveyListUseCase;

  HomeViewModel(
    this._profileUseCase,
    this._surveyListUseCase,
  ) : super(const HomeState.init());

  Future<void> fetchProfile() async {
    final result = await _profileUseCase.call();
    if (result is Success<Profile>) {
      _profileImageUrlStream.add(result.value.avatarUrl);
    } else {
      _handleError(result as Failed);
    }
  }

  Future<void> fetchSurveyList() async {
    final result = await _surveyListUseCase.call(SurveyListParams(
      pageNumber: 1,
      pageSize: 10,
    ));
    if (result is Success<List<Survey>>) {
      // TODO: - Stream the survey list instead
      _surveyListStream.add(result.value.map((e) => e.title).toList());
    } else {
      _handleError(result as Failed);
    }
  }

  void _handleError(Failed failure) {
    state = HomeState.error(failure.errorMessage);
  }
}
