// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SafestPathInGrid {
    // Example grid structure. Real implementation would need input functions.
    uint constant n = 3;  // Assuming a smaller grid for simplicity
    int[n][n] grid;

    function setGrid(int[n][n] memory _grid) public {
        grid = _grid;
    }

    // Manhattan distance utility
    function manhattanDistance(uint x1, uint y1, uint x2, uint y2) internal pure returns (uint) {
        return (x1 > x2 ? x1 - x2 : x2 - x1) + (y1 > y2 ? y1 - y2 : y2 - y1);
    }

    // Find the safest path from (0, 0) to (n-1, n-1)
    function findSafestPath() public view returns (uint) {
        // Ideally, here would be the BFS that calculates minimum distances from thieves
        uint[n][n] memory minDistances = calculateMinDistances();
        // Then another BFS to calculate the safest path, maximizing the minimum safeness factor encountered
        return calculateMaxMinPath(minDistances);
    }

    // Pseudo-function for calculating minimum distances from any thief
    function calculateMinDistances() internal view returns (uint[n][n] memory minDistances) {
        // Initialization and BFS logic goes here
    }

    // Pseudo-function for calculating the path with maximum minimum safeness factor
    function calculateMaxMinPath(uint[n][n] memory minDistances) internal view returns (uint) {
        // Path-finding logic with BFS/DFS that maximizes the minimum distance encountered
    }
}
