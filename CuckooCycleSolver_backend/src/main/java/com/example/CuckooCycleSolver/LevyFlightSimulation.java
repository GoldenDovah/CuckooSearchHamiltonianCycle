package com.example.CuckooCycleSolver;

import java.util.Random;

public class LevyFlightSimulation {

    public LevyFlightSimulation() {
    }

    public static double levyStablePDF(double t, int L) {
        double pdf;
        if (L == 1) {  // Lévy-Smirnov distribution
            double alpha = 3.0;  // Tail exponent parameter (increase for heavier tails)
            double beta = 0.3;   // Scale parameter (increase for more frequent large steps)
            pdf = (1 / Math.sqrt(2 * Math.PI)) * Math.pow(t - 0.5, -alpha / 2) * Math.exp(-beta / (2 * (t - 0.5)));
        } else if (L == 2) {  // Cauchy distribution
            double a = 0.1;      // Scale parameter (increase for more frequent large steps)
            pdf = (1 / Math.PI) * (1 / (a + Math.pow(t - 1, 2)));
        } else {
            throw new IllegalArgumentException("Invalid distribution type");
        }
        return pdf;
    }

    public static double[] takeLevySteps(int N, int L) {
        double[] steps = new double[N];
        double[] t = new double[10 * N];
        double[] s = new double[10 * N];

        for (int i = 0; i < 10 * N; i++) {
            t[i] = 0.51 + (50.0 - 0.51) * i / (10 * N - 1);
            s[i] = levyStablePDF(t[i], L);
        }

        double sum = 0;
        for (int i = 0; i < 10 * N; i++) {
            sum += s[i];
        }

        Random rand = new Random();
        for (int i = 0; i < N; i++) {
            double randValue = rand.nextDouble() * sum;
            double cumSum = 0;
            int j;
            for (j = 0; j < 10 * N && cumSum < randValue; j++) {
                cumSum += s[j];
            }
            steps[i] = t[j - 1];
        }

        return steps;
    }

    public static int getNewPosition(double x_0, int N, int L, int generations) {
        double[] steps = takeLevySteps(N, L);

        double pos = x_0;
        pos += steps[0];
        pos = Math.max(Math.min(pos, 100), 0);  // Ensure position stays within (0, 100)
        pos = (int) Math.round(pos);
        if(pos >= generations){
            return generations;
        } else {
            return (int) pos;
        }
    }

    public static void main(String[] args) {
        double x = 0;  // Starting position in 1D
        int N = 1000;  // Number of steps
        int L = 1;  // Levy flight type (1: Lévy-Smirnov, 2: Cauchy)

        for (int i = 0; i < 15; i++) {
            System.out.println(getNewPosition(x, N, L, i));
        }
    }
}
