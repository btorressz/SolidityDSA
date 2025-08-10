// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MatrixSolver {
    function findMatrix(uint[] memory rowSum, uint[] memory colSum) public pure returns (uint[][] memory) {
        uint m = rowSum.length;
        uint n = colSum.length;
        
        uint[][] memory matrix = new uint[][](m);
        for (uint i = 0; i < m; i++) {
            matrix[i] = new uint[](n);
        }
        
        for (uint i = 0; i < m; i++) {
            for (uint j = 0; j < n; j++) {
                uint minVal = rowSum[i] < colSum[j] ? rowSum[i] : colSum[j];
                matrix[i][j] = minVal;
                rowSum[i] -= minVal;
                colSum[j] -= minVal;
            }
        }
        
        return matrix;
        
    }
}