class Answer {
  final String id;
  final String text;
  final int displayOrder;

  Answer({
    required this.id,
    required this.text,
    required this.displayOrder,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'text': text,
      'displayOrder': displayOrder,
    };
  }

  factory Answer.fromJson(Map<String, dynamic> json) {
    String id = json['id'];
    String text = json['text'];
    int displayOrder = json['displayOrder'];
    return Answer(
      id: id,
      text: text,
      displayOrder: displayOrder,
    );
  }
}
