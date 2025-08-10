// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MatrixOperations {
    function largestLocal(uint[][] memory grid) public pure returns (uint[][] memory) {
        uint n = grid.length;
        uint[][] memory maxLocal = new uint[][](n - 2);

        for (uint i = 0; i < n - 2; i++) {
            maxLocal[i] = new uint[](n - 2);
            for (uint j = 0; j < n - 2; j++) {
                uint maxVal = 0;
                // Iterate over the 3x3 submatrix
                for (uint k = 0; k < 3; k++) {
                    for (uint l = 0; l < 3; l++) {
                        uint val = grid[i + k][j + l];
                        if (val > maxVal) {
                            maxVal = val;
                        }
                    }
                }
                maxLocal[i][j] = maxVal;
            }
        }

        return maxLocal;
    }
}