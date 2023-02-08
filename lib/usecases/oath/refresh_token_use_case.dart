import 'package:injectable/injectable.dart';
import 'package:kayla_flutter_ic/api/repository/oauth_repository.dart';
import 'package:kayla_flutter_ic/api/storage/secure_storage.dart';
import 'package:kayla_flutter_ic/model/oauth_refresh_token.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';

@Injectable()
class RefreshTokenUseCase extends NoParamsUseCase<OAuthRefreshToken> {
  final OAuthRepository _oauthRepository;
  final SecureStorage _secureStorage;

  const RefreshTokenUseCase(
    this._oauthRepository,
    this._secureStorage,
  );

  @override
  Future<Result<OAuthRefreshToken>> call() async {
    try {
      final refreshToken = await _secureStorage.refreshToken ?? '';
      final result =
          await _oauthRepository.refreshToken(refreshToken: refreshToken);
      return await _storeTokens(result);
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }

  Future<Result<OAuthRefreshToken>> _storeTokens(
      OAuthRefreshToken oauthRefreshToken) async {
    try {
      await _secureStorage.storeId(oauthRefreshToken.id);
      await _secureStorage.storeTokenType(oauthRefreshToken.tokenType);
      await _secureStorage.storeAccessToken(oauthRefreshToken.accessToken);
      await _secureStorage.storeExpiresIn('${oauthRefreshToken.expiresIn}');
      await _secureStorage.storeRefreshToken(oauthRefreshToken.refreshToken);
      return Success(oauthRefreshToken);
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }
}
