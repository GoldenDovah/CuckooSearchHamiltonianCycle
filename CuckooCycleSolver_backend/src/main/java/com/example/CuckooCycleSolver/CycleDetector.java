package com.example.CuckooCycleSolver;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class CycleDetector {
    private Graph graph;
    private List<List<Integer>> cycles;

    public CycleDetector(Graph graph) {
        this.graph = graph;
        this.cycles = new ArrayList<>();
    }

    //    public List<List<Integer>> getAllCycles() {
//        for (int node : graph.getNodes()) {
//            dfs(node, node, new ArrayList<>());
//        }
//        return cycles;
//    }
    public List<List<Integer>> getAllCycles() {
        for (int node : graph.getNodes()) {
            dfs(node, node, new ArrayList<>());
        }
        return addFirstElementToEnd(cycles);
    }

    private void dfs(int startNode, int currentNode, List<Integer> path) {
        path.add(currentNode);
        for (int neighbor : graph.getAdjacencyList().get(currentNode)) {
            if (neighbor == startNode && path.size() > 2) {
                cycles.add(new ArrayList<>(path));
            } else if (!path.contains(neighbor)) {
                dfs(startNode, neighbor, new ArrayList<>(path));
            }
        }
    }

    private List<List<Integer>> addFirstElementToEnd(List<List<Integer>> cycles) {
        List<List<Integer>> modifiedCycles = new ArrayList<>();
        for (List<Integer> cycle : cycles) {
            List<Integer> modifiedCycle = new ArrayList<>(cycle);
            modifiedCycle.add(cycle.get(0)); // Append the first element to the end
            modifiedCycles.add(modifiedCycle);
        }
        return modifiedCycles;
    }
}



