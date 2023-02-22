import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String id;
  final String email;
  final String avatarUrl;

  const Profile({
    required this.id,
    required this.email,
    required this.avatarUrl,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        avatarUrl,
      ];
}
