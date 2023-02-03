import 'package:json_annotation/json_annotation.dart';
import 'package:kayla_flutter_ic/api/response/base_response_converter.dart';

part 'oauth_login_response_attributes.g.dart';

@JsonSerializable()
class OAuthLoginResponseAttributes {
  final String accessToken;
  final String tokenType;
  final double expiresIn;
  final String refreshToken;
  final double createdAt;

  OAuthLoginResponseAttributes({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.refreshToken,
    required this.createdAt,
  });

  factory OAuthLoginResponseAttributes.fromJson(Map<String, dynamic> json) =>
      _$OAuthLoginResponseAttributesFromJson(json);
}
