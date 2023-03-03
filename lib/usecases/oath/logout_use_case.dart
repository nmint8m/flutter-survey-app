import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:kayla_flutter_ic/api/storage/secure_storage.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';

@Injectable()
class LogoutUseCase extends NoParamsUseCase<String> {
  final SecureStorage _secureStorage;

  const LogoutUseCase(
    this._secureStorage,
  );

  @override
  Future<Result<String>> call() async {
    _resetTokens();
    return Success('Log out!');
  }

  Future<Result<void>> _resetTokens() async {
    await _secureStorage.clearAllStorage();
    return Success(null);
  }
}
