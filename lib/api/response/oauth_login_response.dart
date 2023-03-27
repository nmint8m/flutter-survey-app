import 'package:json_annotation/json_annotation.dart';
import 'package:kayla_flutter_ic/api/response/base_response_converter.dart';

part 'oauth_login_response.g.dart';

@JsonSerializable()
class OAuthLoginResponse {
  final String id;
  final String type;
  final String accessToken;
  final String tokenType;
  final double expiresIn;
  final String refreshToken;
  final double createdAt;

  OAuthLoginResponse({
    required this.id,
    required this.type,
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.refreshToken,
    required this.createdAt,
  });

  OAuthLoginResponse.empty()
      : this(
          id: '',
          type: '',
          accessToken: '',
          tokenType: '',
          expiresIn: -1,
          refreshToken: '',
          createdAt: -2,
        );

  factory OAuthLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$OAuthLoginResponseFromJson(fromJsonApi(json));
}
