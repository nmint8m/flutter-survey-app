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

  SingleChoiceViewModel() : super(const SingleChoiceState.init());

  void selectOption({required int index}) {
    _selectedIndexStream.add(index);
  }
}
