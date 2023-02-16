import 'package:dio/dio.dart';
import 'package:kayla_flutter_ic/api/response/me_response.dart';
import 'package:kayla_flutter_ic/api/response/survey_list_response.dart';
import 'package:kayla_flutter_ic/model/response/user_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET('users')
  Future<List<UserResponse>> getUsers();

  @GET('/api/v1/me')
  Future<MeResponse> getMyProfile();

  @GET('/api/v1/surveys?page[number]={pageNumber}&page[size]={pageSize}')
  Future<SurveyListResponse> surveyList(
    @Path('pageNumber') int pageNumber,
    @Path('pageSize') int pageSize,
  );
}
