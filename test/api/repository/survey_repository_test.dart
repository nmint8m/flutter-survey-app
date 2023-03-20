import 'package:flutter_test/flutter_test.dart';
import 'package:kayla_flutter_ic/api/exception/network_exceptions.dart';
import 'package:kayla_flutter_ic/api/repository/survey_repository.dart';
import 'package:kayla_flutter_ic/api/response/surveys_response.dart';
import 'package:mockito/mockito.dart';
import '../../mocks/generate_mocks.mocks.dart';
import '../../utils/test_util.dart';

void main() {
  group("Survey repository", () {
    late MockApiService service;
    late SurveyRepository repository;

    setUpAll(() async {
      TestUtil.loadValueForTesting();
    });

    setUp(() async {
      service = MockApiService();
      repository = SurveyRepositoryImpl(service);
    });

    test(
        'When calling get surveys successfully, it returns corresponding response',
        () async {
      final response = SurveysResponse.empty();

      when(service.getSurveys(any, any)).thenAnswer((_) async => response);
      final result = await repository.getSurveys(0, 0);
      expect(result, response);
    });

    test('When calling get surveys failed, it returns error', () async {
      when(service.getMyProfile())
          .thenAnswer((_) => Future.error(MockDioError()));
      try {
        await repository.getSurveys(0, 0);
      } catch (e) {
        expect(e, isInstanceOf<NetworkExceptions>());
      }
    });
  });
}
