import 'package:injectable/injectable.dart';
import 'package:kayla_flutter_ic/api/api_service.dart';
import 'package:kayla_flutter_ic/api/exception/network_exceptions.dart';
import 'package:kayla_flutter_ic/api/response/me_response.dart';

abstract class UserRepository {
  Future<MeResponse> getMe();
}

@Singleton(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  final ApiService _apiService;

  UserRepositoryImpl(this._apiService);

  @override
  Future<MeResponse> getMe() async {
    try {
      return await _apiService.getMe();
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
