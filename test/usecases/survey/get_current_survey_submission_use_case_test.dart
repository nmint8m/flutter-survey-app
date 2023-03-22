import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:kayla_flutter_ic/model/survey_submission.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/usecases/survey/get_current_survey_submission_use_case.dart';
import 'package:mockito/mockito.dart';
import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('GetCurrentSurveySubmissionUseCase', () {
    late MockSecureStorage secureStorage;
    late GetCurrentSurveySubmissionUseCase useCase;

    setUp(() {
      secureStorage = MockSecureStorage();
      useCase = GetCurrentSurveySubmissionUseCase(
        secureStorage,
      );
    });

    test('When get current survey submission, it returns success result',
        () async {
      when(secureStorage.surveySubmissionJson).thenAnswer(
        (_) async => jsonEncode(SurveySubmission.empty().toJson()),
      );
      final result = await useCase.call();
      expect(result, isA<Success>());
    });

    test('When get current survey detail as null, it returns success result',
        () async {
      when(secureStorage.surveySubmissionJson).thenAnswer(
        (_) => Future.value(null),
      );
      final result = await useCase.call();
      expect(result, isA<Success>());
    });
  });
}
