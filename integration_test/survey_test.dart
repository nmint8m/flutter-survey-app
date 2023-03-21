import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kayla_flutter_ic/views/survey_detail/survey_detail_component_id.dart';
import 'utils/fake_data.dart';
import 'utils/test_util.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  test();
}

void test() {
  group('Survey Detail Page', () {
    late Finder startSurveyButton;

    setUpAll(() async {
      await TestUtil.setupTestEnvironment();
    });

    setUp(() {
      startSurveyButton = find.byKey(SurveyDetailComponentId.startSurveyButton);
    });

    testWidgets("When starting, it displays the Survey screen correctly",
        (WidgetTester tester) async {
      await tester.pumpWidget(TestUtil.pumpWidgetWithShellAppGoRouter(
        location: '/surveys/111',
        isLogin: true,
      ));
      await FakeData.initDefault();
      await tester.pumpAndSettle();

      expect(startSurveyButton, findsOneWidget);
    });
  });
}
