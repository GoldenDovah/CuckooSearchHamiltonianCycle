package com.example.CuckooCycleSolver;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Main {
    public Map<String, Integer> cityIdMap = new HashMap<>();
    public int nextId = 0;
    public int source = 1;
    public String[] citiesArray;

    public String[][] citiesConnections;
    public String departingNode;

    public Integer populationSize = 5;
    public Integer generations = 20;
    public double pa = 0.10;
    public CitiesData citiesData;

    public Main(CitiesData citiesData) {
        this.citiesArray = citiesData.getNodes();
        this.citiesConnections = citiesData.getEdges();
        this.departingNode = citiesData.getDeparting_node();
        this.populationSize = citiesData.getPop_size();
        this.generations = citiesData.getMax_iter();
        this.pa = citiesData.getProb();
    }

    public List<Integer> convertToListOfIntegers(List<String> strings) {
        List<Integer> integers = new ArrayList<>();
        Map<String, Integer> stringToIntMap = new HashMap<>();

        // Assign an index to each unique string
        for (String str : strings) {
            if (!stringToIntMap.containsKey(str)) {
                stringToIntMap.put(str, nextId++);
            }
        }

        // Update cityIdMap with new mappings
        cityIdMap.putAll(stringToIntMap);

        // Convert strings to integers using the map
        for (String str : strings) {
            integers.add(stringToIntMap.get(str));
        }

        return integers;
    }

    public List<List<Integer>> convertListOfLists(List<List<String>> listOfLists) {
        List<List<Integer>> result = new ArrayList<>();
        for (List<String> innerList : listOfLists) {
            List<Integer> integerList = new ArrayList<>();
            for (String city : innerList) {
                integerList.add(cityIdMap.get(city));
            }
            result.add(integerList);
        }
        return result;
    }

    public List<String> getPath() {
        Map<String, Integer> cities_transformation_map = new HashMap<>();
        List<String> citiesList = new ArrayList<>();

        for (String str : citiesArray) {
            citiesList.add(str);
        }

        List<Integer> nodes_list = convertToListOfIntegers(citiesList);

        System.out.println("Nodes List:");
        System.out.println(nodes_list);

        for(int i=0; i<nodes_list.size(); i++) {
            cities_transformation_map.put(citiesArray[i], nodes_list.get(i));
        }
        source = cities_transformation_map.get(departingNode);
        System.out.println("Cities Hash Map");
        System.out.println(cities_transformation_map);

        List<List<String>> connections = new ArrayList<>();
        List<List<Integer>> edges_list = new ArrayList<>();

        for(int i=0; i<citiesConnections.length; i++) {
            List<Integer> temp_list = new ArrayList<>();
            for(int j=0; j<2; j++) {
                String citie_to_transform = citiesConnections[i][j];
                Integer city_id = cities_transformation_map.get(citie_to_transform);
                temp_list.add(city_id);
            }
            edges_list.add(temp_list);
        }
        System.out.println(edges_list);

        // *****************************************************************************************

        Graph graph = new Graph();

        // Adding nodes
//        List<Integer> nodes_list = List.of(1, 2, 3, 4);
        graph.addNodes(nodes_list);

        // Adding edges
//        List<Edge> edges_list = List.of(new Edge(1, 2), new Edge(1, 3), new Edge(1, 4),
//                new Edge(2, 3),new Edge(3, 4));
        List<Edge> edges = new ArrayList<>();
        for(int i=0; i<edges_list.size(); i++) {
            Integer source = edges_list.get(i).get(0);
            Integer destination = edges_list.get(i).get(1);
            Edge edge = new Edge(source, destination);
            edges.add(edge);
        }
        graph.addEdges(edges);

        // Printing the graph
        graph.printGraph();

        System.out.println("-------------------------------------- Solution Generator -------------------------");

        CycleDetector cycleDetector = new CycleDetector(graph);
        List<List<Integer>> cycles = cycleDetector.getAllCycles();

        // Print cycles
        System.out.println("Cycles found in the graph:");
        for (List<Integer> cycle : cycles) {
            System.out.println(cycle);
        }

        System.out.println("-------------------------------------- Edges List -------------------------");

        System.out.println(graph.getEdges());

        CSO cso = new CSO(graph, 0, populationSize, generations, pa);
        System.out.println(cso.getBest_fitness());

        List<Integer> best_path = cso.CSO_algorithm();


        List<String> stringList = new ArrayList<>();
        for (Integer value : best_path) {
            for (Map.Entry<String, Integer> entry : cities_transformation_map.entrySet()) {
                if (entry.getValue().equals(value)) {
                    stringList.add(entry.getKey());
                    break; // Once the key is found, exit the loop
                }
            }
        }

        if(best_path.size() == graph.getNodes_number() + 1 ) {
            System.out.println("The graph Contain a Hamiltonian Cycle: "+best_path);
            return stringList;
        } else {
            System.out.println("The graph doesn't contain a Hamiltonian Cycle, instead this cycle was found: "+best_path);
            return new ArrayList<>();
        }
    }

}
