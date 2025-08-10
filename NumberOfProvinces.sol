// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NumberOfProvinces {
    // Function to find the number of provinces using DFS
    function findCircleNum(int[][] memory isConnected) public pure returns (uint) {
        uint n = isConnected.length;
        bool[] memory visited = new bool[](n);
        uint provinceCount = 0;

        for (uint i = 0; i < n; i++) {
            if (!visited[i]) {
                dfs(isConnected, visited, i);
                provinceCount++; // Increment for each connected component found
            }
        }

        return provinceCount;
    }

    // Depth-First Search (DFS) helper function
    function dfs(int[][] memory isConnected, bool[] memory visited, uint city) internal pure {
        visited[city] = true;

        for (uint i = 0; i < isConnected.length; i++) {
            if (isConnected[city][i] == 1 && !visited[i]) {
                dfs(isConnected, visited, i);
            }
        }
    }
}
