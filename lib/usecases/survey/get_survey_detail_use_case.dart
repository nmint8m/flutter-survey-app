import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:kayla_flutter_ic/api/repository/survey_repository.dart';
import 'package:kayla_flutter_ic/model/survey_detail.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';

@Injectable()
class GetSurveyDetailUseCase extends UseCase<SurveyDetail, String> {
  final SurveyRepository _repository;

  const GetSurveyDetailUseCase(
    this._repository,
  );

  @override
  Future<Result<SurveyDetail>> call(String params) async {
    try {
      final result = await _repository.getSurveyDetail(params);
      return Success(result.toSurveyDetail());
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }
}
