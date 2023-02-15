import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kayla_flutter_ic/gen/assets.gen.dart';
import 'package:go_router/go_router.dart';
import 'package:kayla_flutter_ic/utils/route_paths.dart';
import 'package:kayla_flutter_ic/utils/themes.dart';
import 'package:kayla_flutter_ic/views/forget_password/forget_password_view.dart';
import 'package:kayla_flutter_ic/di/di.dart';
import 'package:kayla_flutter_ic/views/home/home_view.dart';
import 'package:kayla_flutter_ic/views/login/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await configureDependencies();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  GoRouter get _router => GoRouter(
        routes: <GoRoute>[
          _loginGoRoute,
          _homeGoRoute,
        ],
      );

  GoRoute get _loginGoRoute => GoRoute(
        path: RoutePath.login.path,
        builder: (BuildContext context, GoRouterState state) =>
            const LoginView(),
        routes: [
          GoRoute(
            path: RoutePath.forgetPassword.path,
            builder: (BuildContext context, GoRouterState state) =>
                const ForgetPasswordView(),
          ),
        ],
      );

  GoRoute get _homeGoRoute => GoRoute(
        path: RoutePath.home.path,
        builder: (BuildContext context, GoRouterState state) =>
            const HomeView(),
        routes: const [],
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
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
