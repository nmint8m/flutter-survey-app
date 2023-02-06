import 'package:json_annotation/json_annotation.dart';

part 'oauth_login_request.g.dart';

@JsonSerializable()
class OAuthLoginRequest {
  static const String passwordGrantType = 'password';

  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'password')
  final String password;
  @JsonKey(name: 'client_id')
  final String clientId;
  @JsonKey(name: 'client_secret')
  final String clientSecret;
  @JsonKey(name: 'grant_type')
  final String grantType;

  OAuthLoginRequest({
    required this.email,
    required this.password,
    required this.clientId,
    required this.clientSecret,
    required this.grantType,
  });

  factory OAuthLoginRequest.fromJson(Map<String, dynamic> json) =>
      _$OAuthLoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OAuthLoginRequestToJson(this);
}
