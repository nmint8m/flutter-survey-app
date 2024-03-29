import 'package:injectable/injectable.dart';
import 'package:kayla_flutter_ic/api/exception/network_exceptions.dart';
import 'package:kayla_flutter_ic/api/oauth_service.dart';
import 'package:kayla_flutter_ic/api/request/forget_password_request.dart';
import 'package:kayla_flutter_ic/api/request/forget_password_user_request.dart';
import 'package:kayla_flutter_ic/api/request/oauth_login_request.dart';
import 'package:kayla_flutter_ic/api/request/oauth_refresh_token_request.dart';
import 'package:kayla_flutter_ic/env.dart';
import 'package:kayla_flutter_ic/model/oauth_login.dart';
import 'package:kayla_flutter_ic/model/oauth_refresh_token.dart';

abstract class OAuthRepository {
  Future<OAuthLogin> login({
    required String email,
    required String password,
  });

  Future<OAuthRefreshToken> refreshToken({
    required String refreshToken,
  });

  Future<String> forgetPassword({
    required String email,
  });
}

@Singleton(as: OAuthRepository)
class OAuthRepositoryImpl extends OAuthRepository {
  final BaseOAuthService _oauthService;

  OAuthRepositoryImpl(this._oauthService);

  @override
  Future<OAuthLogin> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _oauthService.login(
        OAuthLoginRequest(
          email: email,
          password: password,
          clientId: Env.clientId,
          clientSecret: Env.clientSecret,
          grantType: OAuthLoginRequest.passwordGrantType,
        ),
      );
      return OAuthLogin(
        id: response.id,
        tokenType: response.tokenType,
        accessToken: response.accessToken,
        expiresIn: response.expiresIn,
        refreshToken: response.refreshToken,
      );
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }

  @override
  Future<OAuthRefreshToken> refreshToken({
    required String refreshToken,
  }) async {
    try {
      final response =
          await _oauthService.refreshToken(OAuthRefreshTokenRequest(
        refreshToken: refreshToken,
        clientId: Env.clientId,
        clientSecret: Env.clientSecret,
        grantType: OAuthRefreshTokenRequest.refreshTokenGrantType,
      ));
      return OAuthRefreshToken(
        id: response.id,
        tokenType: response.tokenType,
        accessToken: response.accessToken,
        expiresIn: response.expiresIn,
        refreshToken: response.refreshToken,
      );
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }

  @override
  Future<String> forgetPassword({required String email}) async {
    try {
      final response = await _oauthService.forgetPassword(ForgetPasswordRequest(
        user: ForgetPasswordUserRequest(email: email),
        clientId: Env.clientId,
        clientSecret: Env.clientSecret,
      ));
      return response.meta.message;
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
