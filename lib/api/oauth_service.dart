import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:kayla_flutter_ic/api/request/oauth_login_request.dart';
import 'package:kayla_flutter_ic/api/response/oauth_login_response.dart';

part 'oauth_service.g.dart';

@RestApi()
abstract class OAuthService {
  factory OAuthService(Dio dio, {String baseUrl}) = _OAuthService;

  @POST('/api/v1/oauth/token')
  Future<OAuthLoginResponse> login(
    @Body() OAuthLoginRequest body,
  );
}
