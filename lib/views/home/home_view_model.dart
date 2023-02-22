import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/model/profile.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/usecases/user/get_profile_use_case.dart';
import 'package:kayla_flutter_ic/views/home/home_state.dart';
import 'package:kayla_flutter_ic/views/home/home_view.dart';

final profileImageUrlStream = StreamProvider.autoDispose<String>((ref) =>
    ref.watch(homeViewModelProvider.notifier).profileImageUrlStream.stream);

class HomeViewModel extends StateNotifier<HomeState> {
  final StreamController<String> profileImageUrlStream = StreamController();

  final ProfileUseCase _profileUseCase;

  HomeViewModel(this._profileUseCase) : super(const HomeState.init());

  Future<void> fetchProfile() async {
    final result = await _profileUseCase.call();
    if (result is Success<Profile>) {
      profileImageUrlStream.add(result.value.avatarUrl);
    } else {
      _handleError(result as Failed);
    }
  }

  void _handleError(Failed failure) {
    state = HomeState.error(failure.errorMessage);
  }
}
