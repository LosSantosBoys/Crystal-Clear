import 'package:crystalclear/features/achievements/widgets/shimmer_animator.dart';
import 'package:flutter/material.dart';

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({
    super.key,
    required this.child,
    required this.color,
    this.duration = const Duration(milliseconds: 2000),
    this.interval = const Duration(milliseconds: 1000),
    this.enabled = true,
  });

  final Color color;
  final Widget child;
  final Duration duration;
  final Duration interval;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    if (!enabled) {
      return child;
    }

    return ShimmerAnimator(
      duration: duration,
      interval: interval,
      color: color,
      child: child,
    );
  }
}
