import 'package:flutter/material.dart';
import 'package:kayla_flutter_ic/views/common/loading_indicator/loading_indicator_dialog.dart';

extension BuildContextExtension on BuildContext {
  void showOrHideLoadingIndicator({
    required bool shouldShow,
  }) {
    if (shouldShow) {
      showDialog(
        context: this,
        barrierColor: Colors.black.withOpacity(0.2),
        barrierDismissible: false,
        builder: (_) => const LoadingIndicatorDialog(),
      );
    } else {
      Navigator.of(this, rootNavigator: true).pop();
    }
  }
}
