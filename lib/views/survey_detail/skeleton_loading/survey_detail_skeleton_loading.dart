import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:kayla_flutter_ic/views/common/skeleton_loading/skeleton_placeholder.dart';

class SurveyDetailSkeletonLoading extends StatelessWidget {
  const SurveyDetailSkeletonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white38,
      highlightColor: Colors.white70,
      child: _buildSkeleton(context),
    );
  }

  Widget _buildSkeleton(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(height: 16.0),
          const TextPlaceholder(
            type: TextPlaceholderType.oneLine,
            width: 40,
          ),
          const SizedBox(height: 16.0),
          TextPlaceholder(
              type: TextPlaceholderType.twoLines,
              width: MediaQuery.of(context).size.width - 150),
          const SizedBox(height: 16.0),
          TextPlaceholder(
              type: TextPlaceholderType.twoLines,
              width: MediaQuery.of(context).size.width - 40),
        ],
      );
}
