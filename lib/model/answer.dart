import 'package:freezed_annotation/freezed_annotation.dart';

part 'answer.g.dart';

@JsonSerializable()
class Answer {
  final String id;
  final String text;
  final int displayOrder;

  Answer({
    required this.id,
    required this.text,
    required this.displayOrder,
  });

  Map<String, dynamic> toJson() => _$AnswerToJson(this);

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);
}
