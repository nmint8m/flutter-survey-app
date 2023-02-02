import 'package:equatable/equatable.dart';

class OAuthLogin extends Equatable {
  final String id;
  final String accessToken;
  final double expiresIn;
  final String refreshToken;

  const OAuthLogin({
    required this.id,
    required this.accessToken,
    required this.expiresIn,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [
        id,
        accessToken,
        expiresIn,
        refreshToken,
      ];
}
