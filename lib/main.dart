import 'package:cuckoosearchtsp/circle_painter.dart';
import 'package:cuckoosearchtsp/city.dart';
import 'package:cuckoosearchtsp/line.dart';
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
  List<List<Offset>> cityOffsets = [];
  List<Map<String, dynamic>> cities = [
    {'name': 'Tangier', 'side': 'Left', 'leftPadding': 430.0, 'topPadding': 3},
    {
      'name': 'Tetouan',
      'side': 'Right',
      'leftPadding': 515.0,
      'topPadding': 15
    },
    {'name': 'Nador', 'side': 'Right', 'leftPadding': 605.0, 'topPadding': 25},
    {'name': 'Oujda', 'side': 'Left', 'leftPadding': 605.0, 'topPadding': 60},
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
      'leftPadding': 265.0,
      'topPadding': 140
    },
    {
      'name': 'Casablanca',
      'side': 'Left',
      'leftPadding': 270.0,
      'topPadding': 165
    },
    {
      'name': 'El Jadida',
      'side': 'Left',
      'leftPadding': 270.0,
      'topPadding': 190
    },
    {'name': 'Settat', 'side': 'Left', 'leftPadding': 360.0, 'topPadding': 195},
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
            getXY: (x, y) {
              if (!(connectedCities.length == 1 &&
                  connectedCities[0][0] == x &&
                  connectedCities[0][1] == y)) {
                connectedCities.add([x, y]);
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
                        size: Size(300, 300),
                        painter: LinePainter(
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
                }
              }
            },
            resetColors: () async {
              setState(() {
                cityWidgets.clear();
              });
              await Future.delayed(Duration(microseconds: 1));
              setState(() {
                createCityWidgets();
              });
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text(
              "Hamiltonian Cycle with Cuckoo Search",
              style: TextStyle(fontSize: 26),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: const Text('Population Size'),
                                trailing: SizedBox(
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: SpinBox(
                                    min: 1,
                                    max: 20,
                                    value: 10,
                                    onChanged: (value) => print(value),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: const Text('Max Iterations'),
                                trailing: SizedBox(
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: SpinBox(
                                    min: 1,
                                    max: 2000,
                                    value: 1000,
                                    onChanged: (value) => print(value),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: const Text('Replacement Probability'),
                                trailing: SizedBox(
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: SpinBox(
                                    min: 1,
                                    max: 100,
                                    value: 50,
                                    onChanged: (value) => print(value),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
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
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset(
                                'assets/map.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Stack(
                              children: cityWidgets,
                            ),
                            Stack(
                              children: lines,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
