import 'package:flutter/material.dart';
import 'package:kayla_flutter_ic/views/common/loading_indicator/loading_indicator.dart';

class LoadingIndicatorDialog extends StatelessWidget {
  const LoadingIndicatorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        color: Colors.transparent,
        alignment: FractionalOffset.center,
        height: 120,
        padding: const EdgeInsets.all(20),
        child: const SizedBox(
          width: 80,
          height: 80,
          child: LoadingIndicator(),
        ),
      ),
    );
  }
}
