import 'package:injectable/injectable.dart';
import 'package:kayla_flutter_ic/api/exception/network_exceptions.dart';
import 'package:kayla_flutter_ic/api/oauth_service.dart';
import 'package:kayla_flutter_ic/api/request/oauth_login_request.dart';
import 'package:kayla_flutter_ic/model/oauth_login.dart';

abstract class OAuthRepository {
  Future<OAuthLogin> login({
    required String email,
    required String password,
  });
}

@Singleton(as: OAuthRepository)
class OAuthRepositoryImpl extends OAuthRepository {
  final BaseOAuthService _oauthService;

  OAuthRepositoryImpl(this._oauthService);

  @override
  Future<OAuthLogin> login(
      {required String email, required String password}) async {
    try {
      final response = await _oauthService.login(
        OAuthLoginRequest(
          email: email,
          password: password,
          clientId: 'clientId',
          clientSecret: 'clientSecret',
          grantType: OAuthLoginRequest.passwordGrantType,
        ),
      );
      return OAuthLogin(
        id: response.id,
        accessToken: response.attributes.accessToken,
        expiresIn: response.attributes.expiresIn,
        refreshToken: response.attributes.refreshToken,
      );
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
