// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MaxRoadImportance {
    struct City {
        uint index;
        uint degree;
    }

    // This function assigns importance values to cities and calculates the maximum road importance
    function maximumImportance(uint n, uint[][] memory roads) public pure returns (uint) {
        // Array to store the degree of each city
        uint[] memory degrees = new uint[](n);
        
        // Calculate the degree of each city
        for (uint i = 0; i < roads.length; i++) {
            degrees[roads[i][0]]++;
            degrees[roads[i][1]]++;
        }
        
        // Sorting cities by degree in descending order (using a simple bubble sort for demonstration; replace with efficient sort for production)
        City[] memory cities = new City[](n);
        for (uint i = 0; i < n; i++) {
            cities[i] = City(i, degrees[i]);
        }

        // Bubble sort by degree
        for (uint i = 0; i < n - 1; i++) {
            for (uint j = 0; j < n - i - 1; j++) {
                if (cities[j].degree < cities[j + 1].degree) {
                    (cities[j], cities[j + 1]) = (cities[j + 1], cities[j]);
                }
            }
        }

        // Assign values to cities based on sorted order
        uint[] memory values = new uint[](n);
        for (uint i = 0; i < n; i++) {
            values[cities[i].index] = n - i; // Highest degree gets the highest value
        }

        // Calculate the total importance of all roads
        uint totalImportance = 0;
        for (uint i = 0; i < roads.length; i++) {
            totalImportance += values[roads[i][0]] + values[roads[i][1]];
        }
        
        return totalImportance;
    }
}
