from itertools import combinations, groupby, islice
import networkx as nx
import matplotlib.pyplot as plt
import random
from math import gamma
import numpy as np

# Generate a custom graph
def generate_graph(nodes_list, edges_list):
    G = nx.Graph()
    
    G.add_nodes_from(nodes_list)
    G.add_edges_from(edges_list)
    
    return G


# Generate a number of possible solutions to extract the population from it + use it to extract random solution for the cuckoo algorithm to work with¶
''' extract an num_paths number of possible cycles using the networkx simple_cycles, wich returns all possible cycles to go from a start node and back into it.
    This function will garantie that all the paths in the returned list is a cycle but not a hamiltonian cycle.
    for that we will rely on cuckoo search algorithm to find the hamiltonian cycle! 
'''
def all_simple_cycles(graph, source_node, num_paths=3000):
    selected_paths = []
    path_counter = 0
    
    for path in nx.simple_cycles(graph):
        if path_counter >= num_paths:
                break
        elif path[0] == source_node:
            selected_paths.append(path)
            path_counter += 1

            
    
    return selected_paths

def all_simple_cycles2(graph, source_node, num_paths=3000):
    selected_paths = []
    path_counter = 0
    
    for path in nx.simple_cycles(graph):
        selected_paths.append(path)
        path_counter += 1
        
        if path_counter >= num_paths:
            break
    
    return selected_paths

# Fitness Function
'''
    Fitness Function will calculate the number of nodes nodes in the graph and substract the number of nodes in the path from it
    - example:
        - a graph contains 10 nodes and the path we are calculating the fitness contains 6 nodes:
            -> evaluate_fitness(graph, path) = 11-6 = 5
        - a graph contains 10 nodes and the path we are calculating the fitness contains 11 nodes([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0]):
            -> evaluate_fitness(graph, path) = 11-11 = 0 <--- n this case we have a cycle
'''
def evaluate_fitness(graph, path):
    graph_num_nodes = nx.number_of_nodes(graph) + 1
    num_nodes_in_path = len(path)
    
    solution_fitness = (graph_num_nodes - num_nodes_in_path)
    
    return solution_fitness


# Cuckoo Search ALgorithm
def cuckoo_search(graph, source, population_size=20, generations=300, Pa=0.10):

    # nbr of solution we are going to work with
    n = population_size
    max_iterations = generations
    
    # Number of bad solution to abandon (represents a 10% probability of host bird discovering that the eggs are not there's 
    # So they will totaly abandon there nests)
    num_to_abandon = int(Pa * n)
    
    # the number of solution we will use
    nbr_population = generations * 3

    # all_population = all_simple_cycles(graph, source, num_paths=9500)
    all_population = all_simple_cycles(graph, source, nbr_population)
    
    # this dictionary will store each path with its fitnes value
    solutions_fitness_dict = {}

    ## we will work with 50 possible solution
    population = all_population[:n]
    # the rest of the possible solutions we will work with them by generating new solutions from them.
    not_used_population = all_population[n:]

    best_path = None
    best_fitness = float('-inf')
    
#     # Evaluate fitness for each cuckoo's path
#     fitness_list = [evaluate_fitness(graph, path) for path in population]
    
#     print(fitness_list)

    # generation
    for generation in range(max_iterations):

        # Evaluate fitness for each cuckoo's path
        fitness_list = [evaluate_fitness(graph, path) for path in population]

        # # Find the index of the best cuckoo
        best_cuckoo_index = np.argmin(fitness_list)
        best_path = population[best_cuckoo_index]
        best_fitness = fitness_list[best_cuckoo_index]

        # here we will generate a new cuckoo solution (egg)
        # this should be upgraded from using random.choice -> to a function that walks using levy flights!   
        new_cuckoo = random.choice(not_used_population) 

        # calculate the fitness of the new solution
        new_cuckoo_fitness = evaluate_fitness(graph, new_cuckoo)

        # Choose a nest randomly ( a nest is a random spossible solution from the population )
        random_nest_index = random.randint(0, n - 1)

        # compare the fitness value of the new cuckoo egg and the randomly selected eg of the nest. the replace the solution if the new one is better
        if new_cuckoo_fitness < fitness_list[random_nest_index]:
            population[random_nest_index] = new_cuckoo
            not_used_population.remove(new_cuckoo)
            
        
        
    
        # In case we have an increased number of eggs in the nest, abandon a fraction Pa of worst nests. this is to mimic the fact that there is a probability of Pa for the host ird to figure out the cuckoo egg.
        if len(population) > n:
            num_to_abandon = int(Pa * n)
            indices_to_abandon = np.argpartition(fitness_list, num_to_abandon)[:num_to_abandon]
            for index in indices_to_abandon:
                population[index] = random.choice(not_used_population)


    # Convert the best path to a list of edge tuples
    best_path_edges = [(best_path[i], best_path[i + 1]) for i in range(len(best_path) - 1)]
    
#     print(f'Population List: {population}')
#     print(f'Fitness List: {fitness_list}')

    return best_path_edges, best_fitness


best_path_edges, best_fitness = cuckoo_search(graph=g, source=0)

print(f'best_path_edges: {best_path_edges}')
print(f'best_fitness: {best_fitness}')