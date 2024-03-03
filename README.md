# Hamiltonian Cycle Solver with Cuckoo Search Algorithm
<p align="center">
  <img src="https://github.com/GoldenDovah/CuckooSearchHamiltonianCycle/assets/19519174/e8c65a17-1dbf-472d-a277-bf2bc7845dd7" alt="logo" width="400px" height="400px">
</p>

## Overview
This project aims to solve the Hamiltonian cycle problem using the cuckoo search algorithm. The solution comprises a Flutter-based front-end for interactive graph construction and parameter setting and a Spring Boot-based back-end for executing the cuckoo search algorithm. Additionally, a comparison folder contains Java code for evaluating the time efficiency of both the cuckoo search and backtracking algorithms.
![Untitled design (1) (1)](https://github.com/GoldenDovah/CuckooSearchHamiltonianCycle/assets/19519174/c8c53d1f-6b5c-4486-bf01-1166f048dfc0)


## Getting Started
### Front-end (Flutter)
Ensure you have Flutter installed. If not, follow the Flutter installation guide.

Navigate to the cuckooCycleSolver_flutter directory.

Run the following commands:

```bash
flutter pub get
flutter run
```
This will launch the Flutter application on your local machine.

### Back-end (Spring Boot)
1. Ensure you have Java and Maven installed. If not, follow the Java installation guide and Maven installation guide.

2. Navigate to the cuckooCycleSolver_backend directory.

3. Run the following command to build the Spring Boot application:

```bash
mvn clean install
```

4. Run the following command to start the Spring Boot application:

```bash
java -jar target/cuckoo-cycle-solver-1.0.jar
```

Run the following commands to compile and execute the Java code:

## Usage
Access the Flutter front-end by launching the application on the web platform.

Use the interactive map to construct a graph, set algorithm parameters, and initiate the cuckoo search algorithm.
![Screenshot 2024-03-03 171132](https://github.com/GoldenDovah/CuckooSearchHamiltonianCycle/assets/19519174/caf0ee62-b00a-4682-a958-8c00095eac6c)

The solution, representing the Hamiltonian cycle, will be displayed on the map.
![cycle_not_found](https://github.com/GoldenDovah/CuckooSearchHamiltonianCycle/assets/19519174/260ff3fb-0b9d-4e1c-96db-2937b33081b6)
