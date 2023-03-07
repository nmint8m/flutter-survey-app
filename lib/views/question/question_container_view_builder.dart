import 'package:flutter/material.dart';
import 'package:kayla_flutter_ic/model/enum/display_type.dart';
import 'package:kayla_flutter_ic/model/enum/likert_type.dart';
import 'package:kayla_flutter_ic/views/answer/form/form_with_text_area_view.dart';
import 'package:kayla_flutter_ic/views/answer/form/form_with_text_field_view.dart';
import 'package:kayla_flutter_ic/views/answer/likert_scale/likert_scale_view.dart';
import 'package:kayla_flutter_ic/views/answer/multiple_choice/multiple_choice_option_ui_model.dart';
import 'package:kayla_flutter_ic/views/answer/multiple_choice/multiple_choice_view.dart';
import 'package:kayla_flutter_ic/views/answer/rating_scale/rating_scale_view.dart';
import 'package:kayla_flutter_ic/views/answer/single_choice/single_choice_option_ui_model.dart';
import 'package:kayla_flutter_ic/views/answer/single_choice/single_choice_view.dart';
import 'package:kayla_flutter_ic/views/question/answers_container_ui_model.dart';
import 'package:kayla_flutter_ic/views/question/question_container_view.dart';

extension QuestionContainerViewStateExt on QuestionContainerViewState {
  Widget buildAnswer(AnswerContainerUIModel uiModel) {
    switch (uiModel.displayType) {
      case DisplayType.dropdown:
        return _buildSingleChoice(uiModel.options);
      case DisplayType.choice:
        return _buildMultipleChoice(uiModel.options);
      case DisplayType.star:
        return _buildLikertScale(
          type: LikertType.star,
          options: uiModel.options,
        );
      case DisplayType.heart:
        return _buildLikertScale(
          type: LikertType.heart,
          options: uiModel.options,
        );
      case DisplayType.smiley:
        return _buildLikertScale(
          type: LikertType.smiley,
          options: uiModel.options,
        );
      case DisplayType.nps:
        return _buildRatingScale(uiModel.options);
      case DisplayType.textfield:
        return _buildFormWithTextField(uiModel.options);
      case DisplayType.textarea:
        return _buildFormWithTextArea(uiModel.options.first);
      case DisplayType.outro:
        return _buildOutro();
      case DisplayType.slider:
        return _buildSlider();
      default:
        return Container();
    }
  }

  Widget _buildSingleChoice(List<OptionUiModel> options) {
    var sortedOptions = _sortByIndex(options);
    var uiModels = sortedOptions
        .map(
          (option) => SingleChoiceOptionUIModel(
            id: option.id,
            title: option.title,
            isSelected: false,
          ),
        )
        .toList();
    return SingleChoiceView(
      uiModels: uiModels,
      onSelect: (index) => _storeOptionAnswers([index]),
    );
  }

  Widget _buildMultipleChoice(List<OptionUiModel> options) {
    var sortedOptions = _sortByIndex(options);
    var uiModels = sortedOptions
        .map(
          (option) => MultipleChoiceOptionUIModel(
            id: option.id,
            title: option.title,
            isSelected: false,
          ),
        )
        .toList();
    return MultipleChoiceView(
      uiModels: uiModels,
      onSelect: (indexes) => _storeOptionAnswers(indexes),
    );
  }

  Widget _buildLikertScale({
    required LikertType type,
    required List<OptionUiModel> options,
  }) {
    var sortedOptions = _sortByIndex(options);
    return LikertScaleView(
      type: type,
      onSelect: (index) => _storeOptionAnswers([sortedOptions[index].id]),
    );
  }

  Widget _buildRatingScale(List<OptionUiModel> options) {
    var sortedOptions = _sortByIndex(options);
    return RatingScaleView(
      onSelect: (index) => _storeOptionAnswers([sortedOptions[index].id]),
    );
  }

  Widget _buildFormWithTextField(List<OptionUiModel> options) {
    return FormWithTextFieldView(
      uiModels: options,
      onChange: _storeInputAnswers,
    );
  }

  Widget _buildFormWithTextArea(OptionUiModel uiModel) {
    return FormWithTextAreaView(
      uiModel: uiModel,
      onChange: _storeInputAnswers,
    );
  }

  Widget _buildOutro() {
    return const SizedBox.shrink();
  }

  Widget _buildSlider() {
    // TODO: - No design for slider yet
    return const SizedBox.shrink();
  }

  void _storeOptionAnswers(List<String> indexes) {
    // TODO: - Submit answer
    // ignore: avoid_print
    print(indexes);
  }

  void _storeInputAnswers(Map<String, String> answer) {
    // TODO: - Submit answer
    // ignore: avoid_print
    print(answer);
  }

  List<OptionUiModel> _sortByIndex(List<OptionUiModel> options) {
    var sortedOptions = options;
    sortedOptions.sort((a, b) => (a.index.compareTo(b.index)));
    return sortedOptions;
  }
}
