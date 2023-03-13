import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:kayla_flutter_ic/api/repository/survey_repository.dart';
import 'package:kayla_flutter_ic/model/survey_submission.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';

@Injectable()
class SubmitSurveyAnswerUseCase extends UseCase<bool, SurveySubmission> {
  final SurveyRepository _repository;

  const SubmitSurveyAnswerUseCase(
    this._repository,
  );

  @override
  Future<Result<bool>> call(SurveySubmission params) async {
    try {
      await _repository.submitSurveyAnswer(params);
      return Success(true);
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }
}
