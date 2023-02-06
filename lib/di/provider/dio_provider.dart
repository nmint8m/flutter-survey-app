import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/foundation.dart';
import 'package:kayla_flutter_ic/di/interceptor/app_interceptor.dart';

const String headerContentType = 'Content-Type';
const String defaultContentType = 'application/json; charset=utf-8';

@Singleton()
class DioProvider {
  Dio? _nonAuthenticatedDio;
  Dio? _authenticatedDio;

  Dio getNonAuthenticatedDio() {
    _nonAuthenticatedDio ??= _createDio();
    return _nonAuthenticatedDio!;
  }

  Dio getAuthenticatedDio() {
    _authenticatedDio ??= _createDio(requireAuthenticate: true);
    return _authenticatedDio!;
  }

  Dio _createDio({bool requireAuthenticate = false}) {
    final dio = Dio();
    final appInterceptor = AppInterceptor(
      requireAuthenticate,
      dio,
    );
    final interceptors = <Interceptor>[];
    interceptors.add(appInterceptor);
    if (!kReleaseMode) {
      interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ));
    }

    return dio
      ..options.connectTimeout = 3000
      ..options.receiveTimeout = 5000
      ..options.headers = {headerContentType: defaultContentType}
      ..interceptors.addAll(interceptors);
  }
}
