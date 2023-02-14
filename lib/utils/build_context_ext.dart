import 'package:flutter/material.dart';
import 'package:kayla_flutter_ic/views/common/loading_indicator/loading_indicator_dialog.dart';
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

  void showTopSnackBar(Widget child) {
    final currentOverlayState = Overlay.of(this);
    late OverlayEntry newOverlayState;
    newOverlayState =
        OverlayEntry(builder: (_) => AnimatedTopSnackBar(child: child));
    // ignore: unchecked_use_of_nullable_value
    currentOverlayState.insert(newOverlayState, below: null, above: null);
    if (_previousEntry != null && _previousEntry!.mounted) {
      _previousEntry?.remove();
    }
    _previousEntry = newOverlayState;
  }
}
