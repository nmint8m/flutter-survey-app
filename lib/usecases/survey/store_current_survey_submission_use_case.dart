import 'dart:async';
import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:kayla_flutter_ic/api/storage/secure_storage.dart';
import 'package:kayla_flutter_ic/model/survey_submission.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';

@Injectable()
class StoreCurrentSurveySubmissionUseCase
    extends UseCase<bool, SurveySubmission?> {
  final SecureStorage _secureStorage;

  const StoreCurrentSurveySubmissionUseCase(
    this._secureStorage,
  );

  @override
  Future<Result<bool>> call(SurveySubmission? params) async {
    if (params == null) {
      await _secureStorage.clearSurveySubmissionJson();
    } else {
      await _secureStorage
          .storeSurveySubmissionJson(jsonEncode(params.toJson()));
    }
    return Success(true);
  }
}
