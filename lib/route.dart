import 'package:flutter/material.dart';

class CityRoute {
  static String city_departure = "";
  static List<String> cities_selected = [];
  static List<List<String>> cities_edges = [];
  static List<String> route_taken = ['Nador', 'Agadir', 'Oujda', 'Nador'];
  static String clickedCity = "";

  static final Paint paint = Paint()
    ..color = Colors.black
    ..strokeWidth = 2
    ..strokeCap = StrokeCap.round;

  static Future<void> sendGraph(
    double populationSize,
    double maxIterations,
    double replacementProbability,
  ) async {}
}
