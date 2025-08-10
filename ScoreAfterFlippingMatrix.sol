// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ScoreAfterFlippingMatrix {
    // Function to return the highest possible score after toggling rows and columns
    function matrixScore(uint[][] memory grid) public pure returns (uint) {
        uint m = grid.length;
        uint n = grid[0].length;
        
        // Maximize the first column (MSB) to be all 1s by toggling rows as needed
        for (uint i = 0; i < m; i++) {
            if (grid[i][0] == 0) {
                // Toggle the row
                toggleRow(grid, i, n);
            }
        }

        // For each column from the second one, ensure it has as many 1s as possible
        for (uint j = 1; j < n; j++) {
            uint countOnes = 0;
            for (uint i = 0; i < m; i++) {
                if (grid[i][j] == 1) {
                    countOnes++;
                }
            }
            // If there are more 0s than 1s, toggle the column
            if (countOnes < m - countOnes) {
                toggleColumn(grid, j, m);
            }
        }

        // Calculate the score
        return calculateScore(grid, m, n);
    }

    // Toggle a row
    function toggleRow(uint[][] memory grid, uint row, uint n) private pure {
        for (uint j = 0; j < n; j++) {
            grid[row][j] = 1 - grid[row][j]; // Toggle between 1 and 0
        }
    }

    // Toggle a column
    function toggleColumn(uint[][] memory grid, uint col, uint m) private pure {
        for (uint i = 0; i < m; i++) {
            grid[i][col] = 1 - grid[i][col]; // Toggle between 1 and 0
        }
    }

    // Calculate the score of the matrix
    function calculateScore(uint[][] memory grid, uint m, uint n) private pure returns (uint score) {
        score = 0;
        for (uint i = 0; i < m; i++) {
            uint rowValue = 0;
            for (uint j = 0; j < n; j++) {
                rowValue = rowValue * 2 + grid[i][j];
            }
            score += rowValue;
        }
    }
}
