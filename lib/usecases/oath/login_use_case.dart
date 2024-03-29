import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:kayla_flutter_ic/api/repository/oauth_repository.dart';
import 'package:kayla_flutter_ic/api/storage/secure_storage.dart';
import 'package:kayla_flutter_ic/model/oauth_login.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';

part 'login_params.dart';

@Injectable()
class LoginUseCase extends UseCase<OAuthLogin, LoginParams> {
  final OAuthRepository _repository;
  final SecureStorage _secureStorage;

  const LoginUseCase(
    this._repository,
    this._secureStorage,
  );

  @override
  Future<Result<OAuthLogin>> call(LoginParams params) async {
    try {
      final result = await _repository.login(
        email: params.email,
        password: params.password,
      );
      return await _storeTokens(result);
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }

  Future<Result<OAuthLogin>> _storeTokens(OAuthLogin oauthLogin) async {
    try {
      await _secureStorage.storeId(oauthLogin.id);
      await _secureStorage.storeTokenType(oauthLogin.tokenType);
      await _secureStorage.storeAccessToken(oauthLogin.accessToken);
      await _secureStorage.storeExpiresIn('${oauthLogin.expiresIn}');
      await _secureStorage.storeRefreshToken(oauthLogin.refreshToken);
      return Success(oauthLogin);
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }
}
