import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/utils/app_bar_ext.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Container(),
    );
  }
}
