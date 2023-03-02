import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/views/answer/single_choice/single_choice_option_ui_model.dart';
import 'package:kayla_flutter_ic/views/answer/single_choice/single_choice_state.dart';

class SingleChoiceViewModel extends StateNotifier<SingleChoiceState> {
  List<SingleChoiceOptionUIModel> _uiModels = [];
  SingleChoiceViewModel() : super(const SingleChoiceState.init());

  void setUpData(List<SingleChoiceOptionUIModel> uiModels) {
    _uiModels = uiModels;
    state = SingleChoiceState.select(
      uiModels: _uiModels,
      selectedIndex: null,
    );
  }

  void selectOption({required int index}) {
    state = SingleChoiceState.select(
      uiModels: _uiModels,
      selectedIndex: index,
    );
  }
}
