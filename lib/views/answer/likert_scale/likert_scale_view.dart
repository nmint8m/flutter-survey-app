import 'package:flutter/material.dart';
import 'package:kayla_flutter_ic/model/enum/likert_type.dart';

class LikertScaleView extends StatefulWidget {
  final LikertType uiModel;
  final Function(int) onSelect;

  const LikertScaleView({
    super.key,
    required this.uiModel,
    required this.onSelect,
  });

  @override
  State<LikertScaleView> createState() => _LikertScaleViewState();
}

class _LikertScaleViewState extends State<LikertScaleView> {
  int? selectedIndex;

  List<Widget> get _likertButtons {
    List<Widget> widgets = [];
    widget.uiModel.icons.asMap().forEach((index, icon) {
      widgets.add(
        GestureDetector(
          child: Container(
            margin: const EdgeInsets.all(8),
            child: SizedBox(
              width: 34,
              height: 34,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  icon,
                  style: TextStyle(
                    color: _textColor(
                      selectedIndex: selectedIndex,
                      index: index,
                    ),
                  ),
                ),
              ),
            ),
          ),
          onTap: () => _onSelect(index),
        ),
      );
    });
    return widgets;
  }

  Color _textColor({
    required int? selectedIndex,
    required int index,
  }) {
    if (selectedIndex == null) {
      return Colors.white30;
    } else if (widget.uiModel.isSinglyHighlight) {
      return selectedIndex == index ? Colors.white : Colors.white30;
    } else {
      return selectedIndex >= index ? Colors.white : Colors.white30;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _likertButtons,
        ),
      ),
    );
  }

  void _onSelect(int index) {
    setState(() {
      selectedIndex = index;
    });
    widget.onSelect(index);
  }
}
