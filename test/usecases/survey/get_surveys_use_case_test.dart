import 'package:flutter_test/flutter_test.dart';
import 'package:kayla_flutter_ic/api/exception/network_exceptions.dart';
import 'package:kayla_flutter_ic/api/response/surveys_response.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/usecases/survey/get_surveys_params.dart';
import 'package:kayla_flutter_ic/usecases/survey/get_surveys_use_case.dart';
import 'package:mockito/mockito.dart';
import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('GetSurveysUseCaseTest', () {
    late MockSurveyRepository repository;
    late GetSurveysUseCase useCase;

    setUp(() {
      repository = MockSurveyRepository();
      useCase = GetSurveysUseCase(
        repository,
      );
    });

    test('When get surveys, it returns success result', () async {
      when(repository.getSurveys(any, any)).thenAnswer((_) async {
        return SurveysResponse.empty();
      });

      final result =
          await useCase.call(SurveysParams(pageNumber: 0, pageSize: 0));
      expect(result, isA<Success>());
    });

    test('When get surveys, it returns failed result', () async {
      when(repository.getSurveys(any, any)).thenAnswer((_) async {
        return Future.error(
          const NetworkExceptions.unauthorisedRequest(),
        );
      });
      final result =
          await useCase.call(SurveysParams(pageNumber: 0, pageSize: 0));

      expect(result, isA<Failed>());
      expect((result as Failed).exception.actualException,
          const NetworkExceptions.unauthorisedRequest());
    });
  });
}
