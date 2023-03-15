import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kayla_flutter_ic/utils/durations.dart';
import 'package:kayla_flutter_ic/views/common/loading_indicator/loading_indicator.dart';
import 'package:kayla_flutter_ic/views/login/login_component_id.dart';
import 'package:kayla_flutter_ic/views/login/login_view.dart';
import 'fake_data/fake_data.dart';
import 'utils/test_util.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  loginTest();
}

void loginTest() {
  group('Login Page', () {
    late Finder emailTextField;
    late Finder passwordTextField;
    late Finder loginButton;

    setUpAll(() async {
      await TestUtil.setupTestEnvironment();
    });

    setUp(() {
      emailTextField = find.byKey(LoginComponentId.emailTextField);
      passwordTextField = find.byKey(LoginComponentId.passwordTextField);
      loginButton = find.byKey(LoginComponentId.loginButton);
    });

    testWidgets(
        "When login with invalid email or password, it returns error message",
        (WidgetTester tester) async {
      FakeData.updateResponse(keyLogin, const FakeResponseModel(400, {}));
      await tester
          .pumpWidget(TestUtil.pumpWidgetWithShellApp(const LoginView()));
      await tester.pumpAndSettle();

      expect(emailTextField, findsOneWidget);
      expect(passwordTextField, findsOneWidget);
      expect(loginButton, findsOneWidget);

      await tester.enterText(emailTextField, 'test@email.com');
      await tester.enterText(passwordTextField, '12345678');

      await tester.tap(loginButton);
      await tester.pump(Durations.halfSecond);

      expect(find.byType(LoadingIndicator), findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.text('Login failed! Please recheck your email or password'),
          findsOneWidget);
    });
  });
}
