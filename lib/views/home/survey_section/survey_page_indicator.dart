import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SurveyPageIndicator extends StatelessWidget {
  final PageController controller;
  final int count;

  const SurveyPageIndicator({
    super.key,
    required this.controller,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SmoothPageIndicator(
        controller: controller,
        count: count,
        effect: const ScrollingDotsEffect(
          dotWidth: 8,
          dotHeight: 8,
          radius: 8,
          spacing: 10,
          dotColor: Colors.white30,
          activeDotColor: Colors.white,
        ),
      ),
    );
  }
}
