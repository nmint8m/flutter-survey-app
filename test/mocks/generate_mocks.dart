import 'package:dio/dio.dart';
import 'package:kayla_flutter_ic/api/api_service.dart';
import 'package:kayla_flutter_ic/api/oauth_service.dart';
import 'package:kayla_flutter_ic/api/repository/oauth_repository.dart';
import 'package:kayla_flutter_ic/api/repository/survey_repository.dart';
import 'package:kayla_flutter_ic/api/repository/user_repository.dart';
import 'package:kayla_flutter_ic/api/storage/secure_storage.dart';
import 'package:kayla_flutter_ic/usecases/base/base_use_case.dart';
import 'package:kayla_flutter_ic/usecases/oath/login_use_case.dart';
import 'package:kayla_flutter_ic/usecases/oath/logout_use_case.dart';
import 'package:kayla_flutter_ic/usecases/survey/get_current_survey_detail_use_case.dart';
import 'package:kayla_flutter_ic/usecases/survey/get_current_survey_submission_use_case.dart';
import 'package:kayla_flutter_ic/usecases/survey/get_survey_detail_use_case.dart';
import 'package:kayla_flutter_ic/usecases/survey/get_surveys_use_case.dart';
import 'package:kayla_flutter_ic/usecases/survey/store_current_survey_detail_use_case.dart';
import 'package:kayla_flutter_ic/usecases/survey/store_current_survey_submission_use_case.dart';
import 'package:kayla_flutter_ic/usecases/survey/submit_survey_answer_use_case.dart';
import 'package:kayla_flutter_ic/usecases/user/get_profile_use_case.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  ApiService,
  OAuthService,
  OAuthRepository,
  UserRepository,
  SurveyRepository,
  SecureStorage,
  UseCaseException,
  LoginUseCase,
  LogoutUseCase,
  GetProfileUseCase,
  GetSurveysUseCase,
  GetCurrentSurveyDetailUseCase,
  GetCurrentSurveySubmissionUseCase,
  GetSurveyDetailUseCase,
  StoreCurrentSurveyDetailUseCase,
  StoreCurrentSurveySubmissionUseCase,
  SubmitSurveyAnswerUseCase,
  DioError,
])
main() {
  // empty class to generate mock repository classes
}
