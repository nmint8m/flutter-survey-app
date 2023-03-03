enum RoutePath {
  login('/login'),
  home('/'),
  forgetPassword('/forget-password'),
  surveyDetail('/surveys'),
  question('/questions');

  const RoutePath(this.path);
  final String path;

  String get screen {
    switch (this) {
      case RoutePath.home:
      case RoutePath.login:
      case RoutePath.forgetPassword:
        return path;
      default:
        return path.replaceRange(0, 1, '');
    }
  }

  String get pathParam {
    switch (this) {
      case RoutePath.surveyDetail:
        return 'surveyId';
      case RoutePath.question:
        return 'surveyId';
      default:
        return '';
    }
  }

  List<String> get queryParams {
    switch (this) {
      case RoutePath.question:
        return ['questionNumber'];
      default:
        return [''];
    }
  }

  String get name {
    switch (this) {
      case RoutePath.login:
        return "LOGIN";
      case RoutePath.home:
        return "HOME";
      case RoutePath.forgetPassword:
        return "FORGET_PASSWORD";
      case RoutePath.surveyDetail:
        return "SURVEY_DETAIL";
      case RoutePath.question:
        return "QUESTION";
    }
  }

  String get screenWithPathParams {
    return pathParam.isEmpty ? screen : '$screen/:$pathParam';
  }

  String screenWithQueryParams(Map<String, String> queries) {
    if (queries.isEmpty) {
      return screenWithPathParams;
    }
    String queriesText = '';
    queries.forEach((key, value) {
      queriesText += '$key=$value&&';
    });
    queriesText.replaceRange(
      queriesText.length - 2,
      queriesText.length,
      '',
    );
    return pathParam.isEmpty ? screen : '$screen?$queriesText';
  }
}
