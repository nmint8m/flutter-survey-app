import 'package:dio/dio.dart';
import 'package:kayla_flutter_ic/api/request/forget_password_request.dart';
import 'package:kayla_flutter_ic/api/request/oauth_login_request.dart';
import 'package:kayla_flutter_ic/api/request/oauth_refresh_token_request.dart';
import 'package:kayla_flutter_ic/api/response/forget_password_response.dart';
import 'package:kayla_flutter_ic/api/response/oauth_login_response.dart';
import 'package:kayla_flutter_ic/api/response/oauth_refresh_token_response.dart';
import 'package:retrofit/retrofit.dart';

part 'oauth_service.g.dart';

abstract class BaseOAuthService {
  Future<OAuthLoginResponse> login(
    OAuthLoginRequest body,
  );

  Future<OAuthRefreshTokenResponse> refreshToken(
    OAuthRefreshTokenRequest body,
  );

  Future<ForgetPasswordResponse> forgetPassword(
    ForgetPasswordRequest body,
  );
}

@RestApi()
abstract class OAuthService extends BaseOAuthService {
  factory OAuthService(Dio dio, {String baseUrl}) = _OAuthService;

  @override
  @POST('/api/v1/oauth/token')
  Future<OAuthLoginResponse> login(
    @Body() OAuthLoginRequest body,
  );

  @override
  @POST('/api/v1/oauth/token')
  Future<OAuthRefreshTokenResponse> refreshToken(
    @Body() OAuthRefreshTokenRequest body,
  );

  @override
  @POST('api/v1/passwords')
  Future<ForgetPasswordResponse> forgetPassword(
    @Body() ForgetPasswordRequest body,
  );
}
