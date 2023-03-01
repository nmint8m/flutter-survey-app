import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/views/answer/single_choice/single_choice_state.dart';
import 'package:kayla_flutter_ic/views/answer/single_choice/single_choice_view.dart';

final selectedIndexStream = StreamProvider.autoDispose<int>((ref) {
  return ref
      .watch(singleChoiceViewModelProvider.notifier)
      ._selectedIndexStream
      .stream;
});

class SingleChoiceViewModel extends StateNotifier<SingleChoiceState> {
  final StreamController<int> _selectedIndexStream = StreamController();

  // TODO: - Change to init state
  SingleChoiceViewModel() : super(const SingleChoiceState.select(4));

  void selectOption({required int index}) {
    _selectedIndexStream.add(index);
  }
}
