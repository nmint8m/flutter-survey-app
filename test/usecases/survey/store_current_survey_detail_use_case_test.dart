import 'package:flutter_test/flutter_test.dart';
import 'package:kayla_flutter_ic/model/survey_detail.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/usecases/survey/store_current_survey_detail_use_case.dart';
import 'package:mockito/mockito.dart';
import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('StoreCurrentSurveyDetailUseCase', () {
    late MockSecureStorage secureStorage;
    late StoreCurrentSurveyDetailUseCase useCase;

    setUp(() {
      secureStorage = MockSecureStorage();
      useCase = StoreCurrentSurveyDetailUseCase(
        secureStorage,
      );
    });

    test('When store current survey detail, it returns success result',
        () async {
      final result = await useCase.call(SurveyDetail.empty());
      expect(result, isA<Success>());
      verify(secureStorage.storeSurveyDetailJson(captureAny)).called(1);
    });
  });
}
