package com.example.CuckooCycleSolver;

import java.util.*;

public class CSO {
    public Graph graph;
    public Integer source_node = 0;
    public Integer population_size = 5;
    public Integer generations = 10;
    public double Pa = 0.10;
    public Integer num_to_abandon;
    public Integer search_space_size = population_size * 3;
    public List<List<Integer>> search_space;
    public static Map<List<Integer>, Integer> population_hash_map= new HashMap<List<Integer>, Integer>();

    public List<List<Integer>> population_list;
    public List<List<Integer>> fitness_list;
    public List<List<Integer>> not_used_population;
    public List<Integer> best_path = null;
    public double best_fitness = Double.NEGATIVE_INFINITY;
    public int pos = 0;

    public CSO() {

    }

    public CSO(Graph graph, Integer source_node) {
        this.graph = graph;
        this.source_node = source_node;
    }

    public double getBest_fitness() {
        return best_fitness;
    }

    public CSO(Graph graph, Integer source_node, Integer population_size, Integer generations, Integer search_space_size, List<Integer> best_path, Integer best_fitness) {
        this.graph = graph;
        this.source_node = source_node;
        this.population_size = population_size;
        this.generations = generations;
        this.search_space_size = search_space_size;
        this.best_path = best_path;
        this.best_fitness = best_fitness;
    }

    public CSO(Graph graph, Integer source_node, Integer population_size, Integer generations, double pa) {
        this.graph = graph;
        this.source_node = source_node;
        this.population_size = population_size;
        this.generations = generations;
        Pa = pa;
    }

    public List<Integer> CSO_algorithm(){
        Random random = new Random();
        LevyFlightSimulation levyFlight = new LevyFlightSimulation();
        CycleDetector cycleDetector = new CycleDetector(graph);
        search_space = cycleDetector.getAllCycles();

        population_list = search_space.subList(0, population_size);
        not_used_population = search_space.subList(population_size, search_space.size());
        System.out.println("Population list: "+population_list);
        System.out.println("not_used_population list: "+not_used_population);

        List<Integer> positions_list = new ArrayList<>();

        for(int i =0; i<generations; i++) {
            // Create a temporary map to hold modifications
            Map<List<Integer>, Integer> tempPopulationMap = new HashMap<>();
            for(int j=0; j < population_list.size(); j++) {
                int fitness = evaluate_fitness(graph, population_list.get(j));
                tempPopulationMap.put(population_list.get(j), fitness);
            }

            // Perform modifications after the iteration is complete
            population_hash_map.putAll(tempPopulationMap);
            population_hash_map = sortByValue(population_hash_map);
            pos = levyFlight.getNewPosition(pos, 1, 1, not_used_population.size()-1);
            positions_list.add(pos);

            List<Integer> new_solution = not_used_population.get(pos);
            Integer new_solutions_fitness = evaluate_fitness(graph, new_solution);

            int count = 0;
            List<Integer> random_solution;
            Integer random_solution_fitness = null;
            int random_solution_index = random.nextInt(50);
            for (Map.Entry<List<Integer>, Integer> entry : population_hash_map.entrySet()) {
                if (count == random_solution_index) {
                    random_solution = entry.getKey();
                    random_solution_fitness = entry.getValue();
                    if(new_solutions_fitness < random_solution_fitness) {
                        population_hash_map.remove(random_solution);
                        population_hash_map.put(new_solution, new_solutions_fitness);
                    }
                    break; // Exit loop once the fifth pair is found
                }
                count++;
            }

            // here we should implement throwing Pa samples ad builting new ones!
            population_hash_map = sortByValue(population_hash_map);
            num_to_abandon = multiplyAndRound(Pa, population_size);


            for(int k = population_size-1; k> population_size-num_to_abandon; k--) {
                removeKeyAtPosition(population_hash_map, k);

                List<Integer> new_solution_to_fill_hashmap = not_used_population.get(pos);
                Integer new_solution_to_fill_hashmap_fitness = evaluate_fitness(graph, new_solution_to_fill_hashmap);
                population_hash_map.put(new_solution_to_fill_hashmap, new_solution_to_fill_hashmap_fitness);
            }

        }
        System.out.println("population_hash_map: "+population_hash_map);
        for (int i=0; i<5; i++){
            System.out.println("positions["+i+ "] =  "+positions_list.get(i)+"\n");
        }

        Map.Entry<List<Integer>, Integer> best_path_object = null;
        for (Map.Entry<List<Integer>, Integer> entry : population_hash_map.entrySet()) {
            best_path_object = entry;
            break; // Exit loop after obtaining the first entry
        }
        best_path = best_path_object.getKey();
        best_fitness = best_path_object.getValue();
        System.out.println("Number to abandan = "+num_to_abandon);
        return best_path;
    }


    private Integer evaluate_fitness(Graph graph, List<Integer> path) {
        int graph_num_nodes = graph.getNodes_number() + 2;
        int num_nodes_in_path = path.size();

        int firstElement = path.get(0);
        if(firstElement == source_node) {
            return graph_num_nodes - num_nodes_in_path;
        } else {
            return 1000;
        }
    }
    // The method below will be used to sort the fitness hashmap based on its value,
    public static <K, V extends Comparable<? super V>> Map<K, V> sortByValue(Map<K, V> map) {
        // Create a list from the entries of the map
        List<Map.Entry<K, V>> list = new LinkedList<>(map.entrySet());

        // Sort the list based on the values
        list.sort(new Comparator<Map.Entry<K, V>>() {
            @Override
            public int compare(Map.Entry<K, V> o1, Map.Entry<K, V> o2) {
                return o1.getValue().compareTo(o2.getValue());
            }
        });

        // Create a new LinkedHashMap to maintain the insertion order
        Map<K, V> sortedMap = new LinkedHashMap<>();
        for (Map.Entry<K, V> entry : list) {
            sortedMap.put(entry.getKey(), entry.getValue());
        }
        return sortedMap;
    }

    public static int multiplyAndRound(double a, int b) {
        double result = a * b;

        if (result <= 1) {
            return 1;
        } else {
            return Math.min((int) result, b);
        }
    }

    public static void removeKeyAtPosition(Map<List<Integer>, Integer> population_hash_map, int position) {
        int counter = 0;

        for (Map.Entry<List<Integer>, Integer> entry : CSO.population_hash_map.entrySet()) {
            if (counter == position) {
                List<Integer> random_solution = entry.getKey();
                CSO.population_hash_map.remove(random_solution);
                break; // Exit loop once the fifth pair is found
            }
            counter++;
        }
    }
}
