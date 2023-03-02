import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/utils/durations.dart';
import 'package:kayla_flutter_ic/views/answer/single_choice/single_choice_option_ui_model.dart';
import 'package:kayla_flutter_ic/views/answer/single_choice/single_choice_state.dart';
import 'package:kayla_flutter_ic/views/answer/single_choice/single_choice_view_model.dart';

final singleChoiceViewModelProvider =
    StateNotifierProvider.autoDispose<SingleChoiceViewModel, SingleChoiceState>(
  (_) => SingleChoiceViewModel(),
);

class SingleChoiceView extends ConsumerStatefulWidget {
  final List<SingleChoiceOptionUIModel> uiModels;

  const SingleChoiceView({
    super.key,
    required this.uiModels,
  });

  @override
  SingleChoiceViewState createState() => SingleChoiceViewState();
}

class SingleChoiceViewState extends ConsumerState<SingleChoiceView> {
  Widget get _listView => Consumer(builder: (context, ref, child) {
        final state = ref.watch(singleChoiceViewModelProvider);
        return state.maybeWhen(
          orElse: () => Container(),
          select: (uiModels, selectedIndex) => ListView.separated(
            itemCount: uiModels.length,
            itemBuilder: (_, index) => _itemBuilder(
              uiModels: uiModels,
              index: index,
              selectedIndex: selectedIndex,
            ),
            separatorBuilder: (_, index) => _separatorBuilder(
              count: uiModels.length,
              index: index,
              selectedIndex: selectedIndex,
            ),
          ),
        );
      });

  Widget _itemBuilder({
    required List<SingleChoiceOptionUIModel> uiModels,
    required int index,
    required int? selectedIndex,
  }) {
    final uiModel = SingleChoiceOptionUIModel(
      id: uiModels[index].id,
      title: uiModels[index].title,
      isSelected: selectedIndex == null ? false : index == selectedIndex,
    );
    return GestureDetector(
      onTap: () => _onTap(index),
      child: _listItem(uiModel),
    );
  }

  Widget _listItem(SingleChoiceOptionUIModel uiModel) => SizedBox(
        height: 56,
        child: Center(
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
        )),
      );

  Widget _separatorBuilder({
    required int count,
    required int index,
    required int? selectedIndex,
  }) {
    if (selectedIndex == null) {
      return _separator;
    }
    if (index == count - 1) {
      return Container();
    }
    if (index == selectedIndex - 1 || index == selectedIndex) {
      return _highlightSeparator;
    }
    return _separator;
  }

  Widget get _highlightSeparator => const Divider(
        color: Colors.white,
        height: 1,
        thickness: 1,
        indent: 80,
        endIndent: 80,
      );

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
    Future.delayed(
      Durations.fiftyMillisecond,
      () {
        ref
            .read(singleChoiceViewModelProvider.notifier)
            .setUpData(widget.uiModels);
      },
    );
  }

  void _onTap(int index) {
    ref.read(singleChoiceViewModelProvider.notifier).selectOption(index: index);
  }
}
