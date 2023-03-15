import 'package:flutter_test/flutter_test.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/usecases/oath/logout_use_case.dart';
import 'package:mockito/mockito.dart';
import '../../mocks/generate_mocks.mocks.dart';

void main() {
  group('LogoutUseCaseTest', () {
    late MockSecureStorage secureStorage;
    late LogoutUseCase useCase;

    setUp(() {
      secureStorage = MockSecureStorage();
      useCase = LogoutUseCase(
        secureStorage,
      );
    });

    test('When logging out', () async {
      final result = await useCase.call();

      expect(result, isA<Success>());
      verify(secureStorage.clearAllStorage()).called(1);
    });
  });
}
