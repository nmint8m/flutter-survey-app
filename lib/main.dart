import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/gen/assets.gen.dart';
import 'package:go_router/go_router.dart';
import 'package:kayla_flutter_ic/utils/app_router.dart';
import 'package:kayla_flutter_ic/utils/themes.dart';
import 'package:kayla_flutter_ic/di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await configureDependencies();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late GoRouter _router;

  @override
  Widget build(BuildContext context) {
    _router = getIt.get<AppRouter>().router(null);
    return MaterialApp.router(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
        fontFamily: Assets.fonts.neuzeit,
        appBarTheme: Themes.appBarTheme,
        textTheme: Themes.textTheme,
        buttonTheme: Themes.buttonTheme,
        elevatedButtonTheme: Themes.elevatedButtonThemeData,
        textButtonTheme: Themes.textButtonThemeData,
        inputDecorationTheme: Themes.inputDecorationTheme,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }
}
