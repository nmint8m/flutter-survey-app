import 'package:flutter/material.dart';
import 'package:kayla_flutter_ic/views/loading_indicator/loading_indicator_view.dart';

void showOrHideLoadingIndicator({
  required BuildContext context,
  required bool shouldShow,
}) {
  if (shouldShow) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.2),
      barrierDismissible: false,
      builder: (_) => const LoadingIndicatorView(),
    );
  } else {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
