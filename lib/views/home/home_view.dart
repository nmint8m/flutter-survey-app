import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/di/di.dart';
import 'package:kayla_flutter_ic/gen/assets.gen.dart';
import 'package:kayla_flutter_ic/model/survey.dart';
import 'package:kayla_flutter_ic/usecases/survey/get_surveys_use_case.dart';
import 'package:kayla_flutter_ic/usecases/user/get_profile_use_case.dart';
import 'package:kayla_flutter_ic/utils/build_context_ext.dart';
import 'package:kayla_flutter_ic/utils/durations.dart';
import 'package:kayla_flutter_ic/views/home/home_header.dart';
import 'package:kayla_flutter_ic/views/home/home_state.dart';
import 'package:kayla_flutter_ic/views/home/home_view_model.dart';
import 'package:kayla_flutter_ic/views/home/skeleton_loading/home_skeleton_loading.dart';
import 'package:kayla_flutter_ic/views/home/survey_section/survey_list.dart';
import 'package:kayla_flutter_ic/views/home/survey_section/survey_page_indicator.dart';

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
  final _surveyItemController = PageController();
  final _surveyIndex = ValueNotifier<int>(0);

  Widget get _background => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Consumer(builder: (_, ref, __) {
          final index = ref.watch(focusedItemIndexStream).value ?? 0;
          final surveys = ref.read(surveysStream).value ?? [];
          return surveys.isEmpty || index >= surveys.length
              ? Image(image: Assets.images.nimbleBackground.image().image)
              : FadeInImage.assetNetwork(
                  placeholder: Assets.images.nimbleBackground.path,
                  image: surveys[index].coverImageUrl,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                );
        }),
      );

  Widget get _homeHeader => Consumer(
        builder: (_, ref, __) {
          return HomeHeader(
              profileImageUrl: ref.watch(profileImageUrlStream).value ?? '');
        },
      );

  Widget _surveyList(List<Survey> surveys) => SurveyList(
        refreshStyle: RefreshStyle.pullDownToRefresh,
        surveys: surveys,
        itemController: _surveyItemController,
        onItemChange: _surveyIndex,
        onRefresh: () => _fetchSurveys(isRefresh: true),
        onLoadMore: () => _fetchSurveys(isRefresh: false),
      );

  Widget _pageIndicatorSection(int length) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          SurveyPageIndicator(
            controller: _surveyItemController,
            count: length,
          ),
          const SizedBox(height: 160),
        ],
      );

  Widget get _mainBody => Consumer(
        builder: (_, ref, __) {
          final surveys = ref.watch(surveysStream).value ?? [];
          final index = ref.read(focusedItemIndexStream).value ?? 0;
          if (_surveyItemController.positions.isNotEmpty) {
            Future.delayed(
              Durations.fiftyMillisecond,
              () => _surveyItemController.jumpToPage(index),
            );
          }
          return Stack(
            children: [
              _homeHeader,
              _pageIndicatorSection(surveys.length),
              _surveyList(surveys),
            ],
          );
        },
      );

  Widget get takeSurveyButton => FloatingActionButton(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        child: const Icon(Icons.navigate_next),
        onPressed: () => _takeSurvey(),
      );

  Widget get _body => Consumer(
        builder: (_, ref, __) {
          final surveys = ref.watch(surveysStream).value ?? [];
          return surveys.isNotEmpty
              ? SafeArea(child: _mainBody)
              : const SafeArea(child: HomeSkeletonLoading());
        },
      );

  @override
  void initState() {
    super.initState();
    _fetchProfile();
    _fetchSurveys(isRefresh: false);
  }

  @override
  void dispose() {
    _surveyIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _setupStateListener();
    return WillPopScope(
      child: Scaffold(
        body: Stack(
          children: [
            _background,
            Container(color: Colors.black38),
            _body,
          ],
        ),
        floatingActionButton: takeSurveyButton,
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
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
    _surveyIndex.addListener(() {
      ref
          .read(homeViewModelProvider.notifier)
          .changeFocusedItem(index: _surveyIndex.value);
    });
  }

  void _fetchProfile() {
    ref.read(homeViewModelProvider.notifier).fetchProfile();
  }

  Future<void> _fetchSurveys({required bool isRefresh}) async {
    ref
        .read(homeViewModelProvider.notifier)
        .fetchSurveys(isRefresh: isRefresh);
  }

  void _takeSurvey() {
    // ignore: avoid_print
    print(_surveyIndex.value);
  }
}
