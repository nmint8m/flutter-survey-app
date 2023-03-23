import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:kayla_flutter_ic/api/repository/credential_repository.dart';
import 'package:kayla_flutter_ic/api/repository/oauth_repository.dart';
import 'package:kayla_flutter_ic/api/repository/survey_repository.dart';
import 'package:kayla_flutter_ic/api/repository/user_repository.dart';
import 'package:kayla_flutter_ic/api/storage/secure_storage.dart';
import 'package:kayla_flutter_ic/di/di.dart';
import 'package:kayla_flutter_ic/main.dart';
import 'package:kayla_flutter_ic/utils/app_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../fake_services/fake_api_service.dart';
import '../fake_services/fake_oauth_service.dart';

GoRouter? _router;

class TestUtil {
  /// This is useful when we test the whole app with the real configs(styling,
  /// localization, routes, etc)
  static Widget pumpWidgetWithRealApp(String initialRoute) {
    _initDependencies();
    return const MyApp();
  }

  /// We normally use this function to test a specific [widget] without
  /// considering much about theming.
  static Widget pumpWidgetWithShellApp(Widget widget) {
    _initDependencies();
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: ProviderScope(child: widget),
    );
  }

  static Widget pumpWidgetWithShellAppGoRouter({
    required String location,
    required bool isLogin,
  }) {
    _initDependencies();
    _setUpSecureStorage(isLogin);
    _router = getIt.get<AppRouter>().router(location);
    return ProviderScope(
      child: MaterialApp.router(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routeInformationProvider: _router?.routeInformationProvider,
        routeInformationParser: _router?.routeInformationParser,
        routerDelegate: _router?.routerDelegate,
      ),
    );
  }

  static void _initDependencies() {
    PackageInfo.setMockInitialValues(
      appName: 'Flutter templates testing',
      packageName: '',
      version: '',
      buildNumber: '',
      buildSignature: '',
      installerStore: '',
    );
    FlutterConfig.loadValueForTesting({
      'REST_API_ENDPOINT': 'REST_API_ENDPOINT',
      'CLIENT_ID': 'CLIENT_ID',
      'CLIENT_SECRET': 'CLIENT_SECRET',
    });
  }

  static void _setUpSecureStorage(bool isLogin) {
    final secureStorage = getIt.get<SecureStorage>();
    if (isLogin) {
      secureStorage.storeId('id');
      secureStorage.storeTokenType('token_type');
      secureStorage.storeAccessToken('access_token');
      secureStorage.storeExpiresIn('-1');
      secureStorage.storeRefreshToken('refresh_token');
    } else {
      secureStorage.clearAllStorage();
    }
  }

  static Future setupTestEnvironment() async {
    _initDependencies();
    await configureDependencies();
    getIt.allowReassignment = true;
    // ignore: todo
    // TODO: - Check with serice later! Currently, we can mock with repository only
    getIt.registerSingleton<CredentialRepository>(
        CredentialRepositoryImpl(FakeApiService()));
    getIt.registerSingleton<OAuthRepository>(
        OAuthRepositoryImpl(FakeOAuthService()));
    getIt.registerSingleton<SurveyRepository>(
        SurveyRepositoryImpl(FakeApiService()));
    getIt.registerSingleton<UserRepository>(
        UserRepositoryImpl(FakeApiService()));
  }
}
