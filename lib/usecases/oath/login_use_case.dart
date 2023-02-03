import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:kayla_flutter_ic/api/repository/oauth_repository.dart';
import 'package:kayla_flutter_ic/model/oauth_login.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';

part 'login_params.dart';

@Injectable()
class LoginUseCase extends UseCase<OAuthLogin, LoginParams> {
  final OAuthRepository _repository;

  const LoginUseCase(this._repository);

  @override
  Future<Result<OAuthLogin>> call(LoginParams params) async {
    try {
      final result = await _repository.login(
        email: params.email,
        password: params.password,
      );
      return Success(result);
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }
}
