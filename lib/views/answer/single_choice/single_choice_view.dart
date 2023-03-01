import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/views/answer/single_choice/single_choice_option_ui_model.dart';
import 'package:kayla_flutter_ic/views/answer/single_choice/single_choice_state.dart';
import 'package:kayla_flutter_ic/views/answer/single_choice/single_choice_view_model.dart';

final singleChoiceViewModelProvider =
    StateNotifierProvider.autoDispose<SingleChoiceViewModel, SingleChoiceState>(
  (_) => SingleChoiceViewModel(),
);

class SingleChoiceView extends ConsumerStatefulWidget {
  const SingleChoiceView({super.key});

  @override
  SingleChoiceViewState createState() => SingleChoiceViewState();
}

class SingleChoiceViewState extends ConsumerState<SingleChoiceView> {
  Widget get _listView => Consumer(builder: (context, ref, child) {
        // TODO: - Integration task
        const count = 10;
        final selectedIndex = ref.watch(selectedIndexStream).value ?? 0;
        return ListView.separated(
          itemCount: count,
          itemBuilder: ((context, index) {
            final uiModels = SingleChoiceOptionUIModel(
              id: '',
              title: 'Somewhat fulfilled',
              isSelected: index == selectedIndex,
            );
            return GestureDetector(
              onTap: () => _onTap(index),
              child: _listItem(uiModels),
            );
          }),
          separatorBuilder: (_, index) {
            if (index == count - 1) {
              return Container();
            }
            if (index == selectedIndex - 1 || index == selectedIndex) {
              return _highlightSeparator;
            }
            return _separator;
          },
        );
      });

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
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: _listView,
      ),
    );
  }

  void _onTap(int index) {
    ref.read(singleChoiceViewModelProvider.notifier).selectOption(index: index);
  }
}
