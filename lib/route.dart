import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CityRoute {
  static String city_departure = "";
  static List<String> cities_selected = [];
  static List<List<String>> cities_edges = [];
  static List<String> route_taken = [];
  static bool cycle_available = true;
  static String clickedCity = "";

  static final Paint paint = Paint()
    ..color = Colors.black
    ..strokeWidth = 2
    ..strokeCap = StrokeCap.round;

  static Future<void> testAPI() async {
    final url = Uri.parse('http://localhost:8080/test');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print('Response: ${response.body}');
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  static Future<void> sendGraph(
    double populationSize,
    double maxIterations,
    double replacementProbability,
  ) async {
    final url = Uri.parse('http://localhost:8080/getPath');
    final Map<String, dynamic> postData = {
      'nodes': cities_selected,
      'edges': cities_edges,
      'departing_node': city_departure,
      'pop_size': populationSize,
      'max_iter': maxIterations,
      'prob': replacementProbability,
    };
    print(postData);
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(postData),
      );

      if (response.statusCode == 200) {
        print("*********************** ${response.body}");
        List<dynamic> parsedList = jsonDecode(response.body);
        route_taken = parsedList.map((e) => e.toString()).toList();
        print(route_taken);
        if (route_taken.length == 0) {
          cycle_available = false;
        } else {
          cycle_available = true;
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
      print('Exception: $e');
    }
  }
}
