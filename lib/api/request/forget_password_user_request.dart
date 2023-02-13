import 'package:json_annotation/json_annotation.dart';

part 'forget_password_user_request.g.dart';

@JsonSerializable()
class ForgetPasswordUserRequest {
  @JsonKey(name: 'email')
  final String email;

  ForgetPasswordUserRequest({
    required this.email,
  });

  factory ForgetPasswordUserRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordUserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPasswordUserRequestToJson(this);
}
