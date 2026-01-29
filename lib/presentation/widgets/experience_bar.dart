import 'package:flutter/material.dart';

class ExperienceBar extends StatelessWidget {
  const ExperienceBar({super.key, required this.progress});

  // 0.0 -> 1.0
  final double progress;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: LinearProgressIndicator(value: progress, minHeight: 12),
    );
  }
}

class AnimatedExperienceBar extends StatelessWidget {
  const AnimatedExperienceBar({super.key, required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: progress),
      duration: const Duration(milliseconds: 250),
      builder: (context, value, _) {
        return ExperienceBar(progress: value);
      },
    );
  }
}
