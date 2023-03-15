import 'package:flutter_test/flutter_test.dart';
import 'package:kayla_flutter_ic/api/exception/network_exceptions.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/usecases/oath/forget_password_use_case.dart';
import 'package:mockito/mockito.dart';
import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('RefreshTokenUseCaseTest', () {
    late MockOAuthRepository repository;
    late ForgetPasswordUseCase useCase;

    setUp(() {
      repository = MockOAuthRepository();
      useCase = ForgetPasswordUseCase(
        repository,
      );
    });

    test('When forget password with an email, it returns success result',
        () async {
      when(repository.forgetPassword(
        email: anyNamed('email'),
      )).thenAnswer((_) async {
        return 'Success';
      });

      final result = await useCase.call('email');
      expect(result, isA<Success>());
    });

    test('When forget password with an email, it returns failed result',
        () async {
      when(repository.forgetPassword(
        email: anyNamed('email'),
      )).thenAnswer((_) async {
        return Future.error(
          const NetworkExceptions.unauthorisedRequest(),
        );
      });
      final result = await useCase.call('email');

      expect(result, isA<Failed>());
      expect((result as Failed).exception.actualException,
          const NetworkExceptions.unauthorisedRequest());
    });
  });
}
