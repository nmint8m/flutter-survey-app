import 'package:flutter_test/flutter_test.dart';
import 'package:kayla_flutter_ic/api/exception/network_exceptions.dart';
import 'package:kayla_flutter_ic/api/response/survey_detail_response.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/usecases/survey/get_survey_detail_use_case.dart';
import 'package:mockito/mockito.dart';
import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('GetCurrentSurveySubmissionUseCase', () {
    late MockSurveyRepository repository;
    late GetSurveyDetailUseCase useCase;

    setUp(() {
      repository = MockSurveyRepository();
      useCase = GetSurveyDetailUseCase(
        repository,
      );
    });

    test('When get survey detail, it returns success result', () async {
      when(repository.getSurveyDetail(any)).thenAnswer(
        (_) async => SurveyDetailResponse.empty(),
      );
      final result = await useCase.call('');
      expect(result, isA<Success>());
    });

    test('When get survey detail as null, it returns failed result', () async {
      when(repository.getSurveyDetail(any)).thenAnswer(
        (_) async => Future.error(
          const NetworkExceptions.unauthorisedRequest(),
        ),
      );
      final result = await useCase.call('');
      expect(result, isA<Failed>());
      expect((result as Failed).exception.actualException,
          const NetworkExceptions.unauthorisedRequest());
    });
  });
}
