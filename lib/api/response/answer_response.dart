import 'package:json_annotation/json_annotation.dart';
import 'package:kayla_flutter_ic/api/response/base_response_converter.dart';
import 'package:kayla_flutter_ic/model/answer.dart';

part 'answer_response.g.dart';

@JsonSerializable()
class AnswerResponse {
  final String id;
  final String? text;
  final int? displayOrder;

  AnswerResponse({
    required this.id,
    required this.text,
    required this.displayOrder,
  });

  factory AnswerResponse.fromJson(Map<String, dynamic> json) =>
      _$AnswerResponseFromJson(fromJsonApi(json));

  Answer toAnswer() => Answer(
        id: id,
        text: text ?? '',
        displayOrder: displayOrder ?? 0,
      );
}
