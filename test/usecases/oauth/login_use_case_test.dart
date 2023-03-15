import 'package:flutter_test/flutter_test.dart';
import 'package:kayla_flutter_ic/api/exception/network_exceptions.dart';
import 'package:kayla_flutter_ic/model/oauth_login.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/usecases/oath/login_use_case.dart';
import 'package:mockito/mockito.dart';
import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('LoginUseCaseTest', () {
    late MockOAuthRepository repository;
    late MockSecureStorage secureStorage;
    late LoginUseCase useCase;

    setUp(() {
      repository = MockOAuthRepository();
      secureStorage = MockSecureStorage();
      useCase = LoginUseCase(
        repository,
        secureStorage,
      );
    });

    test(
        'When logging in with valid email and password, it returns success result',
        () async {
      when(repository.login(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async {
        return const OAuthLogin(
          id: 'id',
          tokenType: 'tokenType',
          accessToken: 'accessToken',
          expiresIn: 1,
          refreshToken: 'refreshToken',
        );
      });
      final result = await useCase.call(LoginParams(
        email: 'email',
        password: 'password',
      ));

      expect(result, isA<Success>());
      expect(
        verify(secureStorage.storeId(captureAny)).captured.single,
        'id',
      );
      expect(
        verify(secureStorage.storeTokenType(captureAny)).captured.single,
        'tokenType',
      );
      expect(
        verify(secureStorage.storeAccessToken(captureAny)).captured.single,
        'accessToken',
      );
      expect(
        verify(secureStorage.storeExpiresIn(captureAny)).captured.single,
        '1.0',
      );
      expect(
        verify(secureStorage.storeRefreshToken(captureAny)).captured.single,
        'refreshToken',
      );
    });

    test(
        'When logging in with incorrect email or password, it returns failed result',
        () async {
      when(repository.login(
        email: anyNamed('email'),
        password: anyNamed('password'),
      )).thenAnswer((_) async {
        return Future.error(
          const NetworkExceptions.unauthorisedRequest(),
        );
      });
      final result = await useCase.call(LoginParams(
        email: 'email',
        password: 'password',
      ));

      expect(result, isA<Failed>());
      expect((result as Failed).exception.actualException,
          const NetworkExceptions.unauthorisedRequest());
      verifyNever(secureStorage.storeId(captureAny));
      verifyNever(secureStorage.storeTokenType(captureAny));
      verifyNever(secureStorage.storeAccessToken(captureAny));
      verifyNever(secureStorage.storeExpiresIn(captureAny));
      verifyNever(secureStorage.storeRefreshToken(captureAny));
    });
  });
}
