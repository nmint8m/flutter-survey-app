import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/views/answer/multiple_choice/multiple_choice_state.dart';
import 'package:kayla_flutter_ic/views/answer/multiple_choice/multiple_choice_view.dart';

final selectedIndexesStream = StreamProvider.autoDispose<List<int>>((ref) {
  return ref
      .watch(multipleChoiceViewModelProvider.notifier)
      ._selectedIndexesStream
      .stream;
});

class MultipleChoiceViewModel extends StateNotifier<MultipleChoiceState> {
  final StreamController<List<int>> _selectedIndexesStream = StreamController();
  final List<int> _selectedIndexes = [];

  MultipleChoiceViewModel() : super(const MultipleChoiceState.init());

  void selectOption({required int index}) {
    if (_selectedIndexes.contains(index)) {
      _selectedIndexes.removeWhere(((element) => element == index));
    } else {
      _selectedIndexes.add(index);
    }
    _selectedIndexesStream.add(_selectedIndexes);
  }
}
