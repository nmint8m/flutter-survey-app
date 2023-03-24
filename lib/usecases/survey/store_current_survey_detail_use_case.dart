import 'dart:async';
import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:kayla_flutter_ic/api/storage/secure_storage.dart';
import 'package:kayla_flutter_ic/model/survey_detail.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';

@Injectable()
class StoreCurrentSurveyDetailUseCase extends UseCase<bool, SurveyDetail> {
  final SecureStorage _secureStorage;

  const StoreCurrentSurveyDetailUseCase(
    this._secureStorage,
  );

  @override
  Future<Result<bool>> call(SurveyDetail params) async {
    await _secureStorage.storeSurveyDetailJson(jsonEncode(params.toJson()));
    return Success(true);
  }
}
