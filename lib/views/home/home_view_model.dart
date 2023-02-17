import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/api/response/surveys_response.dart';
import 'package:kayla_flutter_ic/model/profile.dart';
import 'package:kayla_flutter_ic/model/survey.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/usecases/survey/get_surveys_params.dart';
import 'package:kayla_flutter_ic/usecases/survey/get_surveys_use_case.dart';
import 'package:kayla_flutter_ic/usecases/user/get_profile_use_case.dart';
import 'package:kayla_flutter_ic/views/home/home_state.dart';
import 'package:kayla_flutter_ic/views/home/home_view.dart';

final profileImageUrlStream = StreamProvider.autoDispose<String>((ref) =>
    ref.watch(homeViewModelProvider.notifier)._profileImageUrlStream.stream);

final surveysStream = StreamProvider.autoDispose<List<Survey>>((ref) =>
    ref.watch(homeViewModelProvider.notifier)._surveysStream.stream);

class HomeViewModel extends StateNotifier<HomeState> {
  final StreamController<String> _profileImageUrlStream = StreamController();
  final StreamController<List<Survey>> _surveysStream = StreamController();

  final GetProfileUseCase _getProfileUseCase;
  final GetSurveysUseCase _getSurveysUseCase;

  HomeViewModel(
    this._getProfileUseCase,
    this._getSurveysUseCase,
  ) : super(const HomeState.init());

  Future<void> fetchProfile() async {
    final result = await _getProfileUseCase.call();
    if (result is Success<Profile>) {
      _profileImageUrlStream.add(result.value.avatarUrl);
    } else {
      _handleError(result as Failed);
    }
  }

  Future<void> fetchSurveys() async {
    final result = await _getSurveysUseCase.call(SurveysParams(
      pageNumber: 1,
      pageSize: 5,
    ));
    if (result is Success<SurveysResponse>) {
      // TODO: - Stream the survey list instead
      _surveysStream.add(result.value.data.map((e) => e.title).toList());
    } else {
      _handleError(result as Failed);
    }
  }

  void _handleError(Failed failure) {
    state = HomeState.error(failure.errorMessage);
  }
}
