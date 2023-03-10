import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kayla_flutter_ic/di/di.dart';
import 'package:kayla_flutter_ic/gen/assets.gen.dart';
import 'package:kayla_flutter_ic/usecases/oath/forget_password_use_case.dart';
import 'package:kayla_flutter_ic/utils/route_paths.dart';
import 'package:kayla_flutter_ic/views/common/linear_gradient_blur_background/linear_gradient_blur_background.dart';
import 'package:kayla_flutter_ic/utils/app_bar_ext.dart';
import 'package:kayla_flutter_ic/utils/build_context_ext.dart';
import 'package:kayla_flutter_ic/views/common/top_snack_bar/top_snack_bar.dart';
import 'package:kayla_flutter_ic/views/forget_password/forget_password_form.dart';
import 'package:kayla_flutter_ic/views/forget_password/forget_password_state.dart';
import 'package:kayla_flutter_ic/views/forget_password/forget_password_view_model.dart';

final forgetPasswordViewModelProvider = StateNotifierProvider.autoDispose<
    ForgetPasswordViewModel, ForgetPasswordState>(
  (_) => ForgetPasswordViewModel(getIt.get<ForgetPasswordUseCase>()),
);

class ForgetPasswordView extends ConsumerStatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  ForgetPasswordViewState createState() => ForgetPasswordViewState();
}

class ForgetPasswordViewState extends ConsumerState<ForgetPasswordView>
    with TickerProviderStateMixin {
  AppBar get _appBar => AppBarExt.appBarWithBackButton(
        context: context,
        onPressed: () => context.goNamed(RoutePath.login.name),
      );

  Widget get _background => SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            _backgroundImage,
            _linearGradientBlurBackground,
          ],
        ),
      );

  Widget get _backgroundImage => Image(
        image: Assets.images.nimbleBackground.image().image,
        fit: BoxFit.cover,
        alignment: Alignment.center,
      );

  Widget get _linearGradientBlurBackground => LinearGradientBlurBackground(
          image: _backgroundImage,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.2),
            Colors.black.withOpacity(1),
          ]);

  Widget get _logo => SizedBox(
        width: 166,
        height: 40,
        child: FittedBox(
          fit: BoxFit.contain,
          child: Image(
            image: Assets.images.nimbleLogoWhite.image().image,
            fit: BoxFit.scaleDown,
          ),
        ),
      );

  Widget _instruction(BuildContext context) => Text(
        AppLocalizations.of(context)?.resetPasswordInstruction ?? '',
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Colors.white70),
        textAlign: TextAlign.center,
      );

  Widget get _form => const ForgetPasswordForm();

  @override
  Widget build(BuildContext context) {
    _setupStateListener();
    return _defaultForgetPasswordView();
  }

  Widget _defaultForgetPasswordView() {
    return Stack(
      children: [
        _background,
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _appBar,
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  _logo,
                  const SizedBox(height: 20),
                  _instruction(context),
                  const SizedBox(height: 100),
                  _form,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _setupStateListener() {
    ref.listen<ForgetPasswordState>(forgetPasswordViewModelProvider,
        (_, state) {
      context.showOrHideLoadingIndicator(
        shouldShow: state == const ForgetPasswordState.loading(),
      );
      state.maybeWhen(
        error: (error) {
          context.showSnackBar(
              message: AppLocalizations.of(context)
                      ?.resetPasswordError(error ?? '') ??
                  '');
        },
        success: (message) async {
          context.showTopSnackBar(TopSnackBar(
            title: AppLocalizations.of(context)?.resetPasswordCheckEmail ?? '',
            message: message,
          ));
        },
        orElse: () {},
      );
    });
  }
}
