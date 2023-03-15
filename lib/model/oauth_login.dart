import 'package:equatable/equatable.dart';

class OAuthLogin extends Equatable {
  final String id;
  final String tokenType;
  final String accessToken;
  final double expiresIn;
  final String refreshToken;

  const OAuthLogin({
    required this.id,
    required this.tokenType,
    required this.accessToken,
    required this.expiresIn,
    required this.refreshToken,
  });

  const OAuthLogin.empty()
      : this(
          id: '',
          tokenType: '',
          accessToken: '',
          expiresIn: -1,
          refreshToken: '',
        );

  @override
  List<Object?> get props => [
        id,
        tokenType,
        accessToken,
        expiresIn,
        refreshToken,
      ];
}
