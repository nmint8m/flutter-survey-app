import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/api/response/surveys_response.dart';
import 'package:kayla_flutter_ic/model/profile.dart';
import 'package:kayla_flutter_ic/model/survey.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/usecases/oath/logout_use_case.dart';
import 'package:kayla_flutter_ic/usecases/survey/get_surveys_params.dart';
import 'package:kayla_flutter_ic/usecases/survey/get_surveys_use_case.dart';
import 'package:kayla_flutter_ic/usecases/user/get_profile_use_case.dart';
import 'package:kayla_flutter_ic/views/home/home_state.dart';
import 'package:kayla_flutter_ic/views/home/home_view.dart';

final profileImageUrlStream = StreamProvider.autoDispose<String>((ref) =>
    ref.watch(homeViewModelProvider.notifier)._profileImageUrlStream.stream);

final surveysStream = StreamProvider.autoDispose<List<Survey>>(
    (ref) => ref.watch(homeViewModelProvider.notifier)._surveysStream.stream);

final focusedItemIndexStream = StreamProvider.autoDispose<int>((ref) =>
    ref.watch(homeViewModelProvider.notifier)._focusedItemIndexStream.stream);

class HomeViewModel extends StateNotifier<HomeState> {
  final StreamController<String> _profileImageUrlStream = StreamController();
  final StreamController<List<Survey>> _surveysStream = StreamController();
  final StreamController<int> _focusedItemIndexStream = StreamController();
  List<Survey> _surveys = [];
  int _focusedItemIndex = 0;
  int _page = 1;
  bool _isEnded = false;

  final LogoutUseCase logoutUseCase;
  final GetProfileUseCase getProfileUseCase;
  final GetSurveysUseCase getSurveysUseCase;

  HomeViewModel({
    required this.logoutUseCase,
    required this.getProfileUseCase,
    required this.getSurveysUseCase,
  }) : super(const HomeState.init());

  Future<void> fetchProfile() async {
    final result = await getProfileUseCase.call();
    if (result is Success<Profile>) {
      _profileImageUrlStream.add(result.value.avatarUrl);
    } else {
      _handleError(result as Failed);
    }
  }

  Future<void> fetchSurveys({bool isRefresh = false}) async {
    if (isRefresh) {
      _page = 1;
      _isEnded = false;
    }
    if (_isEnded) {
      return;
    }
    final result = await getSurveysUseCase.call(SurveysParams(
      pageNumber: _page,
      pageSize: 5,
    ));
    if (result is Success<SurveysResponse>) {
      _page++;
      _isEnded = _page > result.value.meta.pages;
      final newSurveys = result.value.data.map((e) => e.toSurvey()).toList();
      _handleSuccess(
        newSurveys: newSurveys,
        isRefresh: isRefresh,
      );
    } else {
      _handleError(result as Failed);
    }
  }

  void _handleSuccess({
    required List<Survey> newSurveys,
    required bool isRefresh,
  }) {
    if (isRefresh) {
      _focusedItemIndexStream.add(0);
      _surveys = newSurveys;
      _surveysStream.add(_surveys);
    } else {
      _focusedItemIndexStream.add(_focusedItemIndex);
      _surveys.addAll(newSurveys);
      _surveysStream.add(_surveys);
    }
  }

  void _handleError(Failed failure) {
    state = HomeState.error(failure.errorMessage);
  }

  void changeFocusedItem({required int index}) {
    _focusedItemIndex = index;
    _focusedItemIndexStream.add(index);
  }

  Future<void> logOut() async {
    await logoutUseCase.call();
  }
}
