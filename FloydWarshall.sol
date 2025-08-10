// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FloydWarshall {
    uint constant INF = 1e18;  // Representation of infinity since Solidity doesn't have native support for infinity

    // Function to perform the Floyd-Warshall algorithm
    function floydWarshall(uint[][] memory graph) public pure returns (uint[][] memory) {
        uint n = graph.length;
        uint[][] memory dist = new uint[][](n);

        // Initialize distance array
        for (uint i = 0; i < n; i++) {
            dist[i] = new uint[](n);
            for (uint j = 0; j < n; j++) {
                dist[i][j] = graph[i][j];
            }
        }

        // Floyd-Warshall algorithm
        for (uint k = 0; k < n; k++) {
            for (uint i = 0; i < n; i++) {
                for (uint j = 0; j < n; j++) {
                    if (dist[i][k] < INF && dist[k][j] < INF) { // Check if vertices are connected
                        uint newDist = dist[i][k] + dist[k][j];
                        if (newDist < dist[i][j]) {
                            dist[i][j] = newDist;
                        }
                    }
                }
            }
        }

        return dist;  // The matrix of distances
    }
}
