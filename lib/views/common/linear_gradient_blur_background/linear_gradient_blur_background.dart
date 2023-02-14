import 'dart:ui';

import 'package:flutter/material.dart';

class LinearGradientBlurBackground extends StatelessWidget {
  final Widget image;
  final AlignmentGeometry begin;
  final AlignmentGeometry end;
  final List<Color> colors;

  const LinearGradientBlurBackground({
    super.key,
    required this.image,
    required this.begin,
    required this.end,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        image,
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: ShaderMask(
            shaderCallback: (rectangle) {
              return LinearGradient(
                begin: begin,
                end: end,
                colors: colors,
              ).createShader(rectangle);
            },
            blendMode: BlendMode.overlay,
            child: image,
          ),
        ),
      ],
    );
  }
}
