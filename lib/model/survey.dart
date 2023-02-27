import 'package:equatable/equatable.dart';

class Survey extends Equatable {
  final String id;
  final String title;
  final String description;
  final String coverImageUrl;

  const Survey({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImageUrl,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        coverImageUrl,
      ];
}
