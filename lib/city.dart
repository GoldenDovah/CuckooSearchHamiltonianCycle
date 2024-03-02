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
    required this.getXY,
  });
  final String name;
  final String side;
  final Function(double, double) getXY;

  @override
  State<City> createState() => _CityState();
}

class _CityState extends State<City> {
  Color _color = Colors.blue;
  bool _cityDeparture = false;
  bool _routeMode = false;
  late double xPosition;
  late double yPosition;

  @override
  void initState() {
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
                CityRoute.cities_route.add(widget.name);
              } else if (CityRoute.city_departure == widget.name) {
                CityRoute.city_departure = "";
                setState(() {
                  _color = Colors.blue;
                  _cityDeparture = false;
                });
                CityRoute.cities_route.remove(widget.name);
              } else if (CityRoute.cities_route.contains(widget.name)) {
                setState(() {
                  _color = Colors.blue;
                });
                CityRoute.cities_route.remove(widget.name);
              } else {
                setState(() {
                  _color = Colors.orange;
                });
                CityRoute.cities_route.add(widget.name);
              }
            } else {
              widget.getXY(xPosition, yPosition);
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
