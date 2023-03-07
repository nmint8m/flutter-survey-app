import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:kayla_flutter_ic/api/storage/secure_storage.dart';
import 'package:kayla_flutter_ic/model/survey_detail.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';

@Injectable()
class GetCurrentSurveyDetailUseCase extends NoParamsUseCase<SurveyDetail?> {
  final SecureStorage _secureStorage;

  const GetCurrentSurveyDetailUseCase(
    this._secureStorage,
  );

  @override
  Future<Result<SurveyDetail?>> call() async {
    try {
      final json = await _secureStorage.surveyDetailJson;
      if (json == null) {
        return Success(null);
      }
      dynamic jsonMap = jsonDecode(json);
      if (jsonMap is Map<String, dynamic>) {
        return Success(SurveyDetail.fromJson(jsonMap));
      } else {
        return Failed(UseCaseException('JSON wrong format'));
      }
    } catch (exception) {
      return Failed(UseCaseException(exception));
    }
  }
}
