import 'package:injectable/injectable.dart';
import 'package:kayla_flutter_ic/api/api_service.dart';
import 'package:kayla_flutter_ic/api/exception/network_exceptions.dart';
import 'package:kayla_flutter_ic/model/survey.dart';

abstract class SurveyRepository {
  Future<List<Survey>> getSurveyList(
    int pageNumber,
    int pageSize,
  );
}

@Singleton(as: SurveyRepository)
class SurveyRepositoryImpl extends SurveyRepository {
  final ApiService _apiService;

  SurveyRepositoryImpl(this._apiService);

  @override
  Future<List<Survey>> getSurveyList(
    int pageNumber,
    int pageSize,
  ) async {
    try {
      final result = await _apiService.getSurveyList(
        pageNumber,
        pageSize,
      );
      final surveys = result.data.map((e) => e.toSurvey()).toList();
      return surveys;
    } catch (exception) {
      throw NetworkExceptions.fromDioException(exception);
    }
  }
}
