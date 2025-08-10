// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MaxSubarraySum {
    // Function to find the maximum sum of a contiguous subarray
    function maxSubarraySum(int[] memory data) public pure returns (int) {
        int maxSoFar = data[0];
        int currentMax = data[0];

        for (uint i = 1; i < data.length; i++) {
            currentMax = max(data[i], currentMax + data[i]);
            maxSoFar = max(maxSoFar, currentMax);
        }

        return maxSoFar;
    }

    // Helper function to find the maximum of two integers
    function max(int a, int b) private pure returns (int) {
        return a > b ? a : b;
    }
}
