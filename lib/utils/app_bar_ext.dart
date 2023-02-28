// ignore_for_file: avoid_init_to_null
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension AppBarExt on AppBar {
  static AppBar appBarWithBackButton({
    required BuildContext context,
    void Function()? onPressed = null,
  }) =>
      AppBar(
        leading: BackButton(onPressed: () {
          if (onPressed != null) {
            onPressed();
          } else if (context.canPop()) {
            context.pop();
          }
        }),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      );
}
