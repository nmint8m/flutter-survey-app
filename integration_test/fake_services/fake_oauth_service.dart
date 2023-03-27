import 'package:flutter_test/flutter_test.dart';
import 'package:kayla_flutter_ic/api/oauth_service.dart';
import 'package:kayla_flutter_ic/api/request/forget_password_request.dart';
import 'package:kayla_flutter_ic/api/request/oauth_login_request.dart';
import 'package:kayla_flutter_ic/api/request/oauth_refresh_token_request.dart';
import 'package:kayla_flutter_ic/api/response/forget_password_response.dart';
import 'package:kayla_flutter_ic/api/response/oauth_login_response.dart';
import 'package:kayla_flutter_ic/api/response/oauth_refresh_token_response.dart';
import 'package:kayla_flutter_ic/utils/durations.dart';
import '../utils/fake_data.dart';

class FakeOAuthService extends Fake implements BaseOAuthService {
  @override
  Future<OAuthLoginResponse> login(
    OAuthLoginRequest body,
  ) async {
    await Future.delayed(Durations.fiftyMillisecond);
    final response = FakeData.apiAndResponse[keyLogin]!;
    if (response.statusCode != 200) {
      throw generateDioError(response.statusCode);
    }
    return OAuthLoginResponse.fromJson(response.json);
  }

  @override
  Future<OAuthRefreshTokenResponse> refreshToken(
    OAuthRefreshTokenRequest body,
  ) async {
    await Future.delayed(Durations.fiftyMillisecond);
    final response = FakeData.apiAndResponse[keyLogin]!;
    if (response.statusCode != 200) {
      throw generateDioError(response.statusCode);
    }
    return OAuthRefreshTokenResponse.fromJson(response.json);
  }

  @override
  Future<ForgetPasswordResponse> forgetPassword(
    ForgetPasswordRequest body,
  ) async {
    await Future.delayed(Durations.fiftyMillisecond);
    final response = FakeData.apiAndResponse[keyLogin]!;
    if (response.statusCode != 200) {
      throw generateDioError(response.statusCode);
    }
    return ForgetPasswordResponse.fromJson(response.json);
  }
}
