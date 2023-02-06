import 'package:flutter/material.dart';

class Keyboard {
  static void hideKeyboard(BuildContext context) {
    var currentFocusScope = FocusScope.of(context);
    if (!currentFocusScope.hasPrimaryFocus &&
        currentFocusScope.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
