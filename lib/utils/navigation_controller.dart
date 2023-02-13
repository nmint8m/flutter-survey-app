import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:kayla_flutter_ic/di/di.dart';

final navigationController = getIt.get<NavigationController>();

@singleton
class NavigationController {
  void push(BuildContext context, Widget widget) {
    Route route =
        MaterialPageRoute(builder: (context) => ProviderScope(child: widget));
    Navigator.push(context, route);
  }

  void pop(BuildContext context) {
    Navigator.pop(context);
  }
}
