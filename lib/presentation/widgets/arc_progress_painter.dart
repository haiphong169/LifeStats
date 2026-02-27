import 'package:flutter/material.dart';

class ArcProgressPainter extends CustomPainter {
  final double progress;

  ArcProgressPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final backgroundPaint =
        Paint()
          ..color = const Color(0xFF2A2A2E)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 12
          ..strokeCap = StrokeCap.round;

    final progressPaint =
        Paint()
          ..color = const Color(0xFFD6C86F)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 12
          ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.14,
      3.14,
      false,
      backgroundPaint,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.14,
      3.14 * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant ArcProgressPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
