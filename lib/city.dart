import 'package:cuckoosearchtsp/circle.dart';
import 'package:flutter/material.dart';

class City extends StatefulWidget {
  const City({
    super.key,
    required this.name,
    required this.side,
  });
  final String name;
  final String side;

  @override
  State<City> createState() => _CityState();
}

class _CityState extends State<City> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.side == 'Left') Text(widget.name),
        if (widget.side == 'Left')
          SizedBox(
            width: 5,
          ),
        CustomPaint(
          size: Size(15, 15),
          painter: CirclePainterCustom(),
        ),
        if (widget.side == 'Right')
          SizedBox(
            width: 5,
          ),
        if (widget.side == 'Right') Text(widget.name),
      ],
    );
  }
}
