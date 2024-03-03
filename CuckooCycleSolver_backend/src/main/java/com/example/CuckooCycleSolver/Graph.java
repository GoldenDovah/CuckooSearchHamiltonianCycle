package com.example.CuckooCycleSolver;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Graph {
    private Map<Integer, List<Integer>> adjacencyList;
    private int nodes_number = 0;

    // Constructor
    public Graph() {
        adjacencyList = new HashMap<>();
    }

    // Method to add a node to the graph
    public void addNode(int node) {
        adjacencyList.put(node, new ArrayList<>());
        nodes_number ++;
    }

    public int getNodes_number() {
        return nodes_number;
    }

    public void setNodes_number(int nodes_number) {
        this.nodes_number = nodes_number;
    }

    // Method to add nodes from a list of nodes
    public void addNodes(List<Integer> nodes) {
        for (int node : nodes) {
            addNode(node);
        }
    }

    // Method to add an edge between two nodes
    public void addEdge(int source, int destination) {
        if (!adjacencyList.containsKey(source)) {
            addNode(source);
        }
        if (!adjacencyList.containsKey(destination)) {
            addNode(destination);
        }
        adjacencyList.get(source).add(destination);
        adjacencyList.get(destination).add(source); // For undirected graph
    }

    // Method to add edges from a list of edges
    public void addEdges(List<Edge> edges) {
        for (Edge edge : edges) {
            addEdge(edge.source, edge.destination);
        }
    }

    // Method to print the graph
    public void printGraph() {
        for (int node : adjacencyList.keySet()) {
            List<Integer> neighbors = adjacencyList.get(node);
            System.out.print("Node " + node + " is connected to: ");
            for (int neighbor : neighbors) {
                System.out.print(neighbor + " ");
            }
            System.out.println();
        }
    }

    // Method to get a list of nodes
    public List<Integer> getNodes() {
        return new ArrayList<>(adjacencyList.keySet());
    }

    // Method to get a list of edges
    public List<Edge> getEdges() {
        List<Edge> edges = new ArrayList<>();
        for (Map.Entry<Integer, List<Integer>> entry : adjacencyList.entrySet()) {
            int source = entry.getKey();
            for (int destination : entry.getValue()) {
                edges.add(new Edge(source, destination));
            }
        }
        return edges;
    }

    // Method to get the adjacency list
    public Map<Integer, List<Integer>> getAdjacencyList() {
        return adjacencyList;
    }
}
