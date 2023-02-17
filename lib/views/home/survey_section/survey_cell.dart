import 'package:flutter/material.dart';
import 'package:kayla_flutter_ic/model/survey.dart';

class SurveyCell extends StatelessWidget {
  final Survey _survey;

  const SurveyCell(this._survey, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 90,
        bottom: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _survey.title,
            style: Theme.of(context).textTheme.displayMedium,
            maxLines: 2,
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            _survey.description,
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
