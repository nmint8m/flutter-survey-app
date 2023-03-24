import 'package:flutter_test/flutter_test.dart';
import 'package:kayla_flutter_ic/api/exception/network_exceptions.dart';
import 'package:kayla_flutter_ic/model/survey_submission.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/usecases/survey/submit_survey_answer_use_case.dart';
import 'package:mockito/mockito.dart';
import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('SubmitSurveyAnswerUseCase', () {
    late MockSurveyRepository repository;
    late SubmitSurveyAnswerUseCase useCase;

    setUp(() {
      repository = MockSurveyRepository();
      useCase = SubmitSurveyAnswerUseCase(
        repository,
      );
    });

    test('When submit answer, it returns success result', () async {
      when(repository.submitSurveyAnswer(any)).thenAnswer((_) async => true);

      final result =
          await useCase.call(SurveySubmission(surveyId: '', questions: []));
      expect(result, isA<Success>());
    });

    test('When submit answer, it returns failed result', () async {
      when(repository.submitSurveyAnswer(any)).thenAnswer((_) async {
        return Future.error(
          const NetworkExceptions.unauthorisedRequest(),
        );
      });
      final result =
          await useCase.call(SurveySubmission(surveyId: '', questions: []));

      expect(result, isA<Failed>());
      expect((result as Failed).exception.actualException,
          const NetworkExceptions.unauthorisedRequest());
    });
  });
}
