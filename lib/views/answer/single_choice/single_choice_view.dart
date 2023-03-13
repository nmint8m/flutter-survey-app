import 'package:flutter/material.dart';
import 'package:kayla_flutter_ic/views/answer/single_choice/single_choice_option_ui_model.dart';

class SingleChoiceView extends StatefulWidget {
  final List<SingleChoiceOptionUIModel> uiModels;
  final Function(String) onSelect;

  const SingleChoiceView({
    super.key,
    required this.uiModels,
    required this.onSelect,
  });

  @override
  State<SingleChoiceView> createState() => _SingleChoiceViewState();
}

class _SingleChoiceViewState extends State<SingleChoiceView> {
  int? selectedIndex;

  Widget get _listView => ListView.separated(
        itemCount: widget.uiModels.length,
        itemBuilder: (_, index) => _itemBuilder(
          uiModels: widget.uiModels,
          index: index,
          selectedIndex: selectedIndex,
        ),
        separatorBuilder: (_, index) => _separatorBuilder(
          count: widget.uiModels.length,
          index: index,
          selectedIndex: selectedIndex,
        ),
      );

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
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: _listView,
      ),
    );
  }

  void _onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onSelect(widget.uiModels[index].id);
  }
}
