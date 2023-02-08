import 'package:equatable/equatable.dart';

class OAuthRefreshToken extends Equatable {
  final String id;
  final String tokenType;
  final String accessToken;
  final double expiresIn;
  final String refreshToken;

  const OAuthRefreshToken({
    required this.id,
    required this.tokenType,
    required this.accessToken,
    required this.expiresIn,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [
        id,
        tokenType,
        accessToken,
        expiresIn,
        refreshToken,
      ];
}
