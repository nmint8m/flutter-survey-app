import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kayla_flutter_ic/di/di.dart';
import 'package:kayla_flutter_ic/gen/assets.gen.dart';
import 'package:kayla_flutter_ic/usecases/oath/login_use_case.dart';
import 'package:kayla_flutter_ic/utils/build_context_ext.dart';
import 'package:kayla_flutter_ic/utils/durations.dart';
import 'package:kayla_flutter_ic/utils/route_paths.dart';
import 'package:kayla_flutter_ic/views/common/linear_gradient_blur_background/linear_gradient_blur_background.dart';
import 'package:kayla_flutter_ic/views/login/login_form.dart';
import 'package:kayla_flutter_ic/views/login/login_state.dart';
import 'package:kayla_flutter_ic/views/login/login_view_model.dart';

final loginViewModelProvider =
    StateNotifierProvider.autoDispose<LoginViewModel, LoginState>(
  (_) => LoginViewModel(getIt.get<LoginUseCase>()),
);

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends ConsumerState<LoginView>
    with TickerProviderStateMixin {
  late AnimationController _logoAnimationController;
  late Animation<double> _logoAnimation;
  bool _isLogoAnimated = false;

  late AnimationController _backgroundAnimationController;
  late Animation<double> _backgroundAnimation;

  late AnimationController _formAnimationController;
  late Animation<double> _formAnimation;

  SizedBox get _background => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            _backgroundImage,
            _animatedBackground,
          ],
        ),
      );

  Image get _backgroundImage => Image(
        image: Assets.images.nimbleBackground.image().image,
        fit: BoxFit.cover,
        alignment: Alignment.center,
      );

  FadeTransition get _animatedBackground => FadeTransition(
        opacity: _backgroundAnimation,
        child: _linearGradientBlurBackground,
      );

  Widget get _linearGradientBlurBackground => LinearGradientBlurBackground(
          image: _backgroundImage,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.2),
            Colors.black.withOpacity(1),
          ]);

  AnimatedPositioned get _animatedLogo => AnimatedPositioned(
        duration: Durations.oneSecond,
        curve: Curves.linear,
        top: _isLogoAnimated ? -450 : 0,
        bottom: 0.0,
        left: 0.0,
        right: 0.0,
        child: FadeTransition(
          opacity: _logoAnimation,
          child: Container(
            padding: const EdgeInsets.all(100),
            child: _logo,
          ),
        ),
      );

  Image get _logo => Image(
        image: Assets.images.nimbleLogoWhite.image().image,
        fit: BoxFit.scaleDown,
      );

  FadeTransition get _animatedLoginForm => FadeTransition(
        opacity: _formAnimation,
        child: const LoginForm(),
      );

  @override
  void initState() {
    super.initState();
    _setupLogoAnimation();
    _setupBackgroundAnimation();
    _setupFormAnimation();
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _backgroundAnimationController.dispose();
    _formAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _setupStateListener();
    return _defaultLoginView();
  }

  Widget _defaultLoginView() {
    return Stack(
      children: [
        _background,
        _animatedLogo,
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
              child: _animatedLoginForm,
            ),
          ),
        ),
      ],
    );
  }

  void _setupLogoAnimation() {
    _logoAnimationController = AnimationController(
      vsync: this,
      duration: Durations.oneSecond,
    )..forward();
    _logoAnimation = CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.easeIn,
    )..addStatusListener(
        (status) {
          if (status != AnimationStatus.completed) {
            return;
          }
          setState(() {
            _isLogoAnimated = true;
          });
          _backgroundAnimationController.forward();
        },
      );
  }

  void _setupBackgroundAnimation() {
    _backgroundAnimationController = AnimationController(
      vsync: this,
      duration: Durations.oneSecond,
    );
    _backgroundAnimation = CurvedAnimation(
      parent: _backgroundAnimationController,
      curve: Curves.easeIn,
    )..addStatusListener((status) {
        if (status != AnimationStatus.completed) {
          return;
        }
        setState(() {
          _formAnimationController.forward();
        });
      });
  }

  void _setupFormAnimation() {
    _formAnimationController = AnimationController(
      vsync: this,
      duration: Durations.oneSecond,
    );
    _formAnimation = CurvedAnimation(
      parent: _formAnimationController,
      curve: Curves.easeIn,
    );
  }

  void _setupStateListener() {
    ref.listen<LoginState>(loginViewModelProvider, (_, state) {
      context.showOrHideLoadingIndicator(
        shouldShow: state == const LoginState.loading(),
      );
      state.maybeWhen(
        error: (error) {
          context.showSnackBar(message: 'Please try again. $error.');
        },
        success: () async {
          context.pushReplacement(RoutePath.home.screen);
        },
        orElse: () {},
      );
    });
  }
}
