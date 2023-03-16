import 'package:flutter_test/flutter_test.dart';
import 'package:kayla_flutter_ic/api/exception/network_exceptions.dart';
import 'package:kayla_flutter_ic/api/repository/user_repository.dart';
import 'package:kayla_flutter_ic/api/response/me_response.dart';
import 'package:mockito/mockito.dart';
import '../../mocks/generate_mocks.mocks.dart';
import '../../utils/test_util.dart';

void main() {
  TestUtil.loadValueForTesting();
  group("User repository", () {
    late MockApiService service;
    late UserRepository repository;

    setUp(() async {
      service = MockApiService();
      repository = UserRepositoryImpl(service);
    });

    test(
        'When calling get my profile successfully, it returns corresponding response',
        () async {
      final meResponse = MeResponse.empty();

      when(service.getMyProfile()).thenAnswer((_) async => meResponse);
      final result = await repository.getMyProfile();
      expect(result, meResponse);
    });

    test('When calling get my profile failed, it returns error', () async {
      when(service.getMyProfile())
          .thenAnswer((_) => Future.error(MockDioError()));
      try {
        await repository.getMyProfile();
      } catch (e) {
        expect(e, isInstanceOf<NetworkExceptions>());
      }
    });
  });
}
