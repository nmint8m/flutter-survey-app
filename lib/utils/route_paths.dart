enum RoutePath {
  login('/login'),
  home('/'),
  forgetPassword('/forget-password'),
  surveyDetail('/surveys');

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
      default:
        return '';
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
    }
  }

  String get screenWithPathParams {
    return pathParam.isEmpty ? screen : '$screen/:$pathParam';
  }
}
