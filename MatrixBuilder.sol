// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MatrixBuilder {
    function buildMatrix(uint k, uint[][] memory rowConditions, uint[][] memory colConditions) public pure returns (uint[][] memory) {
        // Create adjacency lists for row and column conditions
        uint[][] memory rowAdj = new uint[][](k + 1);
        uint[][] memory colAdj = new uint[][](k + 1);
        uint[] memory rowCounts = new uint[](k + 1);
        uint[] memory colCounts = new uint[](k + 1);

        // Count the number of edges for each node
        for (uint i = 0; i < rowConditions.length; i++) {
            rowCounts[rowConditions[i][0]]++;
        }
        for (uint i = 0; i < colConditions.length; i++) {
            colCounts[colConditions[i][0]]++;
        }

        // Initialize adjacency lists with correct sizes
        for (uint i = 1; i <= k; i++) {
            rowAdj[i] = new uint[](rowCounts[i]);
            colAdj[i] = new uint[](colCounts[i]);
        }

        // Fill adjacency lists
        uint[] memory rowIndexes = new uint[](k + 1);
        uint[] memory colIndexes = new uint[](k + 1);
        for (uint i = 0; i < rowConditions.length; i++) {
            uint from = rowConditions[i][0];
            rowAdj[from][rowIndexes[from]] = rowConditions[i][1];
            rowIndexes[from]++;
        }
        for (uint i = 0; i < colConditions.length; i++) {
            uint from = colConditions[i][0];
            colAdj[from][colIndexes[from]] = colConditions[i][1];
            colIndexes[from]++;
        }

        // Perform topological sort for rows and columns
        uint[] memory rowOrder = topologicalSort(k, rowAdj);
        uint[] memory colOrder = topologicalSort(k, colAdj);

        // If either sort failed, return empty matrix
        if (rowOrder.length == 0 || colOrder.length == 0) {
            return new uint[][](0);
        }

        // Build the matrix
        uint[][] memory matrix = new uint[][](k);
        for (uint i = 0; i < k; i++) {
            matrix[i] = new uint[](k);
        }

        for (uint i = 0; i < k; i++) {
            uint row = findIndex(rowOrder, i + 1);
            uint col = findIndex(colOrder, i + 1);
            matrix[row][col] = i + 1;
        }

        return matrix;
    }

    function topologicalSort(uint k, uint[][] memory adj) private pure returns (uint[] memory) {
        uint[] memory inDegree = new uint[](k + 1);
        for (uint i = 1; i <= k; i++) {
            for (uint j = 0; j < adj[i].length; j++) {
                inDegree[adj[i][j]]++;
            }
        }

        uint[] memory queue = new uint[](k);
        uint front = 0;
        uint rear = 0;

        for (uint i = 1; i <= k; i++) {
            if (inDegree[i] == 0) {
                queue[rear++] = i;
            }
        }

        uint[] memory result = new uint[](k);
        uint index = 0;

        while (front < rear) {
            uint node = queue[front++];
            result[index++] = node;

            for (uint i = 0; i < adj[node].length; i++) {
                uint neighbor = adj[node][i];
                if (--inDegree[neighbor] == 0) {
                    queue[rear++] = neighbor;
                }
            }
        }

        if (index != k) {
            return new uint[](0);  // Cycle detected
        }

        return result;
    }

    function findIndex(uint[] memory arr, uint val) private pure returns (uint) {
        for (uint i = 0; i < arr.length; i++) {
            if (arr[i] == val) {
                return i;
            }
        }
        revert("Value not found");
    }
}