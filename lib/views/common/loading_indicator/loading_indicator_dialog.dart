import 'package:flutter/material.dart';
import 'package:kayla_flutter_ic/views/common/loading_indicator/loading_indicator.dart';

class LoadingIndicatorDialog extends StatelessWidget {
  const LoadingIndicatorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: SizedBox(
        height: 120,
        child: Column(
          children: const [
            SizedBox(height: 20),
            SizedBox(
              width: 80,
              height: 80,
              child: LoadingIndicator(),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
