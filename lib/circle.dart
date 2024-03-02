import 'package:cuckoosearchtsp/circle_painter.dart';
import 'package:flutter/material.dart';

class MyCircle extends StatefulWidget {
  const MyCircle({super.key, required this.color, required this.getXY});
  final Color color;
  final Function(double, double) getXY;

  @override
  State<MyCircle> createState() => _MyCircleState();
}

class _MyCircleState extends State<MyCircle> {
  late double xPosition;
  late double yPosition;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getPosition();
    });
  }

  void _getPosition() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset(7, 7),
        ancestor: context
            .findRenderObject()
            ?.parent
            ?.parent
            ?.parent
            ?.parent
            ?.parent as RenderObject);
    setState(() {
      xPosition = position.dx;
      yPosition = position.dy;
      widget.getXY(xPosition, yPosition);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(15, 15),
      painter: CirclePainter(
        widget.color,
      ),
    );
  }
}
