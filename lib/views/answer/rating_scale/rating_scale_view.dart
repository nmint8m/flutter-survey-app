import 'package:flutter/material.dart';

class RatingScaleView extends StatefulWidget {
  final Function(int) onSelect;

  const RatingScaleView({
    super.key,
    required this.onSelect,
  });

  @override
  State<RatingScaleView> createState() => _RatingScaleViewState();
}

class _RatingScaleViewState extends State<RatingScaleView> {
  int? selectedIndex;

  List<Widget> get _ratingButtons {
    List<Widget> widgets = [];

    for (var index = 1; index <= 10; index++) {
      widgets.add(
        GestureDetector(
          child: Row(
            children: [
              SizedBox(
                width: 34,
                child: Center(
                  child: Text(
                    '$index',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: _textColor(
                            selectedIndex: selectedIndex,
                            index: index,
                          ),
                        ),
                  ),
                ),
              ),
              index <= 9
                  ? const VerticalDivider(
                      color: Colors.white,
                      width: 1,
                      thickness: 1,
                    )
                  : const SizedBox.shrink()
            ],
          ),
          onTap: () => _onSelect(index),
        ),
      );
    }
    return widgets;
  }

  Color _textColor({
    required int? selectedIndex,
    required int index,
  }) {
    if (selectedIndex == null) {
      return Colors.white30;
    } else {
      return selectedIndex >= index ? Colors.white : Colors.white30;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 351,
        height: 57,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _ratingButtons,
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
