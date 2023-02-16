import 'package:json_annotation/json_annotation.dart';
import 'package:kayla_flutter_ic/api/response/base_response_converter.dart';
import 'package:kayla_flutter_ic/api/response/forget_password_meta_response.dart';

part 'forget_password_response.g.dart';

@JsonSerializable()
class ForgetPasswordResponse {
  final ForgetPasswordMetaResponse meta;

  ForgetPasswordResponse({
    required this.meta,
  });

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordResponseFromJson(fromJsonApi(json));
}
