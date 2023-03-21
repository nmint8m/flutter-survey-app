import 'package:flutter_test/flutter_test.dart';
import 'package:kayla_flutter_ic/api/api_service.dart';
import 'package:kayla_flutter_ic/api/response/me_response.dart';
import 'package:kayla_flutter_ic/api/response/survey_detail_response.dart';
import 'package:kayla_flutter_ic/api/response/surveys_response.dart';
import 'package:kayla_flutter_ic/model/response/user_response.dart';
import 'package:kayla_flutter_ic/utils/durations.dart';
import '../utils/fake_data.dart';

class FakeApiService extends Fake implements BaseApiService {
  @override
  Future<List<UserResponse>> getUsers() async {
    await Future.delayed(Durations.fiftyMillisecond);
    const response = FakeResponseModel(
      404,
      {},
    );
    throw generateDioError(response.statusCode);
  }

  @override
  Future<MeResponse> getMyProfile() async {
    await Future.delayed(Durations.fiftyMillisecond);
    final response = FakeData.apiAndResponse[keyMyProfile]!;
    if (response.statusCode != 200) {
      throw generateDioError(response.statusCode);
    }
    return MeResponse.fromJson(response.json);
  }

  @override
  Future<SurveysResponse> getSurveys(
    int pageNumber,
    int pageSize,
  ) async {
    await Future.delayed(Durations.fiftyMillisecond);
    final response = FakeData.apiAndResponse[keySurveys]!;
    if (response.statusCode != 200) {
      throw generateDioError(response.statusCode);
    }
    return SurveysResponse.fromJson(response.json);
  }

  @override
  Future<SurveyDetailResponse> getSurveyDetail(
    String id,
  ) async {
    final response = FakeData.apiAndResponse[keySurveyDetail]!;
    if (response.statusCode != 200) {
      throw generateDioError(response.statusCode);
    }
    return SurveyDetailResponse.fromJson(response.json);
  }

  @override
  Future<void> submitSurveyAnswer(
    Map<String, dynamic> body,
  ) async {
    final response = FakeData.apiAndResponse[keySubmitSurvey]!;
    if (response.statusCode != 200) {
      throw generateDioError(response.statusCode);
    }
  }
}
