import 'package:flutter/material.dart';
import 'package:kayla_flutter_ic/model/survey.dart';
import 'package:kayla_flutter_ic/views/home/survey_section/survey_cell.dart';

enum RefreshStyle {
  swipeRightToRefresh,
  pullDownToRefresh,
}

// ignore: must_be_immutable
class SurveyList extends StatelessWidget {
  final RefreshStyle refreshStyle;
  final List<Survey> surveys;
  final PageController itemController;
  final ValueNotifier<int> onItemChange;
  final Future<void> Function() onRefresh;
  final Future<void> Function() onLoadMore;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool _isLoading = false;

  SurveyList({
    super.key,
    required this.refreshStyle,
    required this.surveys,
    required this.itemController,
    required this.onItemChange,
    required this.onRefresh,
    required this.onLoadMore,
  });

  @override
  Widget build(BuildContext context) {
    _isLoading = false;
    switch (refreshStyle) {
      case RefreshStyle.swipeRightToRefresh:
        return _buildSwipeRightToRefreshPageView(context);
      case RefreshStyle.pullDownToRefresh:
        return _buildPullDownToRefreshPageView(context);
    }
  }

  Widget _buildSwipeRightToRefreshPageView(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    itemController.addListener(() {
      if (itemController.offset < -10) {
        _refreshIndicatorKey.currentState?.show();
      }

      if (itemController.offset > screenWidth * (surveys.length - 1) + 10 &&
          !_isLoading) {
        _isLoading = true;
        onLoadMore();
      }
    });
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: onRefresh,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: itemController,
        onPageChanged: (index) => onItemChange.value = index,
        itemCount: surveys.length,
        itemBuilder: (context, index) => SurveyCell(surveys[index]),
      ),
    );
  }

  Widget _buildPullDownToRefreshPageView(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    itemController.addListener(() {
      if (itemController.offset > screenWidth * (surveys.length - 3) + 10 &&
          !_isLoading) {
        _isLoading = true;
        onLoadMore();
      }
    });
    return SafeArea(
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        edgeOffset: 100,
        onRefresh: onRefresh,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            width: screenWidth,
            height: MediaQuery.of(context).size.height - 100,
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: itemController,
              onPageChanged: (index) => onItemChange.value = index,
              itemCount: surveys.length,
              itemBuilder: (context, index) => SurveyCell(surveys[index]),
            ),
          ),
        ),
      ),
    );
  }
}
