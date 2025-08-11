// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Triangle {
    // Function to find the minimum path sum from top to bottom in a triangle array
    function minimumTotal(int[][] memory triangle) public pure returns (int) {
        uint n = triangle.length;
        int[] memory minPathSums = triangle[n-1]; // Start with the last row

        // Bottom-up calculation
        for (uint row = n - 2; row + 1 > 0; row--) { // Safe underflow for uint
            for (uint col = 0; col <= row; col++) {
                // Select the minimum of the two adjacent numbers in the row below
                minPathSums[col] = triangle[row][col] + 
                                   (minPathSums[col] < minPathSums[col + 1] ? minPathSums[col] : minPathSums[col + 1]);
            }
        }

        // The top element now contains the minimum path sum
        return minPathSums[0];
    }
}
