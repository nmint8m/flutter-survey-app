import 'package:json_annotation/json_annotation.dart';
import 'package:kayla_flutter_ic/api/response/base_response_converter.dart';

part 'forget_password_meta_response.g.dart';

@JsonSerializable()
class ForgetPasswordMetaResponse {
  final String message;

  ForgetPasswordMetaResponse({
    required this.message,
  });

  factory ForgetPasswordMetaResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordMetaResponseFromJson(fromJsonApi(json));
}
