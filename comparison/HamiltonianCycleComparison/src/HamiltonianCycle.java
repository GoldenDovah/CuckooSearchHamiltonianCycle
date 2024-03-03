import java.util.*;

public class HamiltonianCycle {

    private List<Integer> nodes;
    private List<List<Integer>> edges;
    private List<Integer> path;
    private boolean[] visited;

    public HamiltonianCycle(List<Integer> nodes, List<List<Integer>> edges) {
        this.nodes = nodes;
        this.edges = edges;
        this.visited = new boolean[nodes.size()];
        this.path = new ArrayList<>();
    }

    public boolean hamiltonianCycle() {
        // Start from any node
        int startNode = nodes.get(0);
        path.add(startNode);
        visited[startNode] = true;

        if (!hamiltonianCycleUtil(startNode, 1)) {
            System.out.println("No Hamiltonian Cycle exists");
            return false;
        }

        printSolution();
        return true;
    }

    private boolean hamiltonianCycleUtil(int currentNode, int count) {
        // Base case: All nodes are visited
        if (count == nodes.size()) {
            // Check if there is an edge from the last node to the starting node
            int lastNode = path.get(path.size() - 1);
            for (List<Integer> edge : edges) {
                if (edge.get(0) == lastNode && edge.get(1) == path.get(0)) {
                    return true;
                }
            }
            return false;
        }

        for (List<Integer> edge : edges) {
            int nextNode = -1;
            if (edge.get(0) == currentNode && !visited[nextNode = edge.get(1)]) {
                visited[nextNode] = true;
                path.add(nextNode);

                if (hamiltonianCycleUtil(nextNode, count + 1)) {
                    return true;
                }

                // Backtrack
                visited[nextNode] = false;
                path.remove(path.size() - 1);
            } else if (edge.get(1) == currentNode && !visited[nextNode = edge.get(0)]) {
                visited[nextNode] = true;
                path.add(nextNode);

                if (hamiltonianCycleUtil(nextNode, count + 1)) {
                    return true;
                }

                // Backtrack
                visited[nextNode] = false;
                path.remove(path.size() - 1);
            }
        }

        return false;
    }

    private void printSolution() {
        System.out.println("Hamiltonian Cycle exists: ");
        for (int node : path) {
            System.out.print(node + " ");
        }
        System.out.println(path.get(0));
    }

    public static void main(String[] args) {
        List<Integer> nodes = Arrays.asList(0, 1, 2, 3, 4, 5);
        List<List<Integer>> edges = Arrays.asList(
                Arrays.asList(0, 1),
                Arrays.asList(1, 2),
                Arrays.asList(2, 3),
                Arrays.asList(3, 4),
                Arrays.asList(4, 5),
                Arrays.asList(5, 0)
        );

        HamiltonianCycle hc = new HamiltonianCycle(nodes, edges);
        long startTime = System.currentTimeMillis();
        hc.hamiltonianCycle();
        long endTime = System.currentTimeMillis();
        long duration = endTime - startTime;
        System.out.println("Execution time: " + duration + " milliseconds");
    }
}
