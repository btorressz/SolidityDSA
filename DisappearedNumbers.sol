// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DisappearedNumbers {
    // Function to find all numbers that disappeared in the array
    function findDisappearedNumbers(int[] memory data) public pure returns (int[] memory) {
        uint n = data.length;
        int[] memory output = new int[](n);
        uint index = 0;

        // Mark each number that appears in the array
        for (uint i = 0; i < n; i++) {
            uint val = uint(data[i] < 0 ? -data[i] : data[i]); // Handle negative values from previous markings
            if (val <= n && data[val - 1] > 0) { // Check and mark only if it's positive
                data[val - 1] = -data[val - 1];
            }
        }

        // Find all positions that have not been marked
        for (uint i = 0; i < n; i++) {
            if (data[i] > 0) {
                output[index++] = int(i + 1);
            }
        }

        // Resize output array to match the number of disappeared numbers
        int[] memory disappearedNumbers = new int[](index);
        for (uint i = 0; i < index; i++) {
            disappearedNumbers[i] = output[i];
        }

        return disappearedNumbers;
    }
}
