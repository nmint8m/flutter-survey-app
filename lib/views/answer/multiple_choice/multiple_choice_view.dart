import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/views/answer/multiple_choice/multiple_choice_option_ui_model.dart';
import 'package:kayla_flutter_ic/views/answer/multiple_choice/multiple_choice_state.dart';
import 'package:kayla_flutter_ic/views/answer/multiple_choice/multiple_choice_view_model.dart';

final multipleChoiceViewModelProvider = StateNotifierProvider.autoDispose<
    MultipleChoiceViewModel, MultipleChoiceState>(
  (_) => MultipleChoiceViewModel(),
);

class MultipleChoiceView extends ConsumerStatefulWidget {
  const MultipleChoiceView({super.key});

  @override
  MultipleChoiceViewState createState() => MultipleChoiceViewState();
}

class MultipleChoiceViewState extends ConsumerState<MultipleChoiceView> {
  Widget get _listView => Consumer(builder: (context, ref, child) {
        // TODO: - Integration task
        const count = 10;
        final selectedIndexes = ref.watch(selectedIndexesStream).value ?? [];
        return ListView.separated(
          itemCount: count,
          itemBuilder: ((context, index) {
            final uiModels = MultipleChoiceOptionUIModel(
              id: '',
              title: 'Somewhat fulfilled',
              isSelected: selectedIndexes.contains(index),
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
            return _separator;
          },
        );
      });

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
    ref
        .read(multipleChoiceViewModelProvider.notifier)
        .selectOption(index: index);
  }
}
