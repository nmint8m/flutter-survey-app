import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kayla_flutter_ic/api/exception/network_exceptions.dart';
import 'package:kayla_flutter_ic/model/oauth_login.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/views/login/login_state.dart';
import 'package:kayla_flutter_ic/views/login/login_view.dart';
import 'package:kayla_flutter_ic/views/login/login_view_model.dart';
import 'package:mockito/mockito.dart';
import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('Login model test', () {
    late MockLoginUseCase loginUseCase;
    late ProviderContainer container;

    setUp(() {
      loginUseCase = MockLoginUseCase();
      container = ProviderContainer(
        overrides: [
          loginViewModelProvider
              .overrideWith((ref) => LoginViewModel(loginUseCase)),
        ],
      );
      addTearDown(container.dispose);
    });

    test('When initializing Login model, its state is Init', () {
      expect(container.read(loginViewModelProvider), const LoginState.init());
    });

    test(
        'When calling login with positive result, it returns states accordingly',
        () {
      when(loginUseCase.call(any))
          .thenAnswer((_) async => Success(const OAuthLogin.empty()));
      final stateStream =
          container.read(loginViewModelProvider.notifier).stream;
      expect(
        stateStream,
        emitsInOrder(
          const [
            LoginState.loading(),
            LoginState.success(),
          ],
        ),
      );
      container
          .read(loginViewModelProvider.notifier)
          .login(email: 'email', password: 'password');
    });

    test(
        'When calling login with negative result and API returns unauthorizedRequest error, it returns states accordingly',
        () {
      final mockException = MockUseCaseException();
      when(mockException.actualException)
          .thenReturn(const NetworkExceptions.unauthorisedRequest());
      when(loginUseCase.call(any))
          .thenAnswer((_) async => Failed(mockException));
      final stateStream =
          container.read(loginViewModelProvider.notifier).stream;
      expect(
        stateStream,
        emitsInOrder(
          [
            const LoginState.loading(),
            LoginState.error(
              NetworkExceptions.getErrorMessage(
                const NetworkExceptions.unauthorisedRequest(),
              ),
            ),
          ],
        ),
      );
      container
          .read(loginViewModelProvider.notifier)
          .login(email: 'email', password: 'password');
    });

    test(
        'When calling login with negative result and API returns other error, it returns states accordingly',
        () {
      final mockException = MockUseCaseException();
      when(mockException.actualException)
          .thenReturn(const NetworkExceptions.internalServerError());
      when(loginUseCase.call(any))
          .thenAnswer((_) async => Failed(mockException));
      final stateStream =
          container.read(loginViewModelProvider.notifier).stream;
      expect(
        stateStream,
        emitsInOrder(
          [
            const LoginState.loading(),
            LoginState.error(
              NetworkExceptions.getErrorMessage(
                const NetworkExceptions.internalServerError(),
              ),
            )
          ],
        ),
      );
      container
          .read(loginViewModelProvider.notifier)
          .login(email: 'email', password: 'password');
    });
  });
}
