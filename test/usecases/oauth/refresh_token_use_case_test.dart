import 'package:flutter_test/flutter_test.dart';
import 'package:kayla_flutter_ic/api/exception/network_exceptions.dart';
import 'package:kayla_flutter_ic/model/oauth_refresh_token.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/usecases/oath/refresh_token_use_case.dart';
import 'package:mockito/mockito.dart';
import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('RefreshTokenUseCaseTest', () {
    late MockOAuthRepository repository;
    late MockSecureStorage secureStorage;
    late RefreshTokenUseCase useCase;

    setUp(() {
      repository = MockOAuthRepository();
      secureStorage = MockSecureStorage();
      useCase = RefreshTokenUseCase(
        repository,
        secureStorage,
      );
    });

    test('When refresh token with a token, it returns success result',
        () async {
      when(secureStorage.refreshToken).thenAnswer((_) {
        return Future.value('refreshToken');
      });
      when(repository.refreshToken(
        refreshToken: anyNamed('refreshToken'),
      )).thenAnswer((_) async {
        return const OAuthRefreshToken(
          id: 'id',
          tokenType: 'tokenType',
          accessToken: 'accessToken',
          expiresIn: 1,
          refreshToken: 'newRefreshToken',
        );
      });

      final result = await useCase.call();
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
        'newRefreshToken',
      );
    });

    test('When refresh token with a token, it returns failed result', () async {
      when(secureStorage.refreshToken).thenAnswer((_) {
        return Future.value('refreshToken');
      });
      when(repository.refreshToken(
        refreshToken: anyNamed('refreshToken'),
      )).thenAnswer((_) async {
        return Future.error(
          const NetworkExceptions.unauthorisedRequest(),
        );
      });
      final result = await useCase.call();

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
