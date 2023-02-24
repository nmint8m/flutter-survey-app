import 'package:flutter/material.dart';

extension AppBarExt on AppBar {
  static final AppBar appBarWithBackButton = AppBar(
    leading: const BackButton(),
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
  );
}
