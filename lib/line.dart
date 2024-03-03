import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  final Offset circle1Center;
  final Offset circle2Center;
  final Color color;

  LinePainter({
    required this.circle1Center,
    required this.circle2Center,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(circle1Center, circle2Center, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
