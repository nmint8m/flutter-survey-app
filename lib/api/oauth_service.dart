import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:kayla_flutter_ic/api/request/oauth_login_request.dart';
import 'package:kayla_flutter_ic/api/response/oauth_login_response.dart';

part 'oauth_service.g.dart';

abstract class BaseOAuthService {
  Future<OAuthLoginResponse> login(
    @Body() OAuthLoginRequest body,
  );
}

@RestApi()
abstract class OAuthService extends BaseOAuthService {
  factory OAuthService(Dio dio, {String baseUrl}) = _OAuthService;

  @POST('/api/v1/oauth/token')
  Future<OAuthLoginResponse> login(
    @Body() OAuthLoginRequest body,
  );
}
