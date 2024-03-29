import 'package:cuckoosearchtsp/circle.dart';
import 'package:cuckoosearchtsp/circle_painter.dart';
import 'package:cuckoosearchtsp/line.dart';
import 'package:cuckoosearchtsp/route.dart';
import 'package:flutter/material.dart';

class City extends StatefulWidget {
  const City({
    super.key,
    required this.name,
    required this.side,
    required this.routingMode,
    required this.getXY,
    required this.resetColors,
  });
  final String name;
  final String side;
  final bool routingMode;
  final Function(double, double) getXY;
  final Function resetColors;

  @override
  State<City> createState() => _CityState();
}

class _CityState extends State<City> {
  late Color _color = Colors.blue;
  bool _cityDeparture = false;
  late bool _routeMode;
  late double xPosition;
  late double yPosition;

  @override
  void initState() {
    _routeMode = widget.routingMode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.side == 'Left') Text(widget.name),
        if (widget.side == 'Left')
          const SizedBox(
            width: 5,
          ),
        GestureDetector(
          onTap: () {
            if (_routeMode) {
              if (CityRoute.city_departure.isEmpty) {
                CityRoute.city_departure = widget.name;
                setState(() {
                  _color = Colors.red;
                  _cityDeparture = true;
                });
              } else if (CityRoute.city_departure == widget.name) {
                CityRoute.city_departure = "";
                setState(() {
                  _color = Colors.blue;
                  _cityDeparture = false;
                });
              }
            } else {
              widget.getXY(xPosition, yPosition);
              if (CityRoute.clickedCity != widget.name &&
                  !CityRoute.clickedCity.isEmpty) {
                CityRoute.clickedCity = "";
                widget.resetColors();
              } else if (CityRoute.clickedCity.isEmpty) {
                CityRoute.clickedCity = widget.name;
                setState(() {
                  _color = Colors.red;
                });
              }
            }
          },
          child: Stack(
            children: [
              MyCircle(
                color: _color,
                getXY: (p0, p1) {
                  xPosition = p0;
                  yPosition = p1;
                },
              ),
              if (_cityDeparture)
                Transform.translate(
                    offset: const Offset(0, -15),
                    child: const Icon(
                      Icons.flag,
                      color: Colors.green,
                    )),
            ],
          ),
        ),
        if (widget.side == 'Right')
          const SizedBox(
            width: 5,
          ),
        if (widget.side == 'Right') Text(widget.name),
      ],
    );
  }
}
