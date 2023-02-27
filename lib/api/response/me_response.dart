import 'package:json_annotation/json_annotation.dart';
import 'package:kayla_flutter_ic/api/response/base_response_converter.dart';

part 'me_response.g.dart';

@JsonSerializable()
class MeResponse {
  final String id;
  final String type;
  final String email;
  final String avatarUrl;

  MeResponse({
    required this.id,
    required this.type,
    required this.email,
    required this.avatarUrl,
  });

  factory MeResponse.fromJson(Map<String, dynamic> json) =>
      _$MeResponseFromJson(fromJsonApi(json));
}
