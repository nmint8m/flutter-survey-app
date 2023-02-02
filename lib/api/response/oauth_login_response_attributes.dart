import 'package:json_annotation/json_annotation.dart';
import 'package:kayla_flutter_ic/api/response/base_response_converter.dart';

part 'oauth_login_response_attributes.g.dart';

@JsonSerializable()
class OAuthLoginResponseAttributes {
  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'token_type')
  final String tokenType;
  @JsonKey(name: 'expires_in')
  final double expiresIn;
  @JsonKey(name: 'refresh_token')
  final String refreshToken;
  @JsonKey(name: 'created_at')
  final double createdAt;

  OAuthLoginResponseAttributes({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.refreshToken,
    required this.createdAt,
  });

  factory OAuthLoginResponseAttributes.fromJson(Map<String, dynamic> json) =>
      _$OAuthLoginResponseAttributesFromJson(fromJsonApi(json));
}
