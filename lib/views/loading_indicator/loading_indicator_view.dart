import 'package:flutter/material.dart';
import 'package:kayla_flutter_ic/views/loading_indicator/loading_indicator.dart';

class LoadingIndicatorView extends StatelessWidget {
  const LoadingIndicatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(20),
      child: SizedBox(
        height: 120,
        child: Column(
          children: const [
            SizedBox(height: 20),
            LoadingIndicator(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
