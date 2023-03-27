// ignore_for_file: deprecated_member_use
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kayla_flutter_ic/api/exception/network_exceptions.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/views/survey_detail/survey_detail_state.dart';
import 'package:kayla_flutter_ic/views/survey_detail/survey_detail_view.dart';
import 'package:kayla_flutter_ic/views/survey_detail/survey_detail_view_model.dart';
import 'package:mockito/mockito.dart';
import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('Survey detail view model test', () {
    late MockGetSurveyDetailUseCase getSurveyDetailUseCase;
    late MockStoreCurrentSurveyDetailUseCase storeCurrentSurveyDetailUseCase;
    late ProviderContainer container;

    setUp(() {
      getSurveyDetailUseCase = MockGetSurveyDetailUseCase();
      storeCurrentSurveyDetailUseCase = MockStoreCurrentSurveyDetailUseCase();
      container = ProviderContainer(
        overrides: [
          surveyDetailViewModelProvider
              .overrideWith((ref) => SurveyDetailViewModel(
                    getSurveyDetailUseCase,
                    storeCurrentSurveyDetailUseCase,
                  )),
        ],
      );
      addTearDown(container.dispose);
    });

    test('When initializing survey detai view model, its state is Init', () {
      expect(
        container.read(surveyDetailViewModelProvider),
        const SurveyDetailState.init(),
      );
    });

    test(
        'When calling fetch survey with negative result and API returns unauthorizedRequest error, it returns states accordingly',
        () {
      final mockException = MockUseCaseException();
      when(mockException.actualException)
          .thenReturn(const NetworkExceptions.unauthorisedRequest());
      when(getSurveyDetailUseCase.call(any))
          .thenAnswer((_) async => Failed(mockException));
      final stateStream =
          container.read(surveyDetailViewModelProvider.notifier).stream;
      expect(
        stateStream,
        emitsInOrder(
          [
            SurveyDetailState.error(
              NetworkExceptions.getErrorMessage(
                const NetworkExceptions.unauthorisedRequest(),
              ),
            ),
          ],
        ),
      );
      container.read(surveyDetailViewModelProvider.notifier).fetchSurvey('');
    });

    test(
        'When calling fetch survey with negative result and API returns other error, it returns states accordingly',
        () {
      final mockException = MockUseCaseException();
      when(mockException.actualException)
          .thenReturn(const NetworkExceptions.internalServerError());
      when(getSurveyDetailUseCase.call(any))
          .thenAnswer((_) async => Failed(mockException));
      final stateStream =
          container.read(surveyDetailViewModelProvider.notifier).stream;
      expect(
        stateStream,
        emitsInOrder(
          [
            SurveyDetailState.error(
              NetworkExceptions.getErrorMessage(
                const NetworkExceptions.internalServerError(),
              ),
            )
          ],
        ),
      );
      container.read(surveyDetailViewModelProvider.notifier).fetchSurvey('');
    });
  });
}
