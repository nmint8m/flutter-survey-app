import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/di/di.dart';
import 'package:kayla_flutter_ic/gen/assets.gen.dart';
import 'package:kayla_flutter_ic/usecases/survey/get_surveys_use_case.dart';
import 'package:kayla_flutter_ic/usecases/user/get_profile_use_case.dart';
import 'package:kayla_flutter_ic/utils/build_context_ext.dart';
import 'package:kayla_flutter_ic/views/home/home_header.dart';
import 'package:kayla_flutter_ic/views/home/home_state.dart';
import 'package:kayla_flutter_ic/views/home/home_view_model.dart';
import 'package:kayla_flutter_ic/views/home/skeleton_loading/home_skeleton_loading.dart';

final homeViewModelProvider =
    StateNotifierProvider.autoDispose<HomeViewModel, HomeState>(
  (_) => HomeViewModel(
    getIt.get<GetProfileUseCase>(),
    getIt.get<GetSurveysUseCase>(),
  ),
);

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  // TODO: - Network image
  Image get _backgroundImage => Image(
        image: Assets.images.nimbleBackground.image().image,
        fit: BoxFit.cover,
        alignment: Alignment.center,
      );

  Widget get _homeHeader => Consumer(
        builder: (_, ref, __) {
          return HomeHeader(
              profileImageUrl: ref.watch(profileImageUrlStream).value ?? '');
        },
      );

  Widget get _body => Consumer(
        builder: (_, ref, __) {
          final surveys = ref.watch(surveysStream).value ?? [];
          return surveys.isNotEmpty
              ? SafeArea(child: _homeHeader)
              : const SafeArea(child: HomeSkeletonLoading());
        },
      );

  @override
  void initState() {
    super.initState();
    _fetchProfile();
    _fetchSurvey();
  }

  @override
  Widget build(BuildContext context) {
    _setupStateListener();
    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: _backgroundImage.image,
              fit: BoxFit.cover,
            ),
          ),
          child: _body,
        ),
      ),
      onWillPop: () async => false,
    );
  }

  void _setupStateListener() {
    ref.listen<HomeState>(homeViewModelProvider, (_, state) {
      context.showOrHideLoadingIndicator(
        shouldShow: state == const HomeState.loading(),
      );
      state.maybeWhen(
        error: (error) {
          context.showSnackBar(message: 'Unexpected. $error.');
        },
        orElse: () {},
      );
    });
  }

  void _fetchProfile() {
    ref.read(homeViewModelProvider.notifier).fetchProfile();
  }

  void _fetchSurvey() {
    ref.read(homeViewModelProvider.notifier).fetchSurveys();
  }
}
