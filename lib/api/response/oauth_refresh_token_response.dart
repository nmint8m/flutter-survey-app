import 'package:json_annotation/json_annotation.dart';
import 'package:kayla_flutter_ic/api/response/base_response_converter.dart';

part 'oauth_refresh_token_response.g.dart';

@JsonSerializable()
class OAuthRefreshTokenResponse {
  final String id;
  final String type;
  final String accessToken;
  final String tokenType;
  final double expiresIn;
  final String refreshToken;
  final double createdAt;

  OAuthRefreshTokenResponse({
    required this.id,
    required this.type,
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.refreshToken,
    required this.createdAt,
  });

  factory OAuthRefreshTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$OAuthRefreshTokenResponseFromJson(fromJsonApi(json));
}
