import 'package:json_annotation/json_annotation.dart';
import 'package:kayla_flutter_ic/api/response/answer_response.dart';
import 'package:kayla_flutter_ic/api/response/base_response_converter.dart';
import 'package:kayla_flutter_ic/model/enum/display_type.dart';
import 'package:kayla_flutter_ic/model/question.dart';

part 'question_response.g.dart';

@JsonSerializable()
class QuestionResponse {
  final String id;
  final String? text;
  final int? displayOrder;
  final String? imageUrl;
  final String? coverImageUrl;
  final DisplayType? displayType;
  final List<AnswerResponse>? answers;

  QuestionResponse({
    required this.id,
    required this.text,
    required this.displayOrder,
    required this.imageUrl,
    required this.coverImageUrl,
    required this.displayType,
    required this.answers,
  });

  factory QuestionResponse.fromJson(Map<String, dynamic> json) =>
      _$QuestionResponseFromJson(fromJsonApi(json));

  Question toQuestion() => Question(
        id: id,
        text: text ?? '',
        displayOrder: displayOrder ?? 0,
        imageUrl: imageUrl ?? '',
        coverImageUrl: coverImageUrl ?? '',
        displayType: displayType ?? DisplayType.unknown,
        answers: (answers ?? []).map((e) => e.toAnswer()).toList(),
      );
}
