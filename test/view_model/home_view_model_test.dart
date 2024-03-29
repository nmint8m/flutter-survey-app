// ignore_for_file: deprecated_member_use
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kayla_flutter_ic/api/exception/network_exceptions.dart';
import 'package:kayla_flutter_ic/api/response/surveys_response.dart';
import 'package:kayla_flutter_ic/model/profile.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/views/home/home_state.dart';
import 'package:kayla_flutter_ic/views/home/home_view.dart';
import 'package:kayla_flutter_ic/views/home/home_view_model.dart';
import 'package:mockito/mockito.dart';
import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('Home view model test', () {
    late MockLogoutUseCase logoutUseCase;
    late MockGetProfileUseCase getProfileUseCase;
    late MockGetSurveysUseCase getSurveysUseCase;
    late ProviderContainer container;

    setUp(() {
      logoutUseCase = MockLogoutUseCase();
      getProfileUseCase = MockGetProfileUseCase();
      getSurveysUseCase = MockGetSurveysUseCase();
      container = ProviderContainer(
        overrides: [
          homeViewModelProvider.overrideWith((ref) => HomeViewModel(
                logoutUseCase: logoutUseCase,
                getProfileUseCase: getProfileUseCase,
                getSurveysUseCase: getSurveysUseCase,
              )),
        ],
      );
      addTearDown(container.dispose);
    });

    test('When initializing home view model, its state is Init', () {
      expect(
        container.read(homeViewModelProvider),
        const HomeState.init(),
      );
    });

    test(
        'When calling get profile with positive result, it returns states accordingly',
        () {
      when(getProfileUseCase.call())
          .thenAnswer((_) async => Success(const Profile.empty()));
      final stateStream = container.read(homeViewModelProvider.notifier).stream;
      expect(
        stateStream,
        emitsInOrder([]),
      );
      final urlStream = container.read(profileImageUrlStream.stream);
      expect(
        urlStream,
        emitsInOrder(['']),
      );
      container.read(homeViewModelProvider.notifier).fetchProfile();
    });

    test(
        'When calling get profile with negative result and API returns unauthorizedRequest error, it returns states accordingly',
        () {
      final mockException = MockUseCaseException();
      when(mockException.actualException)
          .thenReturn(const NetworkExceptions.unauthorisedRequest());
      when(getProfileUseCase.call())
          .thenAnswer((_) async => Failed(mockException));
      final stateStream = container.read(homeViewModelProvider.notifier).stream;
      expect(
        stateStream,
        emitsInOrder(
          [
            HomeState.error(
              NetworkExceptions.getErrorMessage(
                const NetworkExceptions.unauthorisedRequest(),
              ),
            ),
          ],
        ),
      );
      container.read(homeViewModelProvider.notifier).fetchProfile();
    });

    test(
        'When calling get profile with negative result and API returns other error, it returns states accordingly',
        () {
      final mockException = MockUseCaseException();
      when(mockException.actualException)
          .thenReturn(const NetworkExceptions.internalServerError());
      when(getProfileUseCase.call())
          .thenAnswer((_) async => Failed(mockException));
      final stateStream = container.read(homeViewModelProvider.notifier).stream;
      expect(
        stateStream,
        emitsInOrder(
          [
            HomeState.error(
              NetworkExceptions.getErrorMessage(
                const NetworkExceptions.internalServerError(),
              ),
            )
          ],
        ),
      );
      container.read(homeViewModelProvider.notifier).fetchProfile();
    });

    test(
        'When calling get surveys with positive result, it returns states accordingly',
        () {
      when(getSurveysUseCase.call(any))
          .thenAnswer((_) async => Success(SurveysResponse.empty()));
      final trackedFocusedItemIndexStream =
          container.read(focusedItemIndexStream.stream);
      expect(
        trackedFocusedItemIndexStream,
        emitsInOrder([0]),
      );
      final trackedSurveysStream = container.read(surveysStream.stream);
      expect(
        trackedSurveysStream,
        emitsInOrder([[]]),
      );
      container.read(homeViewModelProvider.notifier).fetchSurveys();
    });

    test(
        'When calling get surveys with negative result and API returns unauthorizedRequest error, it returns states accordingly',
        () {
      final mockException = MockUseCaseException();
      when(mockException.actualException)
          .thenReturn(const NetworkExceptions.unauthorisedRequest());
      when(getSurveysUseCase.call(any))
          .thenAnswer((_) async => Failed(mockException));
      final stateStream = container.read(homeViewModelProvider.notifier).stream;
      expect(
        stateStream,
        emitsInOrder(
          [
            HomeState.error(
              NetworkExceptions.getErrorMessage(
                const NetworkExceptions.unauthorisedRequest(),
              ),
            ),
          ],
        ),
      );
      container.read(homeViewModelProvider.notifier).fetchSurveys();
    });

    test(
        'When calling get surveys with negative result and API returns other error, it returns states accordingly',
        () {
      final mockException = MockUseCaseException();
      when(mockException.actualException)
          .thenReturn(const NetworkExceptions.internalServerError());
      when(getSurveysUseCase.call(any))
          .thenAnswer((_) async => Failed(mockException));
      final stateStream = container.read(homeViewModelProvider.notifier).stream;
      expect(
        stateStream,
        emitsInOrder(
          [
            HomeState.error(
              NetworkExceptions.getErrorMessage(
                const NetworkExceptions.internalServerError(),
              ),
            )
          ],
        ),
      );
      container.read(homeViewModelProvider.notifier).fetchSurveys();
    });

    test('When calling change focused index, it streams index accordingly', () {
      final trackedFocusedItemIndexStream =
          container.read(focusedItemIndexStream.stream);
      expect(
        trackedFocusedItemIndexStream,
        emitsInOrder([1, 2]),
      );
      container
          .read(homeViewModelProvider.notifier)
          .changeFocusedItem(index: 1);
      container
          .read(homeViewModelProvider.notifier)
          .changeFocusedItem(index: 2);
    });

    test('When calling log out, it calls log out usecase', () {
      when(logoutUseCase.call()).thenAnswer((_) async => Success('Log out!'));
      container.read(homeViewModelProvider.notifier).logOut();
      verify(logoutUseCase.call()).called(1);
    });
  });
}
