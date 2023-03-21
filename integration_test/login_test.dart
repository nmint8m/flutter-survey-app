import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kayla_flutter_ic/utils/durations.dart';
import 'package:kayla_flutter_ic/views/home/home_view.dart';
import 'package:kayla_flutter_ic/views/login/login_component_id.dart';
import 'package:kayla_flutter_ic/views/login/login_view.dart';
import 'utils/fake_data.dart';
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

    testWidgets("When starting, it displays the Login screen correctly",
        (WidgetTester tester) async {
      await tester
          .pumpWidget(TestUtil.pumpWidgetWithShellApp(const LoginView()));
      await tester.pumpAndSettle();

      expect(emailTextField, findsOneWidget);
      expect(passwordTextField, findsOneWidget);
      expect(loginButton, findsOneWidget);
    });

    testWidgets(
        "When login with valid email or password, but the API returns failed",
        (WidgetTester tester) async {
      FakeData.updateResponse(
        keyLogin,
        const FakeResponseModel(400, {}),
      );
      await tester
          .pumpWidget(TestUtil.pumpWidgetWithShellApp(const LoginView()));
      await tester.pumpAndSettle();
      await tester.enterText(emailTextField, 'test@email.com');
      await tester.enterText(passwordTextField, '12345678');
      await tester.tap(loginButton);
      await tester.pump(Durations.halfSecond);
      await tester.pumpAndSettle();

      expect(find.text('Please try again.'), findsOneWidget);
    });

    testWidgets(
        "When login with invalid email or password format, it returns error messages",
        (WidgetTester tester) async {
      FakeData.updateResponse(
        keyLogin,
        const FakeResponseModel(400, {}),
      );
      await tester
          .pumpWidget(TestUtil.pumpWidgetWithShellApp(const LoginView()));
      await tester.pumpAndSettle();
      await tester.enterText(emailTextField, 'test@invalidemail');
      await tester.enterText(passwordTextField, 'invalid');
      await tester.tap(loginButton);
      await tester.pump(Durations.halfSecond);
      await tester.pumpAndSettle();

      expect(find.text('Wrong email format.'), findsOneWidget);
      expect(find.text('The password should be longer 8 characters.'),
          findsOneWidget);
    });

    testWidgets(
        "When login with empty email or password format, it returns error messages",
        (WidgetTester tester) async {
      FakeData.updateResponse(
        keyLogin,
        const FakeResponseModel(400, {}),
      );
      await tester
          .pumpWidget(TestUtil.pumpWidgetWithShellApp(const LoginView()));
      await tester.pumpAndSettle();
      await tester.enterText(emailTextField, '');
      await tester.enterText(passwordTextField, '');
      await tester.tap(loginButton);
      await tester.pump(Durations.halfSecond);
      await tester.pumpAndSettle();

      expect(find.text('Please enter your email!'), findsOneWidget);
      expect(find.text('Please enter your password!'), findsOneWidget);
    });

    testWidgets(
        "When login with valid email or password, but the API returns successfully",
        (WidgetTester tester) async {
      await tester.pumpWidget(TestUtil.pumpWidgetWithShellAppGoRouter(
        location: '/login',
        isLogin: false,
      ));
      FakeData.initDefault();
      await tester.pumpAndSettle();
      await tester.enterText(emailTextField, 'test@email.com');
      await tester.enterText(passwordTextField, '12345678');
      await tester.tap(loginButton);
      await tester.pump(Durations.halfSecond);
      await tester.pumpAndSettle();

      expect(find.byType(HomeView), findsOneWidget);
    });
  });
}
