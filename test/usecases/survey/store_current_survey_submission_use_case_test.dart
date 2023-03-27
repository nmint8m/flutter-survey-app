import 'package:flutter_test/flutter_test.dart';
import 'package:kayla_flutter_ic/model/survey_submission.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/usecases/survey/store_current_survey_submission_use_case.dart';
import 'package:mockito/mockito.dart';
import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('StoreCurrentSurveySubmissionUseCase', () {
    late MockSecureStorage secureStorage;
    late StoreCurrentSurveySubmissionUseCase useCase;

    setUp(() {
      secureStorage = MockSecureStorage();
      useCase = StoreCurrentSurveySubmissionUseCase(
        secureStorage,
      );
    });

    test(
        'When store current survey submission with data, it returns success result',
        () async {
      final result = await useCase.call(SurveySubmission.empty());
      expect(result, isA<Success>());
      verify(secureStorage.storeSurveySubmissionJson(captureAny)).called(1);
    });

    test(
        'When store current survey submission with null, it returns success result',
        () async {
      final result = await useCase.call(null);
      expect(result, isA<Success>());
      verify(secureStorage.clearSurveySubmissionJson()).called(1);
    });
  });
}
