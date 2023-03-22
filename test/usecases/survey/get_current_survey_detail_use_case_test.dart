import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:kayla_flutter_ic/model/survey_detail.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/usecases/survey/get_current_survey_detail_use_case.dart';
import 'package:mockito/mockito.dart';
import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('GetCurrentSurveyDetailUseCase', () {
    late MockSecureStorage secureStorage;
    late GetCurrentSurveyDetailUseCase useCase;

    setUp(() {
      secureStorage = MockSecureStorage();
      useCase = GetCurrentSurveyDetailUseCase(
        secureStorage,
      );
    });

    test('When get current survey detail, it returns success result', () async {
      when(secureStorage.surveyDetailJson).thenAnswer(
        (_) async => jsonEncode(SurveyDetail.empty().toJson()),
      );
      final result = await useCase.call();
      expect(result, isA<Success>());
    });

    test('When get current survey detail as null, it returns success result',
        () async {
      when(secureStorage.surveyDetailJson).thenAnswer(
        (_) async => null,
      );
      final result = await useCase.call();
      expect(result, isA<Success>());
    });
  });
}
