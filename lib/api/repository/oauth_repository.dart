import 'package:injectable/injectable.dart';
import 'package:kayla_flutter_ic/api/exception/network_exceptions.dart';
import 'package:kayla_flutter_ic/api/oauth_service.dart';
import 'package:kayla_flutter_ic/api/request/oauth_login_request.dart';
import 'package:kayla_flutter_ic/env.dart';
import 'package:kayla_flutter_ic/model/oauth_login.dart';

abstract class OAuthRepository {
  Future<OAuthLogin> login({
    required String email,
    required String password,
  });
}

@Singleton(as: OAuthRepository)
class OAuthRepositoryImpl extends OAuthRepository {
  final OAuthService _oauthService;

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
}
