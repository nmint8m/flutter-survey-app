import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kayla_flutter_ic/api/storage/secure_storage.dart';
import 'package:kayla_flutter_ic/di/di.dart';
import 'package:kayla_flutter_ic/model/oauth_refresh_token.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/usecases/oath/refresh_token_use_case.dart';

const _headerAuthorization = 'Authorization';

class AppInterceptor extends Interceptor {
  final bool _requireAuthenticate;
  final Dio _dio;
  final SecureStorage _secureStorage;

  AppInterceptor(
    this._requireAuthenticate,
    this._dio,
    this._secureStorage,
  );

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (_requireAuthenticate) {
      String tokens = await _tokens;
      options.headers.putIfAbsent(_headerAuthorization, () => tokens);
    }
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;
    if ((statusCode == HttpStatus.forbidden ||
            statusCode == HttpStatus.unauthorized) &&
        _requireAuthenticate) {
      _doRefreshToken(err, handler);
    } else {
      handler.next(err);
    }
  }

  Future<void> _doRefreshToken(
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    try {
      final result = await _requestNewTokens();
      if (result is Success<OAuthRefreshToken>) {
        err.requestOptions.headers[_headerAuthorization] = _tokens;
        final options = Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers);
        final newRequest = await _dio.request(
            "${err.requestOptions.baseUrl}${err.requestOptions.path}",
            options: options,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters);
        handler.resolve(newRequest);
      } else {
        handler.next(err);
      }
    } catch (exception) {
      if (exception is DioError) {
        handler.next(exception);
      } else {
        handler.next(err);
      }
    }
  }

  Future<String> get _tokens async {
    final tokenType = await _secureStorage.tokenType;
    final accessToken = await _secureStorage.accessToken;
    if (tokenType == null || accessToken == null) return '';
    return '$tokenType $accessToken';
  }

  Future<Result<OAuthRefreshToken>> _requestNewTokens() {
    final refreshTokenUseCase = getIt<RefreshTokenUseCase>();
    return refreshTokenUseCase.call();
  }
}
