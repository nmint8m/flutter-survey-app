import 'package:injectable/injectable.dart';
import 'package:kayla_flutter_ic/api/api_service.dart';
import 'package:kayla_flutter_ic/api/exception/network_exceptions.dart';
import 'package:kayla_flutter_ic/api/response/me_response.dart';

abstract class UserRepository {
  Future<MeResponse> getMyProfile();
}

@Singleton(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  final BaseApiService _apiService;

  UserRepositoryImpl(this._apiService);

  @override
  Future<MeResponse> getMyProfile() async {
    try {
      return await _apiService.getMyProfile();
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
