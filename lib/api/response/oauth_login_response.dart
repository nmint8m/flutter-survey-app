import 'package:json_annotation/json_annotation.dart';
import 'package:kayla_flutter_ic/api/response/base_response_converter.dart';
import 'package:kayla_flutter_ic/api/response/oauth_login_response_attributes.dart';

part 'oauth_login_response.g.dart';

@JsonSerializable()
class OAuthLoginResponse {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'type')
  final String type;

  @JsonKey(name: 'attributes')
  final OAuthLoginResponseAttributes attributes;

  OAuthLoginResponse({
    required this.id,
    required this.type,
    required this.attributes,
  });

  factory OAuthLoginResponse.fromJson(Map<String, dynamic> json) =>
      _$OAuthLoginResponseFromJson(fromJsonApi(json));
}
