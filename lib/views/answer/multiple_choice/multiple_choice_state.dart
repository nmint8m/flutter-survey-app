import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kayla_flutter_ic/views/answer/multiple_choice/multiple_choice_option_ui_model.dart';

part 'multiple_choice_state.freezed.dart';

@freezed
class MultipleChoiceState with _$MultipleChoiceState {
  const factory MultipleChoiceState.init() = _Init;

  const factory MultipleChoiceState.select({
    required List<MultipleChoiceOptionUIModel> uiModels,
    required List<int> selectedIndexes,
  }) = _Select;
}
