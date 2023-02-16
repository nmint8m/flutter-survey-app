enum RoutePath {
  login('/'),
  forgetPassword('forget-password'),
  home('/home');

  const RoutePath(this.path);
  final String path;

  String get screen {
    switch (this) {
      case RoutePath.login:
        return path;
      case RoutePath.home:
        return path;
      case RoutePath.forgetPassword:
        return '/$path';
    }
  }
}
