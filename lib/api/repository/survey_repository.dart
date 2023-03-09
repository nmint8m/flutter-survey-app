import 'package:injectable/injectable.dart';
import 'package:kayla_flutter_ic/api/api_service.dart';
import 'package:kayla_flutter_ic/api/exception/network_exceptions.dart';
import 'package:kayla_flutter_ic/api/response/survey_detail_response.dart';
import 'package:kayla_flutter_ic/api/response/surveys_response.dart';
import 'package:kayla_flutter_ic/model/survey_submission.dart';

abstract class SurveyRepository {
  Future<SurveysResponse> getSurveys(
    int pageNumber,
    int pageSize,
  );

  Future<SurveyDetailResponse> getSurveyDetail(String id);

  Future<void> submitSurveyAnswer(SurveySubmission submission);
}

@Singleton(as: SurveyRepository)
class SurveyRepositoryImpl extends SurveyRepository {
  final ApiService _apiService;

  SurveyRepositoryImpl(this._apiService);

  @override
  Future<SurveysResponse> getSurveys(
    int pageNumber,
    int pageSize,
  ) async {
    try {
      final result = await _apiService.getSurveys(
        pageNumber,
        pageSize,
      );
      return result;
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }

  @override
  Future<SurveyDetailResponse> getSurveyDetail(String id) async {
    try {
      final result = await _apiService.getSurveyDetail(id);
      return result;
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }

  @override
  Future<void> submitSurveyAnswer(SurveySubmission submission) async {
    try {
      final result = await _apiService
          .submitSurveyAnswer(submission.toObmitNullFieldsJson());
      return result;
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
