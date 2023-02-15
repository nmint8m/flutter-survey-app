import 'package:dio/dio.dart';
import 'package:kayla_flutter_ic/api/request/forget_password_request.dart';
import 'package:kayla_flutter_ic/api/request/oauth_login_request.dart';
import 'package:kayla_flutter_ic/api/request/oauth_refresh_token_request.dart';
import 'package:kayla_flutter_ic/api/response/forget_password_response.dart';
import 'package:kayla_flutter_ic/api/response/oauth_login_response.dart';
import 'package:kayla_flutter_ic/api/response/oauth_refresh_token_response.dart';
import 'package:retrofit/retrofit.dart';

part 'oauth_service.g.dart';

@RestApi()
abstract class OAuthService {
  factory OAuthService(Dio dio, {String baseUrl}) = _OAuthService;

  @POST('/api/v1/oauth/token')
  Future<OAuthLoginResponse> login(
    @Body() OAuthLoginRequest body,
  );

  @POST('/api/v1/oauth/token')
  Future<OAuthRefreshTokenResponse> refreshToken(
    @Body() OAuthRefreshTokenRequest body,
  );

  @POST('api/v1/passwords')
  Future<ForgetPasswordResponse> forgetPassword(
    @Body() ForgetPasswordRequest body,
  );
}
