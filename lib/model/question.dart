import 'package:kayla_flutter_ic/model/enum/display_type.dart';
import 'package:kayla_flutter_ic/model/answer.dart';

class Question {
  final String id;
  final String text;
  final int displayOrder;
  final String imageUrl;
  final String coverImageUrl;
  final DisplayType displayType;
  final List<Answer> answers;

  Question({
    required this.id,
    required this.text,
    required this.displayOrder,
    required this.imageUrl,
    required this.coverImageUrl,
    required this.displayType,
    required this.answers,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'text': text,
      'displayOrder': displayOrder,
      'imageUrl': imageUrl,
      'coverImageUrl': coverImageUrl,
      'displayType': displayType.name,
      'answers': answers.map((e) => e.toJson()).toList(),
    };
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    String id = json['id'];
    String text = json['text'];
    int displayOrder = json['displayOrder'];
    String imageUrl = json['imageUrl'];
    String coverImageUrl = json['coverImageUrl'];
    DisplayType displayType = DisplayType.fromString(json['displayType']);
    dynamic maybeAnswers = json['answers'];
    List<Answer> answers = [];
    if (maybeAnswers is List) {
      for (dynamic maybeAnswer in maybeAnswers) {
        if (maybeAnswer is Map<String, dynamic>) {
          answers.add(Answer.fromJson(maybeAnswer));
        }
      }
    }
    return Question(
      id: id,
      text: text,
      displayOrder: displayOrder,
      imageUrl: imageUrl,
      coverImageUrl: coverImageUrl,
      displayType: displayType,
      answers: answers,
    );
  }
}
