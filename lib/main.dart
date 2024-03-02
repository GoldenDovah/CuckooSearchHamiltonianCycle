import 'package:cuckoosearchtsp/circle.dart';
import 'package:cuckoosearchtsp/city.dart';
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
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 430.0,
                                top: 3,
                              ),
                              child: City(name: 'Tangier', side: 'Left'),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 515.0,
                                top: 15,
                              ),
                              child: City(name: 'Tetouan', side: 'Right'),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 605.0,
                                top: 25,
                              ),
                              child: City(name: 'Nador', side: 'Right'),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 605.0,
                                top: 60,
                              ),
                              child: City(name: 'Oujda', side: 'Left'),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 380.0,
                                top: 90,
                              ),
                              child: City(name: 'Kenitra', side: 'Left'),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 415.0,
                                top: 105,
                              ),
                              child: City(name: 'Sale', side: 'Right'),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 345.0,
                                top: 110,
                              ),
                              child: City(name: 'Rabat', side: 'Left'),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 500.0,
                                top: 110,
                              ),
                              child: City(name: 'Fez', side: 'Left'),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 570.0,
                                top: 90,
                              ),
                              child: City(name: 'Taza', side: 'Right'),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 440.0,
                                top: 125,
                              ),
                              child: City(name: 'Meknes', side: 'Left'),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 325.0,
                                top: 125,
                              ),
                              child: City(name: 'Temara', side: 'Left'),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 265.0,
                                top: 140,
                              ),
                              child: City(name: 'Mohammedia', side: 'Left'),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 270.0,
                                top: 165,
                              ),
                              child: City(name: 'Casablanca', side: 'Left'),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 270.0,
                                top: 190,
                              ),
                              child: City(name: 'El Jadida', side: 'Left'),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 360.0,
                                top: 195,
                              ),
                              child: City(name: 'Settat', side: 'Left'),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 440.0,
                                top: 200,
                              ),
                              child: City(name: 'Khouribga', side: 'Right'),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 390.0,
                                top: 250,
                              ),
                              child: City(name: 'Marrakesh', side: 'Right'),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 280.0,
                                top: 280,
                              ),
                              child: City(name: 'Agadir', side: 'Left'),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 240.0,
                                top: 350,
                              ),
                              child: City(name: 'Guelmim', side: 'Left'),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(
                                left: 170.0,
                                top: 410,
                              ),
                              child: City(name: 'Laayoune', side: 'Right'),
                            ),
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
