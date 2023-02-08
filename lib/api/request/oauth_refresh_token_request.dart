import 'package:json_annotation/json_annotation.dart';

part 'oauth_refresh_token_request.g.dart';

@JsonSerializable()
class OAuthRefreshTokenRequest {
  static const String refreshTokenGrantType = 'refresh_token';

  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  @JsonKey(name: 'client_id')
  final String clientId;
  @JsonKey(name: 'client_secret')
  final String clientSecret;
  @JsonKey(name: 'grant_type')
  final String grantType;

  OAuthRefreshTokenRequest({
    required this.refreshToken,
    required this.clientId,
    required this.clientSecret,
    required this.grantType,
  });

  factory OAuthRefreshTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$OAuthRefreshTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OAuthRefreshTokenRequestToJson(this);
}
