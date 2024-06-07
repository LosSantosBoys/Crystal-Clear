import 'package:flutter/material.dart';

class ShimmerPainter extends CustomPainter {
  ShimmerPainter({
    required this.context,
    required this.position,
    required this.opacity,
    required this.color,
  });

  final BuildContext context;
  double position;
  double opacity;
  double width = 0.05;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    List<double> stops = [
      0,
      position,
      (position + width) > 1 ? 1 : position + width,
      (position + (width * 2)) > 1 ? 1 : position + (width * 2),
      1
    ];
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = LinearGradient(
        tileMode: TileMode.decal,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: stops,
        colors: [
          Colors.transparent,
          (color).withOpacity(0.05),
          (color).withOpacity(opacity),
          (color).withOpacity(0.05),
          Colors.transparent,
        ],
      ).createShader(
        Rect.fromLTRB(
          size.width * -0.5,
          (size.height > size.width) ? 0 : size.height * -0.5,
          size.width * 1.5,
          size.height * 1.5,
        ),
      );

      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
      path.close();
      canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate)  => true;
}
