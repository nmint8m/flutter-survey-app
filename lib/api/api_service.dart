import 'package:dio/dio.dart';
import 'package:kayla_flutter_ic/api/response/me_response.dart';
import 'package:kayla_flutter_ic/api/response/survey_detail_response.dart';
import 'package:kayla_flutter_ic/api/response/surveys_response.dart';
import 'package:kayla_flutter_ic/model/response/user_response.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

abstract class BaseApiService {
  Future<List<UserResponse>> getUsers();

  Future<MeResponse> getMyProfile();

  Future<SurveysResponse> getSurveys(
    int pageNumber,
    int pageSize,
  );

  Future<SurveyDetailResponse> getSurveyDetail(
    String id,
  );

  Future<void> submitSurveyAnswer(
    @Body() Map<String, dynamic> body,
  );
}

@RestApi()
abstract class ApiService extends BaseApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @override
  @GET('users')
  Future<List<UserResponse>> getUsers();

  @override
  @GET('/api/v1/me')
  Future<MeResponse> getMyProfile();

  @override
  @GET('/api/v1/surveys?page[number]={pageNumber}&page[size]={pageSize}')
  Future<SurveysResponse> getSurveys(
    @Path('pageNumber') int pageNumber,
    @Path('pageSize') int pageSize,
  );

  @override
  @GET('/api/v1/surveys/{id}')
  Future<SurveyDetailResponse> getSurveyDetail(
    @Path('id') String id,
  );

  @override
  @POST('/api/v1/responses')
  Future<void> submitSurveyAnswer(
    @Body() Map<String, dynamic> body,
  );
}
