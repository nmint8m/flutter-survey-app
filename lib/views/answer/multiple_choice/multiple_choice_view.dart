import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/utils/durations.dart';
import 'package:kayla_flutter_ic/views/answer/multiple_choice/multiple_choice_option_ui_model.dart';
import 'package:kayla_flutter_ic/views/answer/multiple_choice/multiple_choice_state.dart';
import 'package:kayla_flutter_ic/views/answer/multiple_choice/multiple_choice_view_model.dart';

final multipleChoiceViewModelProvider = StateNotifierProvider.autoDispose<
    MultipleChoiceViewModel, MultipleChoiceState>(
  (_) => MultipleChoiceViewModel(),
);

class MultipleChoiceView extends ConsumerStatefulWidget {
  final List<MultipleChoiceOptionUIModel> uiModels;

  const MultipleChoiceView({
    super.key,
    required this.uiModels,
  });

  @override
  MultipleChoiceViewState createState() => MultipleChoiceViewState();
}

class MultipleChoiceViewState extends ConsumerState<MultipleChoiceView> {
  Widget get _listView => Consumer(
        builder: (_, ref, __) {
          final state = ref.watch(multipleChoiceViewModelProvider);
          return state.maybeWhen(
            orElse: () => Container(),
            select: (uiModels, selectedIndexes) => ListView.separated(
              itemCount: uiModels.length,
              itemBuilder: (_, index) => _itemBuilder(
                uiModels: uiModels,
                index: index,
                selectedIndexes: selectedIndexes,
              ),
              separatorBuilder: (_, index) => _separatorBuilder(
                count: uiModels.length,
                index: index,
              ),
            ),
          );
        },
      );

  Widget _itemBuilder({
    required List<MultipleChoiceOptionUIModel> uiModels,
    required int index,
    required List<int> selectedIndexes,
  }) {
    final uiModel = MultipleChoiceOptionUIModel(
      id: uiModels[index].id,
      title: uiModels[index].title,
      isSelected: selectedIndexes.contains(index),
    );
    return GestureDetector(
      onTap: () => _onTap(index),
      child: _listItem(uiModel),
    );
  }

  Widget _listItem(MultipleChoiceOptionUIModel uiModel) => SizedBox(
        width: MediaQuery.of(context).size.width - 160,
        height: 56,
        child: Row(
          children: [
            Expanded(
              child: Text(
                style: uiModel.isSelected
                    ? Theme.of(context)
                        .textTheme
                        .displaySmall
                        ?.copyWith(color: Colors.white)
                    : Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(color: Colors.white70),
                maxLines: 1,
                uiModel.title,
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: Colors.white),
              ),
              child: uiModel.isSelected
                  ? Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: const FittedBox(
                        child: Icon(
                          Icons.check,
                          size: 25,
                          color: Colors.black,
                        ),
                      ),
                    )
                  : Container(),
            ),
          ],
        ),
      );

  Widget _separatorBuilder({
    required int count,
    required int index,
  }) {
    if (index == count - 1) {
      return Container();
    }
    return _separator;
  }

  Widget get _separator => const Divider(
        color: Colors.white70,
        height: 0.5,
        thickness: 0.5,
        indent: 80,
        endIndent: 80,
      );

  @override
  void initState() {
    super.initState();
    _setUpData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: _listView,
      ),
    );
  }

  void _setUpData() {
    Future.delayed(Durations.fiftyMillisecond, () {
      ref
          .read(multipleChoiceViewModelProvider.notifier)
          .setUpData(widget.uiModels);
    });
  }

  void _onTap(int index) {
    ref
        .read(multipleChoiceViewModelProvider.notifier)
        .selectOption(index: index);
  }
}
