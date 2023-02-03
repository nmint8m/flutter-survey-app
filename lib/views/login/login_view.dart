import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:kayla_flutter_ic/gen/assets.gen.dart';
import 'package:kayla_flutter_ic/utils/durations.dart';
import 'package:kayla_flutter_ic/views/login/login_form.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with TickerProviderStateMixin {
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

  Stack get _linearGradientBlurBackground => Stack(
        children: [
          _backgroundImage,
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: ShaderMask(
              shaderCallback: (rectangle) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(1),
                  ],
                ).createShader(rectangle);
              },
              blendMode: BlendMode.overlay,
              child: _backgroundImage,
            ),
          ),
        ],
      );

  AnimatedPositioned get _animatedLogo => AnimatedPositioned(
        duration: Durations.oneSecond,
        curve: Curves.linear,
        top: _isLogoAnimated ? -450 : 0.0,
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
        child: LoginForm(),
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
    return Stack(
      children: [
        _background,
        _animatedLogo,
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Container(
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
}