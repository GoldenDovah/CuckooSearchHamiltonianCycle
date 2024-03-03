package com.example.CuckooCycleSolver;

import java.util.Arrays;

public class CitiesData {
    private String[] nodes;
    private String[][] edges;
    private String departing_node;
    private Integer pop_size;
    private Integer max_iter;
    private double prob;

    public String[] getNodes() {
        return nodes;
    }

    public void setNodes(String[] nodes) {
        this.nodes = nodes;
    }

    public String[][] getEdges() {
        return edges;
    }

    public void setEdges(String[][] edges) {
        this.edges = edges;
    }

    public String getDeparting_node() {
        return departing_node;
    }

    public void setDeparting_node(String departing_node) {
        this.departing_node = departing_node;
    }

    public Integer getPop_size() {
        return pop_size;
    }

    public void setPop_size(Integer pop_size) {
        this.pop_size = pop_size;
    }

    public Integer getMax_iter() {
        return max_iter;
    }

    public void setMax_iter(Integer max_iter) {
        this.max_iter = max_iter;
    }

    public double getProb() {
        return prob;
    }

    public void setProb(double prob) {
        this.prob = prob;
    }

    @Override
    public String toString() {
        return "CitiesData{" +
                "cities_array=" + Arrays.toString(nodes) +
                ", cities_connections=" + Arrays.deepToString(edges) +
                ", departing_node='" + departing_node + '\'' +
                ", population_size=" + pop_size +
                ", generations=" + max_iter +
                ", Pa=" + prob +
                '}';
    }
}

