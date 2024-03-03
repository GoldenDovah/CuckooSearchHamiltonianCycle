package com.example.CuckooCycleSolver;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.List;

public class CitiesDataResponse {

    private ObjectMapper objectMapper;
    private List<Integer> best_path;

    public List<Integer> getBest_path() {
        return best_path;
    }

    public void setBest_path(List<Integer> best_path) {
        this.best_path = best_path;
    }
}
