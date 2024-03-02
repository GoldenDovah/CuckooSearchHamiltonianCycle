import 'package:flutter/material.dart';

class CirclePainter extends CustomPainter {
  final Color circleColor;

  CirclePainter(this.circleColor);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final paint = Paint()
      ..color = circleColor
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return circleColor != oldDelegate.circleColor;
  }
}
