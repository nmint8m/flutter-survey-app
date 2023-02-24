import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:kayla_flutter_ic/api/repository/survey_repository.dart';
import 'package:kayla_flutter_ic/api/response/surveys_response.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/usecases/survey/get_surveys_params.dart';

@Injectable()
class GetSurveysUseCase extends UseCase<SurveysResponse, SurveysParams> {
  final SurveyRepository _repository;

  const GetSurveysUseCase(
    this._repository,
  );

  @override
  Future<Result<SurveysResponse>> call(SurveysParams params) async {
    try {
      final result = await _repository.getSurveys(
        params.pageNumber,
        params.pageSize,
      );
      return Success(result);
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }
}
