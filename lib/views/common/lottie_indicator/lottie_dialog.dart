import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kayla_flutter_ic/utils/durations.dart';
import 'package:lottie/lottie.dart';

class LottieDialog extends StatefulWidget {
  final Function() onAnimated;

  const LottieDialog({
    super.key,
    required this.onAnimated,
  });

  @override
  State<LottieDialog> createState() => _LottieDialogState();
}

class _LottieDialogState extends State<LottieDialog>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Durations.twoSecond,
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      insetPadding: const EdgeInsets.all(0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/json/lottie.json',
              controller: _controller,
              onLoaded: (composition) {
                _controller.duration = composition.duration;
                _controller.forward().then(
                      (_) => widget.onAnimated(),
                    );
              },
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)?.surveyDetailThanks ?? '',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ],
        ),
      ),
    );
  }
}
