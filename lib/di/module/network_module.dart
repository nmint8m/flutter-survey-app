import 'package:injectable/injectable.dart';
import 'package:kayla_flutter_ic/api/api_service.dart';
import 'package:kayla_flutter_ic/api/oauth_service.dart';
import 'package:kayla_flutter_ic/di/provider/dio_provider.dart';
import 'package:kayla_flutter_ic/env.dart';

@module
abstract class NetworkModule {
  @Singleton(as: BaseOAuthService)
  OAuthService provideOAuthService(DioProvider dioProvider) {
    return OAuthService(
      dioProvider.getNonAuthenticatedDio(),
      baseUrl: Env.restApiEndpoint,
    );
  }

  @Singleton(as: BaseApiService)
  ApiService provideApiService(DioProvider dioProvider) {
    return ApiService(
      dioProvider.getAuthenticatedDio(),
      baseUrl: Env.restApiEndpoint,
    );
  }
}
