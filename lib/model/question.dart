import 'package:kayla_flutter_ic/api/response/display_type.dart';
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
}
