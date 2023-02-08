import 'package:flutter/material.dart';
import 'package:kayla_flutter_ic/views/loading_indicator/loading_indicator.dart';

void showOrHideLoadingIndicator({
  required BuildContext context,
  required bool shouldShow,
}) {
  if (shouldShow) {
    Navigator.of(context, rootNavigator: true).pop();
  } else {
    showDialog(
      context: context,
      builder: (_) => const LoadingIndicator(),
    );
  }
}
