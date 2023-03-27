import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:kayla_flutter_ic/utils/durations.dart';
import 'package:kayla_flutter_ic/views/answer/answer_component_id.dart';
import 'package:kayla_flutter_ic/views/home/home_view.dart';
import 'package:kayla_flutter_ic/views/question/question_component_id.dart';
import 'package:kayla_flutter_ic/views/question/question_container_view.dart';
import 'package:kayla_flutter_ic/views/survey_detail/survey_detail_component_id.dart';
import 'utils/fake_data.dart';
import 'utils/test_util.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  test();
}

void test() {
  group('Question Page', () {
    late Finder nextButton;
    late Finder submitButton;
    late Finder answerView;

    setUpAll(() async {
      await TestUtil.setupTestEnvironment();
    });

    testWidgets("When starting, it displays the Question screen correctly",
        (WidgetTester tester) async {
      await tester.pumpWidget(TestUtil.pumpWidgetWithShellAppGoRouter(
        location: '/surveys/111',
        isLogin: true,
      ));
      await FakeData.initDefault();
      await tester.pumpAndSettle();
      final startSurveyButton =
          find.byKey(SurveyDetailComponentId.startSurveyButton);
      await tester.tap(startSurveyButton);
      await tester.pumpAndSettle();

      expect(find.byType(QuestionContainerView), findsOneWidget);
      nextButton = find.byKey(QuestionComponentId.nextButton);
      expect(nextButton, findsOneWidget);

      await tester.tap(nextButton);
      await tester.pumpAndSettle();

      submitButton = find.byKey(QuestionComponentId.submitButton);
      expect(submitButton, findsOneWidget);
    });

    testWidgets("Submit survey answer successfully",
        (WidgetTester tester) async {
      await tester.pumpWidget(TestUtil.pumpWidgetWithShellAppGoRouter(
        location: '/surveys/111',
        isLogin: true,
      ));
      await FakeData.initDefault();
      await tester.pumpAndSettle();
      final startSurveyButton =
          find.byKey(SurveyDetailComponentId.startSurveyButton);
      await tester.tap(startSurveyButton);
      await tester.pumpAndSettle();

      answerView = find.byKey(AnswerComponentId.answer('1'));
      await tester.tap(answerView);
      await tester.pumpAndSettle();

      nextButton = find.byKey(QuestionComponentId.nextButton);
      await tester.tap(nextButton);
      await tester.pumpAndSettle();

      submitButton = find.byKey(QuestionComponentId.submitButton);
      await tester.tap(submitButton);
      await tester.pumpAndSettle();
      await tester.pump(Durations.fiveSecond);

      expect(find.byType(HomeView), findsOneWidget);
    });
  });
}
