import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kayla_flutter_ic/utils/durations.dart';
import 'package:kayla_flutter_ic/views/home/home_component_id.dart';
import 'package:kayla_flutter_ic/views/survey_detail/survey_detail_view.dart';
import 'utils/fake_data.dart';
import 'utils/test_util.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  test();
}

void test() {
  group('Home Page', () {
    late Finder takeSurveyButton;

    setUpAll(() async {
      await TestUtil.setupTestEnvironment();
    });

    testWidgets("When starting, it displays the Home screen correctly",
        (WidgetTester tester) async {
      await tester.pumpWidget(TestUtil.pumpWidgetWithShellAppGoRouter(
        location: '/',
        isLogin: true,
      ));
      await FakeData.initDefault();
      await tester.pumpAndSettle();

      expect(find.text('TODAY'), findsOneWidget);
      takeSurveyButton = find.byKey(HomeComponentId.takeSurveyButton);
      expect(takeSurveyButton, findsOneWidget);
    });

    testWidgets("When tapping on take survey button, it shows Question page",
        (WidgetTester tester) async {
      await tester.pumpWidget(TestUtil.pumpWidgetWithShellAppGoRouter(
        location: '/',
        isLogin: true,
      ));
      await FakeData.initDefault();
      await tester.pumpAndSettle();

      await tester.tap(takeSurveyButton);
      await tester.pump(Durations.halfSecond);

      expect(find.byType(SurveyDetailView), findsOneWidget);
    });
  });
}
