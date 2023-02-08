import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 80,
      height: 80,
      child: CircularProgressIndicator(
        strokeWidth: 5,
      ),
    );
  }
}
