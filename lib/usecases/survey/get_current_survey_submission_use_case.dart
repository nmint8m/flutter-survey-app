import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:kayla_flutter_ic/api/storage/secure_storage.dart';
import 'package:kayla_flutter_ic/model/survey_submission.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';

@Injectable()
class GetCurrentSurveySubmissionUseCase
    extends NoParamsUseCase<SurveySubmission?> {
  final SecureStorage _secureStorage;

  const GetCurrentSurveySubmissionUseCase(
    this._secureStorage,
  );

  @override
  Future<Result<SurveySubmission?>> call() async {
    final json = await _secureStorage.surveySubmissionJson;
    if (json == null) {
      return Success(null);
    }
    dynamic jsonMap = jsonDecode(json);
    if (jsonMap is Map<String, dynamic>) {
      return Success(SurveySubmission.fromJson(jsonMap));
    } else {
      return Failed(UseCaseException('JSON wrong format'));
    }
  }
}
