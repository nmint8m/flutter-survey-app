import 'package:dio/dio.dart';
import 'package:kayla_flutter_ic/api/response/me_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('/api/v1/me')
  Future<MeResponse> me();
}
