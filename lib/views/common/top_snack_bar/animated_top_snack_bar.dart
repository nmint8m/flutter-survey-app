
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kayla_flutter_ic/utils/durations.dart';

class AnimatedTopSnackBar extends StatefulWidget {
  final Widget child;

  const AnimatedTopSnackBar({
    super.key,
    required this.child,
  });

  @override
  AnimatedTopSnackBarState createState() => AnimatedTopSnackBarState();
}

class AnimatedTopSnackBarState extends State<AnimatedTopSnackBar>
    with SingleTickerProviderStateMixin {
  Timer? _timer;
  late final Animation<Offset> _animation;
  late final AnimationController _animationController;
  final _offsetTween = Tween(begin: const Offset(0, -1), end: Offset.zero);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Durations.oneSecond,
      reverseDuration: Durations.halfSecond,
    );
    _animationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _timer = Timer(Durations.threeSecond, () {
            if (mounted) {
              _animationController.reverse();
            }
          });
        }
        if (status == AnimationStatus.dismissed) {
          _timer?.cancel();
        }
      },
    );
    _animation = _offsetTween.animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linearToEaseOut,
        reverseCurve: Curves.linearToEaseOut,
      ),
    );
    if (mounted) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SlideTransition(
        position: _animation,
        child: SafeArea(
          top: false,
          bottom: false,
          left: false,
          right: false,
          child: widget.child,
        ),
      ),
    );
  }
}
