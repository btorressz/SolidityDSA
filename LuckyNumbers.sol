// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LuckyNumbers {
    function findLuckyNumbers(int[][] memory matrix) public pure returns (int[] memory) {
        uint rows = matrix.length;
        uint cols = matrix[0].length;
        
        int[] memory minRowValues = new int[](rows);
        int[] memory maxColValues = new int[](cols);
        
        // Initialize arrays to extreme values
        for (uint i = 0; i < rows; i++) {
            minRowValues[i] = type(int).max;
        }
        for (uint j = 0; j < cols; j++) {
            maxColValues[j] = type(int).min;
        }
        
        // Find min values in each row and max values in each column
        for (uint i = 0; i < rows; i++) {
            for (uint j = 0; j < cols; j++) {
                if (matrix[i][j] < minRowValues[i]) {
                    minRowValues[i] = matrix[i][j];
                }
                if (matrix[i][j] > maxColValues[j]) {
                    maxColValues[j] = matrix[i][j];
                }
            }
        }
        
        // Find all lucky numbers
        int[] memory luckyNumbers = new int[](rows); // In the worst case, every row could have a lucky number
        uint count = 0;
        
        for (uint i = 0; i < rows; i++) {
            for (uint j = 0; j < cols; j++) {
                if (matrix[i][j] == minRowValues[i] && matrix[i][j] == maxColValues[j]) {
                    luckyNumbers[count] = matrix[i][j];
                    count++;
                }
            }
        }
        
        // Resize the array to the actual number of lucky numbers found
        int[] memory output = new int[](count);
        for (uint i = 0; i < count; i++) {
            output[i] = luckyNumbers[i];
        }
        
        return output;
    }
}
