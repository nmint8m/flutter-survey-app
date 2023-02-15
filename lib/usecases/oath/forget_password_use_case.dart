import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:kayla_flutter_ic/api/repository/oauth_repository.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';

@Injectable()
class ForgetPasswordUseCase extends UseCase<String, String> {
  final OAuthRepository _repository;

  const ForgetPasswordUseCase(
    this._repository,
  );

  @override
  Future<Result<String>> call(String params) async {
    try {
      final result = await _repository.forgetPassword(email: params);
      return Success(result);
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }
}
