import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kayla_flutter_ic/views/answer/single_choice/single_choice_option_ui_model.dart';

part 'single_choice_state.freezed.dart';

@freezed
class SingleChoiceState with _$SingleChoiceState {
  const factory SingleChoiceState.init() = _Init;

  const factory SingleChoiceState.select({
    required List<SingleChoiceOptionUIModel> uiModels,
    required int? selectedIndex,
  }) = _Select;
}
