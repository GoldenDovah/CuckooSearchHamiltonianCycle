import 'dart:ui';

import 'package:cuckoosearchtsp/circle.dart';
import 'package:cuckoosearchtsp/circle_painter.dart';
import 'package:cuckoosearchtsp/city.dart';
import 'package:cuckoosearchtsp/line.dart';
import 'package:cuckoosearchtsp/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CuckooSearchHC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      scrollBehavior: MyCustomScrollBehavior(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> lines = [];
  List<List<double>> connectedCities = [];
  List<String> connectedCitiesNames = [];
  List<List<Offset>> cityOffsets = [];
  Map<String, Offset> citiesCoordinates = <String, Offset>{};
  bool _routingMode = false;
  String buttonText = "Set Departing City";
  double populationSize = 10;
  double maxIterations = 1000;
  double replacementProbability = 10;
  bool showSolution = false;
  bool _isLoading = false;
  List<Map<String, dynamic>> cities = [
    {'name': 'Tangier', 'side': 'Left', 'leftPadding': 430.0, 'topPadding': 3},
    {
      'name': 'Tetouan',
      'side': 'Right',
      'leftPadding': 515.0,
      'topPadding': 15
    },
    {'name': 'Nador', 'side': 'Right', 'leftPadding': 605.0, 'topPadding': 25},
    {'name': 'Oujda', 'side': 'Left', 'leftPadding': 595.0, 'topPadding': 60},
    {'name': 'Kenitra', 'side': 'Left', 'leftPadding': 380.0, 'topPadding': 90},
    {'name': 'Sale', 'side': 'Right', 'leftPadding': 415.0, 'topPadding': 105},
    {'name': 'Rabat', 'side': 'Left', 'leftPadding': 345.0, 'topPadding': 110},
    {'name': 'Fez', 'side': 'Left', 'leftPadding': 500.0, 'topPadding': 110},
    {'name': 'Taza', 'side': 'Right', 'leftPadding': 570.0, 'topPadding': 90},
    {'name': 'Meknes', 'side': 'Left', 'leftPadding': 440.0, 'topPadding': 125},
    {'name': 'Temara', 'side': 'Left', 'leftPadding': 325.0, 'topPadding': 125},
    {
      'name': 'Mohammedia',
      'side': 'Left',
      'leftPadding': 275.0,
      'topPadding': 140
    },
    {
      'name': 'Casablanca',
      'side': 'Left',
      'leftPadding': 275.0,
      'topPadding': 165
    },
    {
      'name': 'El Jadida',
      'side': 'Left',
      'leftPadding': 285.0,
      'topPadding': 190
    },
    {'name': 'Settat', 'side': 'Left', 'leftPadding': 370.0, 'topPadding': 195},
    {
      'name': 'Khouribga',
      'side': 'Right',
      'leftPadding': 440.0,
      'topPadding': 200
    },
    {
      'name': 'Marrakesh',
      'side': 'Right',
      'leftPadding': 390.0,
      'topPadding': 250
    },
    {'name': 'Agadir', 'side': 'Left', 'leftPadding': 280.0, 'topPadding': 280},
    {
      'name': 'Guelmim',
      'side': 'Left',
      'leftPadding': 240.0,
      'topPadding': 350
    },
    {
      'name': 'Laayoune',
      'side': 'Right',
      'leftPadding': 170.0,
      'topPadding': 410
    },
  ];

  List<Widget> cityWidgets = [];

  @override
  void initState() {
    createCityWidgets();
    super.initState();
  }

  void createCityWidgets() {
    for (var city in cities) {
      cityWidgets.add(
        Padding(
          padding: EdgeInsets.only(
              left: city['leftPadding'], top: city['topPadding']),
          child: City(
            name: city['name'],
            side: city['side'],
            routingMode: _routingMode,
            getXY: (x, y) {
              if (!(connectedCities.length == 1 &&
                  connectedCities[0][0] == x &&
                  connectedCities[0][1] == y)) {
                connectedCities.add([x, y]);
                connectedCitiesNames.add(city["name"]);
                if (!CityRoute.cities_selected.contains(city["name"])) {
                  CityRoute.cities_selected.add(city["name"]);
                }
                if (connectedCities.length == 2) {
                  bool edgeExists = false;
                  for (List<Offset> offsets in cityOffsets) {
                    if (offsets[0] ==
                            Offset(
                              connectedCities[0][0],
                              connectedCities[0][1],
                            ) &&
                        offsets[1] ==
                            Offset(
                              connectedCities[1][0],
                              connectedCities[1][1],
                            )) {
                      edgeExists = true;
                    }
                  }
                  if (!edgeExists) {
                    setState(() {
                      lines.add(CustomPaint(
                        size: const Size(300, 300),
                        painter: LinePainter(
                          color: Colors.black,
                          circle1Center: Offset(
                            connectedCities[0][0],
                            connectedCities[0][1],
                          ),
                          circle2Center: Offset(
                            connectedCities[1][0],
                            connectedCities[1][1],
                          ),
                        ),
                      ));
                    });
                    CityRoute.cities_edges.add(
                        [connectedCitiesNames[0], connectedCitiesNames[1]]);
                    citiesCoordinates[connectedCitiesNames[0]] = Offset(
                      connectedCities[0][0],
                      connectedCities[0][1],
                    );
                    citiesCoordinates[connectedCitiesNames[1]] = Offset(
                      connectedCities[1][0],
                      connectedCities[1][1],
                    );
                    cityOffsets.add(
                      [
                        Offset(
                          connectedCities[0][0],
                          connectedCities[0][1],
                        ),
                        Offset(
                          connectedCities[1][0],
                          connectedCities[1][1],
                        )
                      ],
                    );
                  }
                  connectedCities.clear();
                  connectedCitiesNames.clear();
                }
              }
            },
            resetColors: () async {
              setState(() {
                cityWidgets.clear();
              });
              await Future.delayed(const Duration(microseconds: 1));
              setState(() {
                createCityWidgets();
              });
            },
          ),
        ),
      );
    }
  }

  Future<void> drawRoutes() async {
    print(citiesCoordinates);
    for (var i = 0; i < CityRoute.route_taken.length - 1; i++) {
      await Future.delayed(const Duration(milliseconds: 1000));
      setState(() {
        lines.add(CustomPaint(
          size: const Size(300, 300),
          painter: LinePainter(
              color: Colors.red,
              circle1Center: citiesCoordinates[CityRoute.route_taken[i]]!,
              circle2Center: citiesCoordinates[CityRoute.route_taken[i + 1]]!),
        ));
      });
    }
  }

  Future<void> resetApp() async {
    CityRoute.cities_edges.clear();
    CityRoute.cities_selected.clear();
    CityRoute.city_departure = "";
    CityRoute.clickedCity = "";
    CityRoute.route_taken.clear();
    CityRoute.cycle_available = true;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (BuildContext context) => const MyHomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: CityRoute.cycle_available ? 1 : 0.25,
            child: AbsorbPointer(
              absorbing: !CityRoute.cycle_available,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 3,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 150,
                                child: Image.asset(
                                  "assets/logo.png",
                                ),
                              ),
                              const Text(
                                "CuckooCycleSolver",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 50.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(color: Colors.black),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          'Cuckoo Search Parameters',
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListTile(
                                          title: const Text('Population Size'),
                                          trailing: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            child: SpinBox(
                                              min: 1,
                                              max: 20,
                                              value: populationSize,
                                              onChanged: (value) =>
                                                  populationSize = value,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListTile(
                                          title: const Text('Max Iterations'),
                                          trailing: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            child: SpinBox(
                                              min: 1,
                                              max: 2000,
                                              value: maxIterations,
                                              onChanged: (value) =>
                                                  maxIterations = value,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ListTile(
                                          title: const Text(
                                              'Replacement Probability'),
                                          trailing: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            child: SpinBox(
                                              min: 1,
                                              max: 100,
                                              value: replacementProbability,
                                              onChanged: (value) =>
                                                  replacementProbability =
                                                      value,
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (_isLoading)
                                        const Padding(
                                          padding: EdgeInsets.only(
                                              left: 5.0, right: 5),
                                          child: LinearProgressIndicator(),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              if (!showSolution)
                                Padding(
                                  padding: const EdgeInsets.only(top: 50.0),
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        if (buttonText ==
                                            "Set Departing City") {
                                          setState(() {
                                            _routingMode = true;
                                            cityWidgets.clear();
                                          });
                                          await Future.delayed(
                                              const Duration(microseconds: 1));
                                          setState(() {
                                            createCityWidgets();
                                            buttonText = "Solve";
                                          });
                                        } else if (buttonText == "Solve") {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          //await CityRoute.testAPI();
                                          await CityRoute.sendGraph(
                                            populationSize,
                                            maxIterations,
                                            replacementProbability,
                                          );
                                          setState(() {
                                            cityWidgets.clear();
                                          });
                                          await Future.delayed(
                                              const Duration(microseconds: 1));
                                          setState(() {
                                            CityRoute.city_departure = "";
                                            _isLoading = false;
                                            //lines.clear();
                                            showSolution = true;
                                            createCityWidgets();
                                          });
                                          await drawRoutes();
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          buttonText,
                                          style: const TextStyle(fontSize: 25),
                                        ),
                                      )),
                                ),
                              if (showSolution)
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        for (var i = 0;
                                            i < CityRoute.route_taken.length;
                                            i++)
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Transform.translate(
                                                        offset: i == 0
                                                            ? const Offset(0, 5)
                                                            : const Offset(
                                                                0, 0),
                                                        child: MyCircle(
                                                          color: i !=
                                                                  CityRoute
                                                                          .route_taken
                                                                          .length -
                                                                      1
                                                              ? Colors.blue
                                                              : Colors.red,
                                                          getXY: (p0, p1) {},
                                                        ),
                                                      ),
                                                      if (i == 0)
                                                        Transform.translate(
                                                          offset: const Offset(
                                                              0, -15),
                                                          child: const Icon(
                                                            Icons.flag,
                                                            color: Colors.green,
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                  Text(
                                                      CityRoute.route_taken[i]),
                                                ],
                                              ),
                                              if (i !=
                                                  CityRoute.route_taken.length -
                                                      1)
                                                const Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Icon(Icons
                                                      .arrow_forward_sharp),
                                                ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            width: 700,
                            height: 610,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 30.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.asset(
                                        'assets/map.png',
                                        scale: 3.7,
                                        fit: BoxFit.none,
                                      ),
                                    ),
                                  ),
                                ),
                                Stack(
                                  children: cityWidgets,
                                ),
                                Stack(
                                  children: lines,
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          await resetApp();
                                        },
                                        child: const Text('Reset')),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (!CityRoute.cycle_available)
            Center(
              child: Container(
                width: 500,
                height: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Flexible(child: Image.asset('assets/logo.png')),
                    const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Text(
                        'No Cycle was found!',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ElevatedButton(
                          onPressed: resetApp,
                          child: const Text(
                            'Reset',
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.unknown,
      };
}
