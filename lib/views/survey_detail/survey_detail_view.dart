import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/gen/assets.gen.dart';
import 'package:kayla_flutter_ic/utils/app_bar_ext.dart';
import 'package:kayla_flutter_ic/views/survey_detail/skeleton_loading/survey_detail_skeleton_loading.dart';

class SurveyDetailView extends ConsumerStatefulWidget {
  final String surveyId;

  const SurveyDetailView({
    required this.surveyId,
    super.key,
  });

  @override
  SurveyDetailViewState createState() => SurveyDetailViewState();
}

class SurveyDetailViewState extends ConsumerState<SurveyDetailView>
    with TickerProviderStateMixin {
  AppBar get _appBar => AppBarExt.appBarWithBackButton(context: context);

  Widget get _background => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Consumer(builder: (_, ref, __) {
          // TODO: - Network image stream
          return Image(image: Assets.images.nimbleBackground.image().image);
        }),
      );

  Widget get _mainBody => Consumer(
        builder: (_, ref, __) {
          return Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // TODO: - Remove hard code
                  "Bonchon Chicken",
                  style: Theme.of(context).textTheme.displayMedium,
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  // TODO: - Remove hard code
                  "Do you wanna take a bite? Mlem.",
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(140, 56)),
                      onPressed: () {},
                      child: const Text('Start survey'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );

  Widget get _body => Consumer(
        builder: (_, ref, __) {
          // TODO: - Remove hard code for loading
          return Stack(
            children: [
              _mainBody,
              const SurveyDetailSkeletonLoading(),
            ],
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _background,
        Container(color: Colors.black38),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _appBar,
          body: SafeArea(child: _body),
        )
      ],
    );
  }
}
