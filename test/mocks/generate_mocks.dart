import 'package:dio/dio.dart';
import 'package:kayla_flutter_ic/api/api_service.dart';
import 'package:kayla_flutter_ic/api/oauth_service.dart';
import 'package:kayla_flutter_ic/api/repository/oauth_repository.dart';
import 'package:kayla_flutter_ic/api/storage/secure_storage.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/usecases/oath/login_use_case.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  ApiService,
  OAuthService,
  OAuthRepository,
  SecureStorage,
  UseCaseException,
  LoginUseCase,
  DioError,
])
main() {
  // empty class to generate mock repository classes
}
