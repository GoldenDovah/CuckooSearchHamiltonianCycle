package com.example.CuckooCycleSolver;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import java.util.List;

@SpringBootApplication
@RestController
public class CuckooCycleSolverBackendApplication {

	public static void main(String[] args) {
		SpringApplication.run(CuckooCycleSolverBackendApplication.class, args);
	}

	@PostMapping("/getPath")
	@CrossOrigin(origins = "*")
	public List<String> processCitiesData(@RequestBody CitiesData citiesData) {
		List<String> best_path;
		Main main = new Main(citiesData);

		String[] nodes = citiesData.getNodes();
		String[][] edges = citiesData.getEdges();
		String departing_node = citiesData.getDeparting_node();
		Integer pop_size = citiesData.getPop_size();
		Integer max_iter = citiesData.getMax_iter();
		double prob = citiesData.getProb();
		prob = prob/100;
		citiesData.setProb(prob);

		// Do something with the received data
		// For example, print them
		System.out.println("Cities Array: " + Arrays.toString(nodes));
		System.out.println("Cities Connections: " + Arrays.deepToString(edges));
		System.out.println("Departing Node: " + departing_node);
		System.out.println("Population Size: " + pop_size);
		System.out.println("Generations: " + max_iter);
		System.out.println("Pa: " + prob);

		best_path = main.getPath();
//		CitiesDataResponse response = new CitiesDataResponse();
//		response.setBest_path(best_path);

		return best_path;
//		return new ResponseEntity<>(response, HttpStatus.OK);
	}

	@CrossOrigin(origins = "*")
	@GetMapping("/test")
	public String testAPI() {
		return "Hello FLUTTER FROM SPRING";
//		return new ResponseEntity<>(response, HttpStatus.OK);
	}
}
