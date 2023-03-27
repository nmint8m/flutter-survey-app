import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:kayla_flutter_ic/utils/file_util.dart';

class FakeResponseModel extends Equatable {
  final int statusCode;
  final Map<String, dynamic> json;

  const FakeResponseModel(
    this.statusCode,
    this.json,
  );

  @override
  List<Object?> get props => [
        statusCode,
        json,
      ];
}

const String keyLogin = 'KEY_LOGIN';
const String keyRefreshToken = 'KEY_REFRESH_TOKEN';
const String keyForgetPassword = 'KEY_FORGET_PASSWORD';
const String keySurveys = 'KEY_SURVEYS';
const String keySurveyDetail = 'KEY_SURVEY_DETAIL';
const String keySubmitSurvey = 'KEY_SUBMIT_SURVEY';
const String keyMyProfile = 'KEY_MY_PROFILE';

class FakeData {
  FakeData._();

  static final Map<String, FakeResponseModel> _apiAndResponse = {};
  static Map<String, FakeResponseModel> get apiAndResponse => _apiAndResponse;

  static Future<void> initDefault() async {
    _apiAndResponse.addAll({
      keyLogin: FakeResponseModel(
        200,
        await FileUtil.loadFile('integration_test_fake_data/oauth_login.json'),
      ),
      keyRefreshToken: FakeResponseModel(
        200,
        await FileUtil.loadFile(
            'integration_test_fake_data/refresh_token.json'),
      ),
      keyForgetPassword: FakeResponseModel(
        200,
        await FileUtil.loadFile(
            'integration_test_fake_data/forget_password.json'),
      ),
      keySurveys: FakeResponseModel(
        200,
        await FileUtil.loadFile('integration_test_fake_data/surveys.json'),
      ),
      keySurveyDetail: FakeResponseModel(
        200,
        await FileUtil.loadFile(
            'integration_test_fake_data/survey_detail.json'),
      ),
      keyMyProfile: FakeResponseModel(
        200,
        await FileUtil.loadFile('integration_test_fake_data/me.json'),
      ),
      keySubmitSurvey: const FakeResponseModel(
        200,
        {},
      ),
    });
  }

  static void updateResponse(String key, FakeResponseModel newValue) {
    _apiAndResponse.update(
      key,
      (value) => newValue,
      ifAbsent: () => newValue,
    );
  }
}

DioError generateDioError(int statusCode) {
  return DioError(
    response: Response(
      statusCode: statusCode,
      requestOptions: RequestOptions(path: ''),
    ),
    type: DioErrorType.response,
    requestOptions: RequestOptions(path: ''),
  );
}
