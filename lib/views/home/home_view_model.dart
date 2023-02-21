import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/api/response/surveys_response.dart';
import 'package:kayla_flutter_ic/model/profile.dart';
import 'package:kayla_flutter_ic/model/survey.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/usecases/survey/survey_list_params.dart';
import 'package:kayla_flutter_ic/usecases/survey/get_survey_list_use_case.dart';
import 'package:kayla_flutter_ic/usecases/user/get_profile_use_case.dart';
import 'package:kayla_flutter_ic/views/home/home_state.dart';
import 'package:kayla_flutter_ic/views/home/home_view.dart';

final profileImageUrlStream = StreamProvider.autoDispose<String>((ref) =>
    ref.watch(homeViewModelProvider.notifier)._profileImageUrlStream.stream);

final surveyListStream = StreamProvider.autoDispose<List<Survey>>((ref) =>
    ref.watch(homeViewModelProvider.notifier)._surveyListStream.stream);

final focusedItemIndexStream = StreamProvider.autoDispose<int>((ref) =>
    ref.watch(homeViewModelProvider.notifier)._focusedItemIndexStream.stream);

class HomeViewModel extends StateNotifier<HomeState> {
  final StreamController<String> _profileImageUrlStream = StreamController();
  final StreamController<List<Survey>> _surveyListStream = StreamController();
  final StreamController<int> _focusedItemIndexStream = StreamController();
  List<Survey> _surveyList = [];
  int _focusedItemIndex = 0;
  int _page = 1;
  bool _isEnded = false;

  final GetProfileUseCase _getProfileUseCase;
  final GetSurveyListUseCase _getSurveyListUseCase;

  HomeViewModel(
    this._getProfileUseCase,
    this._getSurveyListUseCase,
  ) : super(const HomeState.init());

  Future<void> fetchProfile() async {
    final result = await _getProfileUseCase.call();
    if (result is Success<Profile>) {
      _profileImageUrlStream.add(result.value.avatarUrl);
    } else {
      _handleError(result as Failed);
    }
  }

  Future<void> fetchSurveyList({bool isRefresh = false}) async {
    if (isRefresh) {
      _page = 1;
      _isEnded = false;
    }
    if (_isEnded) {
      return;
    }
    final result = await _getSurveyListUseCase.call(SurveyListParams(
      pageNumber: _page,
      pageSize: 5,
    ));
    if (result is Success<SurveysResponse>) {
      _page++;
      _isEnded = _page > result.value.meta.pages;
      final newSurveyList = result.value.data.map((e) => e.toSurvey()).toList();
      _handleSuccess(
        newSurveyList: newSurveyList,
        isRefresh: isRefresh,
      );
    } else {
      _handleError(result as Failed);
    }
  }

  void _handleSuccess({
    required List<Survey> newSurveyList,
    required bool isRefresh,
  }) {
    if (isRefresh) {
      _focusedItemIndexStream.add(0);
      _surveyList = newSurveyList;
      _surveyListStream.add(_surveyList);
    } else {
      _focusedItemIndexStream.add(_focusedItemIndex);
      _surveyList.addAll(newSurveyList);
      _surveyListStream.add(_surveyList);
    }
  }

  void _handleError(Failed failure) {
    state = HomeState.error(failure.errorMessage);
  }

  void changeFocusedItem({required int index}) {
    _focusedItemIndex = index;
    _focusedItemIndexStream.add(index);
  }
}
