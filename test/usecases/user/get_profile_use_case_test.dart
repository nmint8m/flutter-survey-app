import 'package:flutter_test/flutter_test.dart';
import 'package:kayla_flutter_ic/api/exception/network_exceptions.dart';
import 'package:kayla_flutter_ic/api/response/me_response.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/usecases/user/get_profile_use_case.dart';
import 'package:mockito/mockito.dart';
import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('GetProfileUseCaseTest', () {
    late MockUserRepository repository;
    late GetProfileUseCase useCase;

    setUp(() {
      repository = MockUserRepository();
      useCase = GetProfileUseCase(
        repository,
      );
    });

    test('When get user profile, it returns success result', () async {
      when(repository.getMyProfile()).thenAnswer((_) async {
        return MeResponse.empty();
      });

      final result = await useCase.call();
      expect(result, isA<Success>());
    });

    test('When get user profile, it returns failed result', () async {
      when(repository.getMyProfile()).thenAnswer((_) async {
        return Future.error(
          const NetworkExceptions.unauthorisedRequest(),
        );
      });
      final result = await useCase.call();

      expect(result, isA<Failed>());
      expect((result as Failed).exception.actualException,
          const NetworkExceptions.unauthorisedRequest());
    });
  });
}
