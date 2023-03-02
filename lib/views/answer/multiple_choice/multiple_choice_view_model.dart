import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/views/answer/multiple_choice/multiple_choice_option_ui_model.dart';
import 'package:kayla_flutter_ic/views/answer/multiple_choice/multiple_choice_state.dart';

class MultipleChoiceViewModel extends StateNotifier<MultipleChoiceState> {
  List<MultipleChoiceOptionUIModel> _uiModels = [];
  List<int> _selectedIndexes = [];

  MultipleChoiceViewModel() : super(const MultipleChoiceState.init());

  void setUpData(List<MultipleChoiceOptionUIModel> uiModels) {
    _uiModels = uiModels;
    _selectedIndexes = [];
    state = MultipleChoiceState.select(
      uiModels: _uiModels,
      selectedIndexes: _selectedIndexes,
    );
  }

  void selectOption({required int index}) {
    if (_selectedIndexes.contains(index)) {
      _selectedIndexes.removeWhere(((element) => element == index));
    } else {
      _selectedIndexes.add(index);
    }
    state = MultipleChoiceState.select(
      uiModels: _uiModels,
      selectedIndexes: _selectedIndexes,
    );
  }
}
