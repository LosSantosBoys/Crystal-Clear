import 'dart:async';

import 'package:crystalclear/features/achievements/widgets/shimmer_painter.dart';
import 'package:flutter/material.dart';

class ShimmerAnimator extends StatefulWidget {
  const ShimmerAnimator({
    super.key,
    required this.color,
    required this.duration,
    required this.interval,
    required this.child,
  });

  final Color color;
  final Duration duration;
  final Duration interval;
  final Widget child;

  @override
  State<ShimmerAnimator> createState() => _ShimmerAnimatorState();
}

class _ShimmerAnimatorState extends State<ShimmerAnimator> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.6, curve: Curves.decelerate),
      ),
    );

    animation.addListener(() async {
      if (controller.isCompleted) {
        timer = Timer(widget.interval, () => mounted ? controller.forward(from: 0) : null);
      }

      setState(() {});
    });
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: ShimmerPainter(
        context: context,
        color: widget.color,
        position: animation.value,
        opacity: 1,
      ),
      child: widget.child,
    );
  }
}
