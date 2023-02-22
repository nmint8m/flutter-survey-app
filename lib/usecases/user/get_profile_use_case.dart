import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:kayla_flutter_ic/api/repository/user_repository.dart';
import 'package:kayla_flutter_ic/model/profile.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';

@Injectable()
class GetProfileUseCase extends NoParamsUseCase<Profile> {
  final UserRepository _repository;

  const GetProfileUseCase(
    this._repository,
  );

  @override
  Future<Result<Profile>> call() async {
    try {
      final result = await _repository.getMyProfile();
      return Success(Profile(
        id: result.id,
        email: result.email,
        avatarUrl: result.avatarUrl,
      ));
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }
}
