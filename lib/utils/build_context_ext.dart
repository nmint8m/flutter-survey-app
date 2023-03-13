import 'package:flutter/material.dart';
import 'package:kayla_flutter_ic/views/common/loading_indicator/loading_indicator_dialog.dart';
import 'package:kayla_flutter_ic/views/common/lottie_indicator/lottie_dialog.dart';
import 'package:kayla_flutter_ic/views/common/top_snack_bar/animated_top_snack_bar.dart';

OverlayEntry? _previousEntry;

extension BuildContextExtension on BuildContext {
  void showSnackBar({required String message}) =>
      ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));

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

  void showLottie({
    required Function() onAnimated,
  }) {
    showDialog(
      context: this,
      barrierColor: Colors.black.withOpacity(0.2),
      barrierDismissible: false,
      builder: (_) => LottieDialog(
        onAnimated: () {
          Navigator.of(this, rootNavigator: true).pop();
          onAnimated();
        },
      ),
    );
  }

  void showTopSnackBar(Widget child) {
    final currentOverlayState = Overlay.of(this);
    late OverlayEntry newOverlayState;
    newOverlayState =
        OverlayEntry(builder: (_) => AnimatedTopSnackBar(child: child));
    currentOverlayState?.insert(newOverlayState, below: null, above: null);
    if (_previousEntry != null && _previousEntry!.mounted) {
      _previousEntry?.remove();
    }
    _previousEntry = newOverlayState;
  }
}
