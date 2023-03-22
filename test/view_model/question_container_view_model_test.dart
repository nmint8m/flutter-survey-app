// ignore_for_file: deprecated_member_use
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kayla_flutter_ic/api/exception/network_exceptions.dart';
import 'package:kayla_flutter_ic/model/answer.dart';
import 'package:kayla_flutter_ic/model/enum/display_type.dart';
import 'package:kayla_flutter_ic/model/question.dart';
import 'package:kayla_flutter_ic/model/survey_detail.dart';
import 'package:kayla_flutter_ic/model/survey_submission.dart';
import 'package:kayla_flutter_ic/model/survey_submission_answer.dart';
import 'package:kayla_flutter_ic/model/survey_submission_question.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/views/question/answers_container_ui_model.dart';
import 'package:kayla_flutter_ic/views/question/container_ui_model.dart';
import 'package:kayla_flutter_ic/views/question/question_container_state.dart';
import 'package:kayla_flutter_ic/views/question/question_container_ui_model.dart';
import 'package:kayla_flutter_ic/views/question/question_container_view.dart';
import 'package:kayla_flutter_ic/views/question/question_container_view_model.dart';
import 'package:mockito/mockito.dart';
import '../mocks/generate_mocks.mocks.dart';

void main() {
  group('Question container view model test', () {
    late MockGetCurrentSurveyDetailUseCase getCurrentSurveyDetailUseCase;
    late MockGetCurrentSurveySubmissionUseCase
        getCurrentSurveySubmissionUseCase;
    late MockStoreCurrentSurveySubmissionUseCase
        storeCurrentSurveySubmissionUseCase;
    late MockSubmitSurveyAnswerUseCase submitSurveyAnswerUseCase;
    late ProviderContainer container;

    setUp(() {
      getCurrentSurveyDetailUseCase = MockGetCurrentSurveyDetailUseCase();
      getCurrentSurveySubmissionUseCase =
          MockGetCurrentSurveySubmissionUseCase();
      storeCurrentSurveySubmissionUseCase =
          MockStoreCurrentSurveySubmissionUseCase();
      submitSurveyAnswerUseCase = MockSubmitSurveyAnswerUseCase();
      container = ProviderContainer(
        overrides: [
          questionViewModelProvider
              .overrideWith((ref) => QuestionContainerViewModel(
                    getCurrentSurveyDetailUseCase,
                    getCurrentSurveySubmissionUseCase,
                    storeCurrentSurveySubmissionUseCase,
                    submitSurveyAnswerUseCase,
                  )),
        ],
      );
      addTearDown(container.dispose);
    });

    test('When initializing survey detai view model, its state is Init', () {
      expect(
        container.read(questionViewModelProvider),
        const QuestionContainerState.init(),
      );
    });

    test('When calling set up, it binds empty data accordingly', () {
      when(getCurrentSurveyDetailUseCase.call())
          .thenAnswer((_) async => Success(SurveyDetail.empty()));
      final stateStream =
          container.read(questionViewModelProvider.notifier).stream;
      expect(
        stateStream,
        emitsInOrder(
          [
            QuestionContainerState.success(
              uiModel: ContainerUIModel(
                question: const QuestionContainerUiModel.empty(),
                answer: AnswerContainerUIModel.empty(),
              ),
            ),
          ],
        ),
      );
      container.read(questionViewModelProvider.notifier).setUpData(arguments: {
        'surveyId': '111',
        'questionNumber': '1',
      });
    });

    test('When calling set up, it binds data accordingly', () {
      when(getCurrentSurveyDetailUseCase.call())
          .thenAnswer((_) async => Success(SurveyDetail(
                id: '111',
                title: 'title',
                description: 'description',
                coverImageUrl: 'coverImageUrl',
                questions: [
                  Question(
                    id: 'id0',
                    text: 'text0',
                    displayOrder: 0,
                    imageUrl: 'imageUrl0',
                    coverImageUrl: 'coverImageUrl0',
                    displayType: DisplayType.intro,
                    answers: [],
                  ),
                  Question(
                    id: 'id1',
                    text: 'text1',
                    displayOrder: 1,
                    imageUrl: 'imageUrl1',
                    coverImageUrl: 'coverImageUrl1',
                    displayType: DisplayType.star,
                    answers: [
                      Answer(id: 'id-star0', text: '0', displayOrder: 0),
                      Answer(id: 'id-star1', text: '1', displayOrder: 1),
                      Answer(id: 'id-star2', text: '2', displayOrder: 2),
                      Answer(id: 'id-star3', text: '3', displayOrder: 3),
                      Answer(id: 'id-star4', text: '4', displayOrder: 4),
                    ],
                  ),
                  Question(
                    id: 'id2',
                    text: 'text2',
                    displayOrder: 2,
                    imageUrl: 'imageUrl2',
                    coverImageUrl: 'coverImageUrl2',
                    displayType: DisplayType.outro,
                    answers: [],
                  ),
                ],
              )));
      final stateStream =
          container.read(questionViewModelProvider.notifier).stream;
      expect(
        stateStream,
        emitsInOrder(
          [
            const QuestionContainerState.success(
              uiModel: ContainerUIModel(
                question: QuestionContainerUiModel(
                  questionIndex: 1,
                  totalQuestions: 2,
                  title: 'text1',
                ),
                answer: AnswerContainerUIModel(
                  displayType: DisplayType.star,
                  options: [
                    OptionUiModel(index: 0, id: 'id-star0', title: '0'),
                    OptionUiModel(index: 1, id: 'id-star1', title: '1'),
                    OptionUiModel(index: 2, id: 'id-star2', title: '2'),
                    OptionUiModel(index: 3, id: 'id-star3', title: '3'),
                    OptionUiModel(index: 4, id: 'id-star4', title: '4'),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
      container.read(questionViewModelProvider.notifier).setUpData(arguments: {
        'surveyId': '111',
        'questionNumber': '0',
      });
    });

    test('When calling get path params, it return the right value', () {
      when(getCurrentSurveyDetailUseCase.call())
          .thenAnswer((_) async => Success(SurveyDetail.empty()));
      container.read(questionViewModelProvider.notifier).setUpData(arguments: {
        'surveyId': '111',
        'questionNumber': '1',
      });
      final result =
          container.read(questionViewModelProvider.notifier).getPathParams();

      expect(result, {'surveyId': '111'});
    });

    test('When calling get next query params, it return the right value', () {
      when(getCurrentSurveyDetailUseCase.call())
          .thenAnswer((_) async => Success(SurveyDetail.empty()));
      container.read(questionViewModelProvider.notifier).setUpData(arguments: {
        'surveyId': '111',
        'questionNumber': '1',
      });
      when(getCurrentSurveyDetailUseCase.call())
          .thenAnswer((_) async => Success(SurveyDetail.empty()));
      container.read(questionViewModelProvider.notifier).setUpData(arguments: {
        'surveyId': '111',
        'questionNumber': '1',
      });
      final result = container
          .read(questionViewModelProvider.notifier)
          .getNextQuestionQueryParams();

      expect(result, {'questionNumber': '2'});
    });

    test(
        'When submit answer with positive result, it returns states accordingly',
        () {
      when(getCurrentSurveyDetailUseCase.call())
          .thenAnswer((_) async => Success(SurveyDetail(
                id: '111',
                title: 'title',
                description: 'description',
                coverImageUrl: 'coverImageUrl',
                questions: [
                  Question(
                    id: 'id0',
                    text: 'text0',
                    displayOrder: 0,
                    imageUrl: 'imageUrl0',
                    coverImageUrl: 'coverImageUrl0',
                    displayType: DisplayType.intro,
                    answers: [],
                  ),
                  Question(
                    id: 'id1',
                    text: 'text1',
                    displayOrder: 1,
                    imageUrl: 'imageUrl1',
                    coverImageUrl: 'coverImageUrl1',
                    displayType: DisplayType.star,
                    answers: [
                      Answer(id: 'id-star0', text: '0', displayOrder: 0),
                      Answer(id: 'id-star1', text: '1', displayOrder: 1),
                      Answer(id: 'id-star2', text: '2', displayOrder: 2),
                      Answer(id: 'id-star3', text: '3', displayOrder: 3),
                      Answer(id: 'id-star4', text: '4', displayOrder: 4),
                    ],
                  ),
                  Question(
                    id: 'id2',
                    text: 'text2',
                    displayOrder: 2,
                    imageUrl: 'imageUrl2',
                    coverImageUrl: 'coverImageUrl2',
                    displayType: DisplayType.outro,
                    answers: [],
                  ),
                ],
              )));
      when(getCurrentSurveySubmissionUseCase.call())
          .thenAnswer((_) async => Success(SurveySubmission(
                surveyId: '111',
                questions: [
                  SurveySubmissionQuestion(
                    id: 'id2',
                    answers: [
                      SurveySubmissionAnswer(id: 'id-star0', answer: null),
                    ],
                  )
                ],
              )));
      when(submitSurveyAnswerUseCase.call(any))
          .thenAnswer((_) async => Success(true));
      when(storeCurrentSurveySubmissionUseCase.call(any))
          .thenAnswer((_) async => Success(true));
      container.read(questionViewModelProvider.notifier).setUpData(arguments: {
        'surveyId': '111',
        'questionNumber': '0',
      });
      final stateStream =
          container.read(questionViewModelProvider.notifier).stream;
      const uiModel = ContainerUIModel(
        question: QuestionContainerUiModel(
          questionIndex: 1,
          totalQuestions: 2,
          title: 'text1',
        ),
        answer: AnswerContainerUIModel(
          displayType: DisplayType.star,
          options: [
            OptionUiModel(index: 0, id: 'id-star0', title: '0'),
            OptionUiModel(index: 1, id: 'id-star1', title: '1'),
            OptionUiModel(index: 2, id: 'id-star2', title: '2'),
            OptionUiModel(index: 3, id: 'id-star3', title: '3'),
            OptionUiModel(index: 4, id: 'id-star4', title: '4'),
          ],
        ),
      );
      expect(
        stateStream,
        emitsInOrder(
          [
            const QuestionContainerState.success(uiModel: uiModel),
            const QuestionContainerState.submitting(uiModel: uiModel),
            const QuestionContainerState.submitted(uiModel: uiModel),
          ],
        ),
      );

      container.read(questionViewModelProvider.notifier).submitAnswers();
    });

    test(
        'When submit answer with negative result and API returns unauthorizedRequest error, it returns states accordingly',
        () {
      when(getCurrentSurveyDetailUseCase.call())
          .thenAnswer((_) async => Success(SurveyDetail(
                id: '111',
                title: 'title',
                description: 'description',
                coverImageUrl: 'coverImageUrl',
                questions: [
                  Question(
                    id: 'id0',
                    text: 'text0',
                    displayOrder: 0,
                    imageUrl: 'imageUrl0',
                    coverImageUrl: 'coverImageUrl0',
                    displayType: DisplayType.intro,
                    answers: [],
                  ),
                  Question(
                    id: 'id1',
                    text: 'text1',
                    displayOrder: 1,
                    imageUrl: 'imageUrl1',
                    coverImageUrl: 'coverImageUrl1',
                    displayType: DisplayType.star,
                    answers: [
                      Answer(id: 'id-star0', text: '0', displayOrder: 0),
                      Answer(id: 'id-star1', text: '1', displayOrder: 1),
                      Answer(id: 'id-star2', text: '2', displayOrder: 2),
                      Answer(id: 'id-star3', text: '3', displayOrder: 3),
                      Answer(id: 'id-star4', text: '4', displayOrder: 4),
                    ],
                  ),
                  Question(
                    id: 'id2',
                    text: 'text2',
                    displayOrder: 2,
                    imageUrl: 'imageUrl2',
                    coverImageUrl: 'coverImageUrl2',
                    displayType: DisplayType.outro,
                    answers: [],
                  ),
                ],
              )));
      final mockException = MockUseCaseException();

      when(getCurrentSurveySubmissionUseCase.call())
          .thenAnswer((_) async => Success(SurveySubmission(
                surveyId: '111',
                questions: [
                  SurveySubmissionQuestion(
                    id: 'id1',
                    answers: [
                      SurveySubmissionAnswer(id: 'id-star0', answer: null),
                    ],
                  )
                ],
              )));
      when(mockException.actualException)
          .thenReturn(const NetworkExceptions.unauthorisedRequest());
      when(submitSurveyAnswerUseCase.call(any))
          .thenAnswer((_) async => Failed(mockException));
      when(storeCurrentSurveySubmissionUseCase.call(any))
          .thenAnswer((_) async => Success(true));
      container.read(questionViewModelProvider.notifier).setUpData(arguments: {
        'surveyId': '111',
        'questionNumber': '0',
      });
      final stateStream =
          container.read(questionViewModelProvider.notifier).stream;
      const uiModel = ContainerUIModel(
        question: QuestionContainerUiModel(
          questionIndex: 1,
          totalQuestions: 2,
          title: 'text1',
        ),
        answer: AnswerContainerUIModel(
          displayType: DisplayType.star,
          options: [
            OptionUiModel(index: 0, id: 'id-star0', title: '0'),
            OptionUiModel(index: 1, id: 'id-star1', title: '1'),
            OptionUiModel(index: 2, id: 'id-star2', title: '2'),
            OptionUiModel(index: 3, id: 'id-star3', title: '3'),
            OptionUiModel(index: 4, id: 'id-star4', title: '4'),
          ],
        ),
      );
      expect(
        stateStream,
        emitsInOrder(
          [
            const QuestionContainerState.success(uiModel: uiModel),
            const QuestionContainerState.submitting(uiModel: uiModel),
            QuestionContainerState.error(
                uiModel: uiModel,
                error: NetworkExceptions.getErrorMessage(
                  const NetworkExceptions.unauthorisedRequest(),
                )),
          ],
        ),
      );

      container.read(questionViewModelProvider.notifier).submitAnswers();
    });
  });
}
