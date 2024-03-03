package com.example.CuckooCycleSolver;

class Edge {
    int source;
    int destination;

    public Edge(int source, int destination) {
        this.source = source;
        this.destination = destination;
    }

    @Override
    public String toString() {
        return "(" + source + ", " + destination + ")";
    }
}
