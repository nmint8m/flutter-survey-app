import 'package:json_annotation/json_annotation.dart';
import 'package:kayla_flutter_ic/api/request/forget_password_user_request.dart';

part 'forget_password_request.g.dart';

@JsonSerializable()
class ForgetPasswordRequest {
  @JsonKey(name: 'user')
  final ForgetPasswordUserRequest user;
  @JsonKey(name: 'client_id')
  final String clientId;
  @JsonKey(name: 'client_secret')
  final String clientSecret;

  ForgetPasswordRequest({
    required this.user,
    required this.clientId,
    required this.clientSecret,
  });

  factory ForgetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPasswordRequestToJson(this);
}
