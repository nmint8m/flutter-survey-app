import 'package:flutter/material.dart';
import 'package:kayla_flutter_ic/model/survey.dart';
import 'package:kayla_flutter_ic/views/home/survey_section/survey_cell.dart';

class SurveyList extends StatelessWidget {
  final List<Survey> surveyList;
  final PageController itemController;
  final ValueNotifier<int> onItemChange;

  const SurveyList({
    super.key,
    required this.surveyList,
    required this.itemController,
    required this.onItemChange,
  });

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      controller: itemController,
      onPageChanged: (index) => onItemChange.value = index,
      itemCount: surveyList.length,
      itemBuilder: (context, index) => SurveyCell(surveyList[index]),
    );
  }
}
