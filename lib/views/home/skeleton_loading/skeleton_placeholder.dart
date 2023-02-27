import 'package:flutter/material.dart';

enum TextPlaceholderType {
  oneLine,
  twoLines,
}

class TextPlaceholder extends StatelessWidget {
  final TextPlaceholderType type;
  final double width;

  const TextPlaceholder({
    Key? key,
    required this.type,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: _buildLines(),
    );
  }

  Widget _buildLines() {
    List<Widget> widgets = [
      Container(
        width: width,
        height: 12.0,
        color: Colors.white,
      )
    ];
    switch (type) {
      case TextPlaceholderType.oneLine:
      case TextPlaceholderType.twoLines:
        widgets.addAll([
          const SizedBox(height: 8.0),
          Container(
            width: width * 0.6,
            height: 12.0,
            color: Colors.white,
          ),
        ]);
        break;
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }
}
