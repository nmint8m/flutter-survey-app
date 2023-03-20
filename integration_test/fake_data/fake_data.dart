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
const String keySurvey = 'KEY_SURVEY';
const String keySubmitSurvey = 'KEY_SUBMIT_SURVEY';
const String keyUser = 'KEY_USER';

class FakeData {
  FakeData._();

  static final Map<String, FakeResponseModel> _apiAndResponse = {};
  static Map<String, FakeResponseModel> get apiAndResponse => _apiAndResponse;

  static Future<void> initDefault() async {
    _apiAndResponse.addAll({
      keyLogin: FakeResponseModel(
        200,
        await FileUtil.loadFile('integration_test/fake_data/oauth_login.json'),
      ),
      keyRefreshToken: FakeResponseModel(
        200,
        await FileUtil.loadFile(
            'integration_test/fake_data/refresh_token.json'),
      ),
      keyForgetPassword: FakeResponseModel(
        200,
        await FileUtil.loadFile(
            'integration_test/fake_data/forget_password.json'),
      ),
      keySurveys: const FakeResponseModel(
        200,
        {},
      ),
      keySurvey: const FakeResponseModel(
        200,
        {},
      ),
      keyUser: const FakeResponseModel(
        200,
        {},
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
