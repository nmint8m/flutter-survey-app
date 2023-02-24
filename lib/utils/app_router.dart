import 'package:go_router/go_router.dart';
import 'package:kayla_flutter_ic/api/storage/secure_storage.dart';
import 'package:kayla_flutter_ic/utils/route_paths.dart';
import 'package:kayla_flutter_ic/views/forget_password/forget_password_view.dart';
import 'package:kayla_flutter_ic/views/home/home_view.dart';
import 'package:kayla_flutter_ic/views/login/login_view.dart';
import 'package:kayla_flutter_ic/views/survey_detail/survey_detail_view.dart';

class AppRouter {
  final SecureStorage _secureStorage;

  AppRouter(this._secureStorage);

  GoRouter get router => GoRouter(
        initialLocation: RoutePath.home.path,
        routes: <GoRoute>[
          GoRoute(
            path: RoutePath.home.screen,
            name: RoutePath.home.name,
            builder: (context, state) => const HomeView(),
            routes: [
              GoRoute(
                path: RoutePath.surveyDetail.screenWithPathParams,
                name: RoutePath.surveyDetail.name,
                builder: (context, state) => SurveyDetailView(
                  surveyId:
                      state.params[RoutePath.surveyDetail.pathParam] ?? '',
                ),
              ),
              GoRoute(
                path: RoutePath.forgetPassword.screen,
                name: RoutePath.forgetPassword.name,
                builder: (context, state) => const ForgetPasswordView(),
              ),
            ],
          ),
          GoRoute(
            path: RoutePath.login.screen,
            name: RoutePath.login.name,
            builder: (context, state) => const LoginView(),
          ),
        ],
        redirect: (context, state) async {
          final subLocation = state.subloc;
          final isLogin = await _secureStorage.id != null;
          if (!isLogin &&
              subLocation != RoutePath.forgetPassword.path &&
              subLocation != RoutePath.login.path) {
            return RoutePath.login.path;
          }
          return null;
        },
      );
}
